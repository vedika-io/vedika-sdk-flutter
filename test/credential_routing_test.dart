import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:vedika_sdk/vedika_sdk.dart';

// The 11 GET-only reference tables + the GET+POST dual, from the Rust router
// (VASTU_GET_REFERENCE_ROUTES + VASTU_DUAL_ROUTE in vedika-v2/src/vastu.rs).
const getOps = [
  'reference/directions/8',
  'reference/directions/16',
  'reference/directions/32',
  'reference/mandala/9-zone',
  'reference/mandala/45-devatas',
  'reference/mandala/64-pada',
  'reference/defects/catalog',
  'reference/remedies/catalog',
  'reference/colors-by-zone',
  'reference/materials-by-zone',
  'reference/gate-obstructions',
  'direction/declination',
];
const postOps = [
  'score/overall',
  'placement/borewell',
  'entrance/pada',
  'plan/analyze'
];

http.Response _ok() => http.Response(
      '{"success":true,"data":{"ok":true}}',
      200,
      headers: {'content-type': 'application/json'},
    );

void main() {
  test(
      'vastu verb parity: reference/* and direction/declination GET, others POST',
      () async {
    final captured = <http.BaseRequest>[];
    final mock = MockClient((request) async {
      captured.add(request);
      return _ok();
    });
    final client = VedikaClient(apiKey: 'vk_test_x', httpClient: mock);

    for (final op in getOps) {
      await client.astrology.vastu(op, {'lat': 1, 'lon': 2});
    }
    for (final op in postOps) {
      await client.astrology.vastu(op, {'zone': 'north'});
    }

    for (var i = 0; i < getOps.length; i++) {
      expect(captured[i].method, 'GET', reason: getOps[i]);
      expect(captured[i].url.path, '/v2/astrology/vastu/${getOps[i]}');
    }
    for (var i = 0; i < postOps.length; i++) {
      final r = captured[getOps.length + i];
      expect(r.method, 'POST', reason: postOps[i]);
      expect(r.url.path, '/v2/astrology/vastu/${postOps[i]}');
    }
    client.dispose();
  });

  test('every request disables redirect following', () async {
    late http.BaseRequest seen;
    final mock = MockClient((request) async {
      seen = request;
      return _ok();
    });
    final client = VedikaClient(apiKey: 'k', httpClient: mock);
    await client.astrology.vastu('score/overall', {'zone': 'north'});
    expect(seen.followRedirects, isFalse);
    client.dispose();
  });

  test('an unfollowed 3xx surfaces as an error, not a chased redirect', () {
    final mock = MockClient((request) async => http.Response(
          '',
          302,
          headers: {'location': 'http://evil.example/collect'},
        ));
    final client = VedikaClient(apiKey: 'k', httpClient: mock);
    expect(
      () => client.astrology.vastu('score/overall', {'zone': 'north'}),
      throwsA(isA<VedikaApiError>()),
    );
    client.dispose();
  });

  test('the API key is never forwarded across a real cross-origin redirect',
      () async {
    final collector = await HttpServer.bind('127.0.0.1', 0);
    String? seenAuth;
    collector.listen((req) async {
      seenAuth = req.headers.value('authorization');
      req.response
        ..statusCode = 200
        ..headers.contentType = ContentType.json
        ..write('{"success":true,"data":{"ok":true}}');
      await req.response.close();
    });

    final redirector = await HttpServer.bind('127.0.0.1', 0);
    redirector.listen((req) async {
      req.response
        ..statusCode = 302
        ..headers.set('location', 'http://127.0.0.1:${collector.port}/collect');
      await req.response.close();
    });

    final client = VedikaClient(
      apiKey: 'vk_test_secret',
      baseUrl: 'http://127.0.0.1:${redirector.port}',
    );
    try {
      await client.astrology.vastu('score/overall', {'zone': 'north'});
    } catch (_) {
      // followRedirects=false -> the 302 surfaces as an error; expected.
    } finally {
      await collector.close(force: true);
      await redirector.close(force: true);
      client.dispose();
    }

    // The redirect target must never have been reached with the key.
    expect(seenAuth, isNull);
  });

  test('base_url origin policy', () {
    expect(() => VedikaClient(apiKey: 'k', baseUrl: 'https://api.vedika.io'),
        returnsNormally);
    expect(() => VedikaClient(apiKey: 'k', baseUrl: 'http://127.0.0.1:8080'),
        returnsNormally);
    expect(() => VedikaClient(apiKey: 'k', baseUrl: 'http://api.vedika.io'),
        throwsArgumentError);
    // Spoof hosts that merely START with "127." are NOT loopback -> rejected.
    expect(
        () => VedikaClient(apiKey: 'k', baseUrl: 'http://127.attacker.invalid'),
        throwsArgumentError);
    expect(() => VedikaClient(apiKey: 'k', baseUrl: 'http://127.example.com'),
        throwsArgumentError);
    expect(
        () => VedikaClient(
            apiKey: 'k',
            baseUrl: 'http://api.vedika.io',
            allowInsecureHttp: true),
        returnsNormally);
    expect(() => VedikaClient(apiKey: 'k', baseUrl: 'ftp://api.vedika.io'),
        throwsArgumentError);
  });

  // ---------------------------------------------------------------------
  // R-004 residual: the ORIGIN gate.
  //
  // The 2026-08 hardening closed the scheme (cleartext) and redirect legs but
  // left the host itself unconstrained: any `https://` origin was accepted and
  // received `Authorization: Bearer <key>` on the first request. On mobile that
  // is credential exfiltration from the user's device, because a shipped app
  // may source its baseUrl from remote config, a deep link or a QR payload.
  // These tests fail before the origin allowlist and pass after it.
  // ---------------------------------------------------------------------

  test('an arbitrary https origin is refused the key', () {
    expect(() => VedikaClient(apiKey: 'k', baseUrl: 'https://attacker.invalid'),
        throwsArgumentError);
    expect(() => VedikaClient(apiKey: 'k', baseUrl: 'https://evil.example.com'),
        throwsArgumentError);
    // A host that merely CONTAINS the real one must not pass.
    expect(
        () => VedikaClient(
            apiKey: 'k', baseUrl: 'https://api.vedika.io.attacker.invalid'),
        throwsArgumentError);
    expect(() => VedikaClient(apiKey: 'k', baseUrl: 'https://notapi.vedika.io'),
        throwsArgumentError);
    // Sibling vedika.io hosts are not the API and must not receive the key.
    expect(() => VedikaClient(apiKey: 'k', baseUrl: 'https://cdn.vedika.io'),
        throwsArgumentError);
  });

  test('the insecure-http opt-in does not unlock a foreign host', () {
    // allowInsecureHttp relaxes the SCHEME only. It must never widen the host
    // gate, or the escape hatch silently restores the original bug.
    expect(
        () => VedikaClient(
            apiKey: 'k',
            baseUrl: 'http://attacker.invalid',
            allowInsecureHttp: true),
        throwsArgumentError);
  });

  test('the Vedika origin and loopback still work', () {
    expect(() => VedikaClient(apiKey: 'k', baseUrl: 'https://api.vedika.io'),
        returnsNormally);
    expect(() => VedikaClient(apiKey: 'k'), returnsNormally);
    expect(() => VedikaClient(apiKey: 'k', baseUrl: 'http://127.0.0.1:8080'),
        returnsNormally);
    expect(() => VedikaClient(apiKey: 'k', baseUrl: 'http://localhost:3000'),
        returnsNormally);
  });

  test('a foreign host is reachable only by naming it in trustedHosts', () {
    // Deliberate, per-host opt-in for a customer proxy. Naming the host is the
    // point: there is no blanket "allow any host" flag.
    expect(
        () => VedikaClient(
            apiKey: 'k',
            baseUrl: 'https://proxy.customer.internal',
            trustedHosts: const ['proxy.customer.internal']),
        returnsNormally);
    // Naming one host does not open a different one.
    expect(
        () => VedikaClient(
            apiKey: 'k',
            baseUrl: 'https://attacker.invalid',
            trustedHosts: const ['proxy.customer.internal']),
        throwsArgumentError);
    // Wildcards are not an allowlist.
    expect(
        () => VedikaClient(
            apiKey: 'k',
            baseUrl: 'https://attacker.invalid',
            trustedHosts: const ['*']),
        throwsArgumentError);
  });

  test('the Bearer key rides only to the configured Vedika origin', () async {
    final seen = <http.BaseRequest>[];
    final mock = MockClient((request) async {
      seen.add(request);
      return _ok();
    });
    final client = VedikaClient(apiKey: 'vk_live_secret', httpClient: mock);
    await client.astrology.vastu('score/overall', {'zone': 'north'});
    await client.crystals.byZodiac('aries');
    client.dispose();

    expect(seen, isNotEmpty);
    for (final r in seen) {
      expect(r.url.host, 'api.vedika.io');
      expect(r.url.scheme, 'https');
      expect(r.headers['Authorization'], 'Bearer vk_live_secret');
    }
  });
}
