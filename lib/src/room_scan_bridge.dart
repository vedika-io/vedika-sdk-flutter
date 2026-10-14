/// Room scan bridge for Flutter.
///
/// The scan runs in a page (`mountRoomCapture`) inside a WebView. That page
/// posts `vedika.roomScanBridge/1` messages; [RoomScanController] reads
/// them, tracks the scan, uploads the finished capture and answers merge
/// requests. It imports no WebView package, so the app wires its own:
///
/// ```dart
/// final scan = RoomScanController(client: vedika);
/// final web = WebViewController()
///   ..setJavaScriptMode(JavaScriptMode.unrestricted)
///   ..addJavaScriptChannel('VedikaHost',
///       onMessageReceived: (m) => scan.handleMessage(m.message))
///   ..loadRequest(Uri.parse(scanPageUrl));
/// scan.inject = web.runJavaScript;
/// ```
///
/// Honest by construction: a capture only exists if the page sent one. On a
/// platform that cannot scan, call [RoomScanController.markUnsupported].
library;

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'client.dart';
import 'exceptions.dart';
import 'models/common.dart';

const roomScanBridgeSchema = 'vedika.roomScanBridge/1';
const roomCaptureSchema = 'vedika.roomCapture/1';

const _pageStates = {'unsupported', 'idle', 'requesting', 'active', 'ended', 'failed', 'captured', 'plan'};
final _idPattern = RegExp(r'^[\x21-\x7e]{1,128}$');
final _keyPattern = RegExp(r'^[\x21-\x7e]{1,256}$');

/// One classified message from the page. Anything unexpected is [RoomScanInvalid].
sealed class RoomScanMessage {
  const RoomScanMessage();
}

class RoomScanReady extends RoomScanMessage {
  const RoomScanReady();
}

class RoomScanStateMessage extends RoomScanMessage {
  final String state;
  const RoomScanStateMessage(this.state);
}

class RoomScanCaptureMessage extends RoomScanMessage {
  final Map<String, dynamic> capture;
  const RoomScanCaptureMessage(this.capture);
}

class RoomScanErrorMessage extends RoomScanMessage {
  final String message;
  const RoomScanErrorMessage(this.message);
}

class RoomScanMergeRequest extends RoomScanMessage {
  final String requestId;
  final String idempotencyKey;
  final Map<String, dynamic> body;
  const RoomScanMergeRequest(this.requestId, this.idempotencyKey, this.body);
}

class RoomScanInvalid extends RoomScanMessage {
  final String reason;
  const RoomScanInvalid(this.reason);
}

/// Classifies one message from the page. Never throws.
RoomScanMessage parseRoomScanMessage(Object? raw) {
  Object? msg = raw;
  if (raw is String) {
    try {
      msg = jsonDecode(raw);
    } catch (_) {
      return const RoomScanInvalid('not JSON');
    }
  }
  if (msg is! Map || msg['schema'] != roomScanBridgeSchema) {
    return const RoomScanInvalid('wrong schema');
  }
  switch (msg['type']) {
    case 'ready':
      return const RoomScanReady();
    case 'state':
      final state = msg['state'];
      return state is String && _pageStates.contains(state)
          ? RoomScanStateMessage(state)
          : const RoomScanInvalid('unknown state');
    case 'capture':
      final c = msg['capture'];
      if (c is Map &&
          c['schema'] == roomCaptureSchema &&
          c['captureId'] is String &&
          c['rooms'] is List &&
          c['quality'] is Map &&
          (c['quality'] as Map)['roomsTagged'] is num) {
        return RoomScanCaptureMessage(Map<String, dynamic>.from(c));
      }
      return const RoomScanInvalid('capture is not a vedika.roomCapture/1');
    case 'error':
      final m = msg['message'];
      return RoomScanErrorMessage(m is String ? m : 'room scan failed');
    case 'merge-request':
      final id = msg['requestId'];
      final key = msg['idempotencyKey'];
      final body = msg['body'];
      if (id is String && _idPattern.hasMatch(id) && key is String && _keyPattern.hasMatch(key) && body is Map) {
        return RoomScanMergeRequest(id, key, Map<String, dynamic>.from(body));
      }
      return const RoomScanInvalid('merge-request needs requestId, idempotencyKey and body');
    default:
      return const RoomScanInvalid('unknown type');
  }
}

/// Raised before any request when an upload or merge cannot be sent as given.
class RoomScanRefused implements Exception {
  final String message;
  const RoomScanRefused(this.message);
  @override
  String toString() => 'RoomScanRefused: $message';
}

/// `POST /v2/astrology/vastu/ar/room-capture` and `ar/capture-merge`.
class VastuRoomScanService {
  final VedikaClient _client;
  VastuRoomScanService(this._client);

  /// Uploads a `vedika.roomCapture/1`. Refuses an untagged capture (the API
  /// would, before any charge). Keep [idempotencyKey] across retries.
  Future<VedikaResponse<Map<String, dynamic>>> uploadRoomCapture(
    Map<String, dynamic> capture, {
    int? zoneResolution,
    String? idempotencyKey,
  }) async {
    final quality = capture['quality'];
    final tagged = quality is Map ? quality['roomsTagged'] : null;
    if (capture['schema'] != roomCaptureSchema) {
      throw const RoomScanRefused('capture must be a $roomCaptureSchema object from the room scan');
    }
    if (tagged is! num || tagged < 1) {
      throw const RoomScanRefused('Tag at least one room before uploading: the API refuses a capture with no labelled room');
    }
    if (zoneResolution != null && ![8, 16, 32].contains(zoneResolution)) {
      throw const RoomScanRefused('zoneResolution must be 8, 16 or 32');
    }
    return VedikaResponse.fromJson(
        await _client.post('/v2/astrology/vastu/ar/room-capture',
            {'capture': capture, if (zoneResolution != null) 'zoneResolution': zoneResolution},
            idempotencyKey: idempotencyKey),
        (data) => Map<String, dynamic>.from(data as Map));
  }

  /// Merges floor captures. Billed, so a caller-retained [idempotencyKey] is
  /// mandatory: a retry with the same key replays the first result.
  Future<VedikaResponse<Map<String, dynamic>>> mergeCaptures(
    Map<String, dynamic> request, {
    required String idempotencyKey,
  }) async {
    if (!_keyPattern.hasMatch(idempotencyKey)) {
      throw const RoomScanRefused('A caller-retained idempotencyKey (1-256 visible ASCII characters) is required to merge captures');
    }
    return VedikaResponse.fromJson(
        await _client.post('/v2/astrology/vastu/ar/capture-merge', request, idempotencyKey: idempotencyKey),
        (data) => Map<String, dynamic>.from(data as Map));
  }
}

enum RoomScanPhase { idle, scanning, captured, uploading, uploaded, cancelled, unsupported, failed }

class RoomScanSnapshot {
  final RoomScanPhase phase;
  final Map<String, dynamic>? capture;
  final VedikaResponse<Map<String, dynamic>>? result;

  /// Idempotency key the upload used; kept so a retry of the same capture reuses it.
  final String? uploadKey;
  final String? error;
  const RoomScanSnapshot(this.phase, {this.capture, this.result, this.uploadKey, this.error});
}

String _literal(Object? value) =>
    jsonEncode(value).replaceAll('\u2028', r'\u2028').replaceAll('\u2029', r'\u2029');

String resolveMergeScript(String requestId, Object? result) =>
    'window.__vedikaRoomCaptureHost&&window.__vedikaRoomCaptureHost.resolveMerge(${_literal(requestId)},${_literal(result)});true;';

String rejectMergeScript(String requestId, {int? status, required String message}) =>
    'window.__vedikaRoomCaptureHost&&window.__vedikaRoomCaptureHost.rejectMerge(${_literal(requestId)},${_literal({if (status != null) 'status': status, 'message': message})});true;';

String _randomKey() {
  final r = Random.secure();
  final hex = List.generate(16, (_) => r.nextInt(256).toRadixString(16).padLeft(2, '0')).join();
  return 'room-$hex';
}

/// Drives one room scan from the page's messages. Feed it every WebView message
/// through [handleMessage]; listen on [changes] (or read [snapshot]).
class RoomScanController {
  final VastuRoomScanService _service;
  final String Function() _newKey;
  final int? zoneResolution;

  /// Runs JavaScript in the WebView (`WebViewController.runJavaScript`). Needed to answer merges.
  FutureOr<void> Function(String script)? inject;

  RoomScanSnapshot _state = const RoomScanSnapshot(RoomScanPhase.idle);
  final _changes = StreamController<RoomScanSnapshot>.broadcast(sync: true);
  final _mergeFlights = <String, Future<void>>{};

  RoomScanController({
    required VedikaClient client,
    this.inject,
    this.zoneResolution,
    String Function()? newIdempotencyKey,
  })  : _service = VastuRoomScanService(client),
        _newKey = newIdempotencyKey ?? _randomKey;

  RoomScanSnapshot get snapshot => _state;
  Stream<RoomScanSnapshot> get changes => _changes.stream;

  void _set(RoomScanSnapshot next) {
    _state = next;
    _changes.add(next);
  }

  Future<void> handleMessage(Object? raw) {
    final msg = parseRoomScanMessage(raw);
    switch (msg) {
      case RoomScanStateMessage(:final state):
        if (_state.capture != null) break; // a held capture is never taken back
        switch (state) {
          case 'unsupported':
            _set(const RoomScanSnapshot(RoomScanPhase.unsupported));
          case 'requesting' || 'active':
            _set(const RoomScanSnapshot(RoomScanPhase.scanning));
          case 'ended':
            _set(const RoomScanSnapshot(RoomScanPhase.cancelled));
          case 'failed':
            _set(const RoomScanSnapshot(RoomScanPhase.failed, error: 'The scan could not continue.'));
          case 'idle':
            _set(const RoomScanSnapshot(RoomScanPhase.idle));
        }
      case RoomScanCaptureMessage(:final capture):
        _set(RoomScanSnapshot(RoomScanPhase.captured, capture: capture));
      case RoomScanErrorMessage(:final message):
        _set(RoomScanSnapshot(_state.capture != null ? _state.phase : RoomScanPhase.failed,
            capture: _state.capture, uploadKey: _state.uploadKey, error: message));
      case RoomScanMergeRequest():
        // The same request id again (a page retry) joins the call already in flight.
        return _mergeFlights[msg.requestId] ??= _merge(msg).whenComplete(() {
          _mergeFlights.remove(msg.requestId);
        });
      case RoomScanReady() || RoomScanInvalid():
        break;
    }
    return Future.value();
  }

  Future<void> _merge(RoomScanMergeRequest req) async {
    final run = inject;
    if (run == null) return;
    try {
      final res = await _service.mergeCaptures(req.body, idempotencyKey: req.idempotencyKey);
      await run(resolveMergeScript(req.requestId, {
        'success': res.success,
        'data': res.data,
        if (res.error != null) 'error': res.error,
      }));
    } on VedikaApiError catch (e) {
      await run(rejectMergeScript(req.requestId, status: e.statusCode, message: e.message));
    } on RoomScanRefused catch (e) {
      await run(rejectMergeScript(req.requestId, message: e.message));
    } catch (e) {
      await run(rejectMergeScript(req.requestId, message: 'merge failed'));
    }
  }

  /// The user closed the scan before a capture existed. No-op once one is held.
  void cancel() {
    if (_state.capture == null && _state.phase != RoomScanPhase.unsupported) {
      _set(const RoomScanSnapshot(RoomScanPhase.cancelled));
    }
  }

  /// No WebView or no scanning on this platform.
  void markUnsupported([String? reason]) => _set(RoomScanSnapshot(RoomScanPhase.unsupported, error: reason));

  /// Hands in a capture a native scanner (RoomPlan, ARCore) produced instead of
  /// the WebView page. It must be a `vedika.roomCapture/1`; anything else throws
  /// [RoomScanRefused] and stores nothing.
  void acceptCapture(Map<String, dynamic> capture) {
    final msg = parseRoomScanMessage({'schema': roomScanBridgeSchema, 'type': 'capture', 'capture': capture});
    if (msg is! RoomScanCaptureMessage) {
      throw const RoomScanRefused('Not a $roomCaptureSchema capture; nothing was stored.');
    }
    _set(RoomScanSnapshot(RoomScanPhase.captured, capture: msg.capture));
  }

  /// Uploads the held capture. Retrying reuses the same idempotency key.
  Future<VedikaResponse<Map<String, dynamic>>> upload() async {
    final capture = _state.capture;
    if (capture == null) throw const RoomScanRefused('No room scan to upload: finish a scan first.');
    if (_state.phase == RoomScanPhase.uploading) throw const RoomScanRefused('Upload already in progress.');
    final tagged = (capture['quality'] as Map)['roomsTagged'] as num;
    if (tagged < 1) {
      throw const RoomScanRefused('Tag at least one room before uploading: the API refuses a capture with no labelled room.');
    }
    final key = _state.uploadKey ?? _newKey();
    _set(RoomScanSnapshot(RoomScanPhase.uploading, capture: capture, uploadKey: key));
    try {
      final res = await _service.uploadRoomCapture(capture, zoneResolution: zoneResolution, idempotencyKey: key);
      _set(RoomScanSnapshot(RoomScanPhase.uploaded, capture: capture, uploadKey: key, result: res));
      return res;
    } catch (e) {
      // Keep the capture and the key: the next upload() is the same logical call.
      _set(RoomScanSnapshot(RoomScanPhase.captured,
          capture: capture, uploadKey: key, error: e is VedikaApiError ? e.message : e.toString()));
      rethrow;
    }
  }

  /// Back to idle for a new scan; drops the capture and its key.
  void reset() => _set(const RoomScanSnapshot(RoomScanPhase.idle));

  Future<void> dispose() => _changes.close();
}
