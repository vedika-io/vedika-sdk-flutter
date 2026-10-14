import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:vedika_sdk/vedika_sdk.dart';

http.Response _json(int status, Object body, {Map<String, String>? headers}) =>
    http.Response(jsonEncode(body), status,
        headers: {'content-type': 'application/json', ...?headers});

VedikaClient _client(MockClient mock) =>
    VedikaClient(apiKey: 'vk_test_x', httpClient: mock);

void main() {
  group('402 insufficient balance', () {
    test('is typed with required, available and deficit and is not retried',
        () async {
      var calls = 0;
      final client = _client(MockClient((_) async {
        calls++;
        return _json(402, {
          'success': false,
          'error': 'Insufficient balance',
          'code': 'INSUFFICIENT_BALANCE',
          'wallet': {'required': 0.5, 'available': 0.12, 'deficit': 0.38},
          'purchaseUrl': 'https://vedika.io/dashboard/billing',
        });
      }));
      await expectLater(
        client.astrology.birthChart(const BirthDetails(
            datetime: '1990-06-15T10:30:00', latitude: 18.5, longitude: 73.8)),
        throwsA(isA<VedikaInsufficientCredits>()
            .having((e) => e.code, 'code', 'INSUFFICIENT_BALANCE')
            .having((e) => e.required, 'required', 0.5)
            .having((e) => e.available, 'available', 0.12)
            .having((e) => e.deficit, 'deficit', 0.38)
            .having((e) => e.purchaseUrl, 'purchaseUrl',
                'https://vedika.io/dashboard/billing')),
      );
      expect(calls, 1);
      client.dispose();
    });

    test('tolerates a body with no wallet block', () async {
      final client =
          _client(MockClient((_) async => _json(402, {'error': 'no funds'})));
      await expectLater(
        client.get('/v2/anything'),
        throwsA(isA<VedikaInsufficientCredits>()
            .having((e) => e.required, 'required', isNull)
            .having((e) => e.deficit, 'deficit', isNull)),
      );
      client.dispose();
    });
  });

  group('429 is decided by the body code, not by headers', () {
    test('DAILY_LIMIT_EXCEEDED is not retryable', () async {
      var calls = 0;
      final client = _client(MockClient((_) async {
        calls++;
        return _json(
          429,
          {
            'success': false,
            'code': 'DAILY_LIMIT_EXCEEDED',
            'message': 'Daily limit reached',
            'retryAfter': 3600,
            'upgradeUrl': 'https://vedika.io/pricing',
          },
          // Per-minute headers say plenty of headroom; they must not matter.
          headers: {'x-ratelimit-remaining': '59', 'retry-after': '1'},
        );
      }));
      await expectLater(
        client.get('/v2/anything'),
        throwsA(isA<VedikaRateLimitError>()
            .having((e) => e.isDailyLimit, 'isDailyLimit', isTrue)
            .having((e) => e.isRetryable, 'isRetryable', isFalse)
            .having((e) => e.upgradeUrl, 'upgradeUrl',
                'https://vedika.io/pricing')),
      );
      expect(calls, 1);
      client.dispose();
    });

    test('RATE_LIMIT_EXCEEDED carries retryAfter from the body', () async {
      final client = _client(MockClient((_) async => _json(
            429,
            {'code': 'RATE_LIMIT_EXCEEDED', 'retryAfter': 7},
            headers: {'retry-after': '99'},
          )));
      await expectLater(
        client.get('/v2/anything'),
        throwsA(isA<VedikaRateLimitError>()
            .having((e) => e.isRetryable, 'isRetryable', isTrue)
            .having((e) => e.retryAfterSeconds, 'retryAfterSeconds', 7)),
      );
      client.dispose();
    });

    test('falls back to the Retry-After header when the body has none',
        () async {
      final client = _client(MockClient((_) async => _json(
            429,
            {'code': 'RATE_LIMITED'},
            headers: {'retry-after': '12'},
          )));
      await expectLater(
        client.get('/v2/anything'),
        throwsA(isA<VedikaRateLimitError>()
            .having((e) => e.retryAfterSeconds, 'retryAfterSeconds', 12)),
      );
      client.dispose();
    });
  });

  test('401 is surfaced once and never retried', () async {
    var calls = 0;
    final client = _client(MockClient((_) async {
      calls++;
      return _json(401, {'error': 'Invalid API key'},
          headers: {'www-authenticate': 'Bearer error="invalid_token"'});
    }));
    await expectLater(
        client.get('/v2/anything'), throwsA(isA<VedikaAuthError>()));
    expect(calls, 1);
    client.dispose();
  });

  group('2xx other than 200 is success', () {
    for (final status in [201, 202, 204]) {
      test('$status returns the body', () async {
        final client = _client(MockClient((_) async => status == 204
            ? http.Response('', 204)
            : _json(status, {'success': true, 'data': {'jobId': 'j1'}})));
        final out = await client.post('/v2/astrology/vastu/jobs', {'a': 1},
            idempotencyKey: 'k-1');
        if (status == 204) {
          expect(out, isEmpty);
        } else {
          expect(out['success'], isTrue);
        }
        client.dispose();
      });
    }

    test('getRaw accepts a non-200 2xx', () async {
      final client =
          _client(MockClient((_) async => http.Response('<p>ok</p>', 202)));
      expect(await client.getRaw('/v2/widget/panchang'), '<p>ok</p>');
      client.dispose();
    });
  });

  group('422 IDEMPOTENCY_NOT_SUPPORTED', () {
    test('is a typed error and the call is not resent', () async {
      var calls = 0;
      final client = _client(MockClient((_) async {
        calls++;
        return _json(422, {
          'success': false,
          'code': 'IDEMPOTENCY_NOT_SUPPORTED',
          'message': 'Remove the idempotency header and retry; no charge '
              'was attempted.',
        });
      }));
      await expectLater(
        client.post('/v2/astrology/transits', {'a': 1}, idempotencyKey: 'k-1'),
        throwsA(isA<VedikaIdempotencyNotSupportedError>()),
      );
      expect(calls, 1);
      client.dispose();
    });

    test('a different 422 stays a plain API error', () async {
      final client = _client(MockClient((_) async =>
          _json(422, {'code': 'IDEMPOTENCY_KEY_REUSED', 'error': 'reused'})));
      await expectLater(
        client.post('/v2/x', {}),
        throwsA(isA<VedikaApiError>()
            .having((e) => e, 'type', isNot(isA<VedikaIdempotencyNotSupportedError>()))
            .having((e) => e.code, 'code', 'IDEMPOTENCY_KEY_REUSED')),
      );
      client.dispose();
    });
  });

  group('idempotency headers', () {
    test('no Idempotency-Key or X-Request-Id unless the caller passes a key',
        () async {
      final seen = <http.BaseRequest>[];
      final client = _client(MockClient((r) async {
        seen.add(r);
        return _json(200, {'success': true});
      }));
      await client.post('/v2/astrology/birth-chart', {'latitude': 1});
      await client.astrology.vastu('score/overall', {'zone': 'north'});
      await client.get('/v2/astrology/horoscope-signs');
      for (final r in seen) {
        final names = r.headers.keys.map((k) => k.toLowerCase()).toSet();
        expect(names.contains('idempotency-key'), isFalse, reason: r.url.path);
        expect(names.contains('x-idempotency-key'), isFalse,
            reason: r.url.path);
        expect(names.contains('x-request-id'), isFalse, reason: r.url.path);
      }
      client.dispose();
    });

    test('an explicit key rides as Idempotency-Key', () async {
      late http.BaseRequest seen;
      final client = _client(MockClient((r) async {
        seen = r;
        return _json(200, {'success': true});
      }));
      await client.post('/v2/astrology/vastu/jobs', {}, idempotencyKey: 'job-1');
      expect(seen.headers['Idempotency-Key'], 'job-1');
      client.dispose();
    });
  });

  test('X-SDK carries the version in pubspec.yaml', () async {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    final version =
        RegExp(r'^version:\s*(\S+)', multiLine: true).firstMatch(pubspec)!.group(1);
    late http.BaseRequest seen;
    final client = _client(MockClient((r) async {
      seen = r;
      return _json(200, {'success': true});
    }));
    await client.get('/v2/astrology/horoscope-signs');
    expect(seen.headers['X-SDK'], 'vedika-flutter/$version');
    expect(VedikaClient.sdkVersion, version);
    expect(seen.headers['Authorization'], 'Bearer vk_test_x');
    client.dispose();
  });
}
