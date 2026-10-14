import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:vedika_sdk/vedika_sdk.dart';

// Shared with the web page tests and the React bridge tests; present in the monorepo only.
final _file = File('../fixtures/room-scan-bridge/messages.json');
final String? _skip =
    _file.existsSync() ? null : 'monorepo fixture sdks/fixtures/room-scan-bridge/messages.json not present';
Map<String, dynamic> get fx => jsonDecode(_file.readAsStringSync()) as Map<String, dynamic>;
Map<String, dynamic> get valid => Map<String, dynamic>.from(fx['validCapture'] as Map);
Map<String, dynamic> get untagged => Map<String, dynamic>.from(fx['untaggedCapture'] as Map);
String mergeRaw() =>
    (fx['parseCases'] as List).firstWhere((c) => c['name'] == 'merge request')['raw'] as String;
String msg(Map<String, dynamic> m) => jsonEncode({'schema': roomScanBridgeSchema, ...m});

class Rig {
  final seen = <http.Request>[];
  late final VedikaClient client;
  Rig(http.Response Function(int n, http.Request r) respond) {
    client = VedikaClient(
        apiKey: 'scan-test',
        httpClient: MockClient((r) async {
          seen.add(r);
          return respond(seen.length, r);
        }));
  }
}

http.Response ok(Object body) =>
    http.Response(jsonEncode(body), 200, headers: {'content-type': 'application/json'});

void main() {
  test('fixture schema is the bridge schema', () => expect(fx['schema'], roomScanBridgeSchema), skip: _skip);

  test('every shared parse case classifies the same way as the web and React bridges', () {
    for (final c in (fx['parseCases'] as List)) {
      final got = parseRoomScanMessage(c['raw']);
      final expectKind = c['expect']['kind'] as String;
      final kind = switch (got) {
        RoomScanReady() => 'ready',
        RoomScanStateMessage() => 'state',
        RoomScanCaptureMessage() => 'capture',
        RoomScanErrorMessage() => 'error',
        RoomScanMergeRequest() => 'merge-request',
        RoomScanInvalid() => 'invalid',
      };
      expect(kind, expectKind, reason: c['name'] as String);
      if (got is RoomScanStateMessage) expect(got.state, c['expect']['state']);
      if (got is RoomScanCaptureMessage) expect(got.capture['captureId'], c['expect']['captureId']);
      if (got is RoomScanErrorMessage) expect(got.message, c['expect']['message']);
      if (got is RoomScanMergeRequest) {
        expect(got.requestId, c['expect']['requestId']);
        expect(got.idempotencyKey, c['expect']['idempotencyKey']);
      }
    }
  }, skip: _skip);

  test('parse never throws on junk', () {
    for (final junk in [null, 5, <int>[], <String, dynamic>{}, '', '{', msg({})]) {
      expect(parseRoomScanMessage(junk), isA<RoomScanInvalid>());
    }
  });

  test('scan then upload: typed result, one idempotency key kept across a failed retry', () async {
    final rig = Rig((n, r) => n == 1
        ? http.Response(jsonEncode({'success': false, 'error': 'down'}), 503, headers: {'content-type': 'application/json'})
        : ok({'success': true, 'data': {'zones': 8}}));
    var minted = 0;
    final ctl = RoomScanController(client: rig.client, zoneResolution: 16, newIdempotencyKey: () => 'key-${++minted}-padding');
    final phases = <RoomScanPhase>[];
    ctl.changes.listen((s) => phases.add(s.phase));
    await ctl.handleMessage(msg({'type': 'ready'}));
    await ctl.handleMessage(msg({'type': 'state', 'state': 'active'}));
    expect(ctl.snapshot.phase, RoomScanPhase.scanning);
    await ctl.handleMessage(msg({'type': 'capture', 'capture': valid}));
    expect(ctl.snapshot.phase, RoomScanPhase.captured);
    await ctl.handleMessage(msg({'type': 'state', 'state': 'ended'}));
    expect(ctl.snapshot.phase, RoomScanPhase.captured, reason: 'a later ended state keeps a held capture');

    await expectLater(ctl.upload(), throwsA(isA<VedikaApiError>()));
    expect(ctl.snapshot.phase, RoomScanPhase.captured);
    expect(ctl.snapshot.capture!['captureId'], valid['captureId']);
    final res = await ctl.upload();
    expect(res.success, isTrue);
    expect(res.data, {'zones': 8});
    expect(ctl.snapshot.phase, RoomScanPhase.uploaded);
    expect(minted, 1);
    expect(rig.seen.map((r) => r.headers['Idempotency-Key']), ['key-1-padding', 'key-1-padding']);
    expect(rig.seen.map((r) => r.url.path), everyElement('/v2/astrology/vastu/ar/room-capture'));
    final body = jsonDecode(rig.seen.last.body) as Map<String, dynamic>;
    expect(body['capture'], valid);
    expect(body['zoneResolution'], 16);
    expect(phases.where((p) => p == RoomScanPhase.uploading).length, 2);
  }, skip: _skip);

  test('a new scan after reset gets a new key', () async {
    final rig = Rig((n, r) => ok({'success': true, 'data': {}}));
    var minted = 0;
    final ctl = RoomScanController(client: rig.client, newIdempotencyKey: () => 'key-${++minted}-padding');
    await ctl.handleMessage(msg({'type': 'capture', 'capture': valid}));
    await ctl.upload();
    ctl.reset();
    await ctl.handleMessage(msg({'type': 'capture', 'capture': fx['magneticCapture']}));
    await ctl.upload();
    expect(rig.seen.map((r) => r.headers['Idempotency-Key']), ['key-1-padding', 'key-2-padding']);
  }, skip: _skip);

  test('untagged capture is held but never uploaded', () async {
    final rig = Rig((n, r) => ok({'success': true}));
    final ctl = RoomScanController(client: rig.client);
    await ctl.handleMessage(msg({'type': 'capture', 'capture': untagged}));
    expect(ctl.snapshot.phase, RoomScanPhase.captured);
    await expectLater(ctl.upload(), throwsA(isA<RoomScanRefused>()));
    expect(rig.seen, isEmpty);
  }, skip: _skip);

  test('upload with nothing scanned is refused', () async {
    final ctl = RoomScanController(client: Rig((n, r) => ok({})).client);
    await expectLater(ctl.upload(), throwsA(isA<RoomScanRefused>()));
  });

  test('cancellation and unsupported platforms', () async {
    final ctl = RoomScanController(client: Rig((n, r) => ok({})).client);
    await ctl.handleMessage(msg({'type': 'state', 'state': 'active'}));
    await ctl.handleMessage(msg({'type': 'state', 'state': 'ended'}));
    expect(ctl.snapshot.phase, RoomScanPhase.cancelled);
    expect(ctl.snapshot.capture, isNull);
    ctl.reset();
    await ctl.handleMessage(msg({'type': 'capture', 'capture': valid}));
    ctl.cancel();
    expect(ctl.snapshot.phase, RoomScanPhase.captured, reason: 'cancel is a no-op once a capture is held');

    final page = RoomScanController(client: Rig((n, r) => ok({})).client);
    await page.handleMessage(msg({'type': 'state', 'state': 'unsupported'}));
    page.cancel();
    expect(page.snapshot.phase, RoomScanPhase.unsupported);
    final app = RoomScanController(client: Rig((n, r) => ok({})).client)..markUnsupported('no WebView on this platform');
    expect(app.snapshot.phase, RoomScanPhase.unsupported);
    expect(app.snapshot.error, 'no WebView on this platform');
  }, skip: _skip);

  test('page errors surface without inventing a capture; invalid messages change nothing', () async {
    final ctl = RoomScanController(client: Rig((n, r) => ok({})).client);
    await ctl.handleMessage('hello');
    await ctl.handleMessage(msg({'type': 'capture', 'capture': {'schema': 'other'}}));
    expect(ctl.snapshot.phase, RoomScanPhase.idle);
    await ctl.handleMessage(msg({'type': 'error', 'message': 'AR session refused'}));
    expect(ctl.snapshot.phase, RoomScanPhase.failed);
    expect(ctl.snapshot.error, 'AR session refused');
    expect(ctl.snapshot.capture, isNull);
  });

  test('merge request keeps the page key and answers the page', () async {
    final rig = Rig((n, r) => ok({'success': true, 'data': {'floors': 1}}));
    final injected = <String>[];
    final ctl = RoomScanController(client: rig.client, inject: injected.add);
    await ctl.handleMessage(mergeRaw());
    expect(rig.seen.single.url.path, '/v2/astrology/vastu/ar/capture-merge');
    expect(rig.seen.single.headers['Idempotency-Key'], 'idem-0001');
    expect(jsonDecode(rig.seen.single.body), fx['mergeBody']);
    expect(injected.single, resolveMergeScript('m-1', {'success': true, 'data': {'floors': 1}}));
  }, skip: _skip);

  test('merge failure is passed back with status and message', () async {
    final rig = Rig((n, r) => http.Response(jsonEncode({'success': false, 'error': 'insufficient balance'}), 402,
        headers: {'content-type': 'application/json'}));
    final injected = <String>[];
    final ctl = RoomScanController(client: rig.client, inject: injected.add);
    await ctl.handleMessage(mergeRaw());
    expect(injected.single, contains('rejectMerge("m-1"'));
    expect(injected.single, contains('"status":402'));
  }, skip: _skip);

  test('a merge request retried while in flight is one call', () async {
    final gate = Completer<void>();
    final seen = <http.Request>[];
    final client = VedikaClient(
        apiKey: 'scan-test',
        httpClient: MockClient((r) async {
          seen.add(r);
          await gate.future;
          return ok({'success': true, 'data': {}});
        }));
    final injected = <String>[];
    final ctl = RoomScanController(client: client, inject: injected.add);
    final a = ctl.handleMessage(mergeRaw());
    final b = ctl.handleMessage(mergeRaw());
    gate.complete();
    await Future.wait([a, b]);
    expect(seen.length, 1);
    expect(injected.length, 1);
  }, skip: _skip);

  test('merge without an inject hook does not call the API', () async {
    final rig = Rig((n, r) => ok({}));
    await RoomScanController(client: rig.client).handleMessage(mergeRaw());
    expect(rig.seen, isEmpty);
  }, skip: _skip);

  test('service refuses a merge without a valid key and a bad capture before any request', () async {
    final rig = Rig((n, r) => ok({}));
    final svc = VastuRoomScanService(rig.client);
    for (final key in ['', 'has space', 'x' * 257]) {
      await expectLater(svc.mergeCaptures({}, idempotencyKey: key), throwsA(isA<RoomScanRefused>()));
    }
    await expectLater(svc.uploadRoomCapture({'schema': 'x'}), throwsA(isA<RoomScanRefused>()));
    expect(rig.seen, isEmpty);
  });

  test('a native scanner can hand in a capture; junk is refused and stores nothing', () async {
    final rig = Rig((n, r) => ok({'success': true, 'data': {}}));
    final ctl = RoomScanController(client: rig.client, newIdempotencyKey: () => 'native-key-0001');
    expect(() => ctl.acceptCapture({'schema': 'other'}), throwsA(isA<RoomScanRefused>()));
    expect(ctl.snapshot.phase, RoomScanPhase.idle);
    ctl.acceptCapture(valid);
    expect(ctl.snapshot.phase, RoomScanPhase.captured);
    await ctl.upload();
    expect(rig.seen.single.headers['Idempotency-Key'], 'native-key-0001');
    expect(jsonDecode(rig.seen.single.body), {'capture': valid});
  }, skip: _skip);

  test('injected script literals survive line separators', () {
    final s = resolveMergeScript('m"1', {'t': 'a\u2028b\u2029c'});
    expect(s.contains('\u2028') || s.contains('\u2029'), isFalse);
    expect(s.endsWith(';true;'), isTrue);
    expect(s.contains(r'a\u2028b\u2029c'), isTrue);
  });
}
