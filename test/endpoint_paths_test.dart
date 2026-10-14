import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:vedika_sdk/vedika_sdk.dart';

// Every path here was a 404 on api.vedika.io before it was remapped to the
// live route named beside it (checked against https://api.vedika.io/openapi.json).
void main() {
  late List<http.BaseRequest> seen;
  late VedikaClient client;
  const bd = BirthDetails(
      datetime: '1990-06-15T10:30:00', latitude: 18.5204, longitude: 73.8567);

  setUp(() {
    seen = [];
    client = VedikaClient(
      apiKey: 'vk_test_x',
      httpClient: MockClient((r) async {
        seen.add(r);
        return http.Response('{"success":true}', 200,
            headers: {'content-type': 'application/json'});
      }),
    );
  });
  tearDown(() => client.dispose());

  void expectCall(String method, String path) {
    expect(seen, hasLength(1));
    expect('${seen.single.method} ${seen.single.url.path}', '$method $path');
  }

  final cases = <String, (String, Future<Object?> Function(VedikaClient))>{
    'planets': ('/v2/astrology/planetary-positions', (c) => c.astrology.planets(bd)),
    'houses': ('/v2/astrology/house-cusps', (c) => c.astrology.houses(bd)),
    'mahaDasha': ('/v2/astrology/mahadasha', (c) => c.astrology.mahaDasha(bd)),
    'antarDasha': ('/v2/astrology/antardasha', (c) => c.astrology.antarDasha(bd)),
    'gunaMatch': (
      '/v2/astrology/guna-milan',
      (c) => c.astrology.gunaMatch(const MatchingPair(male: bd, female: bd))
    ),
    'astrology.lifePath': (
      '/v2/astrology/numerology/life-path',
      (c) => c.astrology.lifePath({'dateOfBirth': '1990-06-15'})
    ),
    'astrology.destinyNumber': (
      '/v2/astrology/numerology/destiny',
      (c) => c.astrology.destinyNumber({'name': 'A B'})
    ),
    'astrology.numerologyComplete': (
      '/v2/astrology/numerology/complete',
      (c) => c.astrology.numerologyComplete({'name': 'A B'})
    ),
    'jaiminiCharaKarakas': (
      '/v2/astrology/jaimini/karakas',
      (c) => c.astrology.jaiminiCharaKarakas(bd)
    ),
    'fixedStars': (
      '/v2/astrology/fixed-stars/conjunctions',
      (c) => c.astrology.fixedStars(bd)
    ),
    'asteroids': (
      '/v2/astrology/asteroids/positions',
      (c) => c.astrology.asteroids(bd)
    ),
    'sunMoonTimes': (
      '/v2/astrology/panchang',
      (c) => c.astrology.sunMoonTimes({'latitude': 1, 'longitude': 2})
    ),
    'numerology.lifePath': (
      '/v2/astrology/numerology/life-path',
      (c) => c.numerology.lifePath({})
    ),
    'numerology.destiny': (
      '/v2/astrology/numerology/destiny',
      (c) => c.numerology.destiny({})
    ),
    'numerology.personality': (
      '/v2/astrology/numerology/personality',
      (c) => c.numerology.personality({})
    ),
    'numerology.soulUrge': (
      '/v2/astrology/numerology/soul-urge',
      (c) => c.numerology.soulUrge({})
    ),
    'numerology.complete': (
      '/v2/astrology/numerology/complete',
      (c) => c.numerology.complete({})
    ),
    'numerology.compatibility': (
      '/v2/astrology/numerology/compatibility',
      (c) => c.numerology.compatibility({})
    ),
    'pythagoreanLifePath': (
      '/v2/astrology/numerology/life-path',
      (c) => c.numerology.pythagoreanLifePath({})
    ),
    'pythagoreanPersonalYear': (
      '/v2/astrology/numerology/personal-year',
      (c) => c.numerology.pythagoreanPersonalYear({})
    ),
    'pythagoreanPersonalMonth': (
      '/v2/astrology/numerology/personal-month',
      (c) => c.numerology.pythagoreanPersonalMonth({})
    ),
    'pythagoreanPinnacles': (
      '/v2/astrology/numerology/pinnacle',
      (c) => c.numerology.pythagoreanPinnacles({})
    ),
    'chaldeanName': (
      '/v2/astrology/numerology/chaldean/name',
      (c) => c.numerology.chaldeanName({})
    ),
    'chaldeanCompound': (
      '/v2/astrology/numerology/chaldean/name',
      (c) => c.numerology.chaldeanCompound({})
    ),
    'loShuGrid': (
      '/v2/astrology/numerology/lo-shu-grid',
      (c) => c.numerology.loShuGrid({})
    ),
    'vedicName': (
      '/v2/astrology/numerology/vedic/sankhya',
      (c) => c.numerology.vedicName({})
    ),
    'kabbalah': (
      '/v2/astrology/numerology/kabbalah',
      (c) => c.numerology.kabbalah({})
    ),
    'phoneNumber': (
      '/v2/astrology/numerology/phone-number',
      (c) => c.numerology.phoneNumber({})
    ),
    'western.directions': (
      '/v2/western/primary-directions',
      (c) => c.western.directions({})
    ),
    'western.lots': ('/v2/western/lots/all', (c) => c.western.lots(bd)),
    'western.astrocartography': (
      '/v2/western/astrocartography/lines',
      (c) => c.western.astrocartography(bd)
    ),
    'western.dignities': (
      '/v2/western/essential-dignities',
      (c) => c.western.dignities(bd)
    ),
    'western.hemisphereEmphasis': (
      '/v2/western/hemisphere',
      (c) => c.western.hemisphereEmphasis(bd)
    ),
  };

  cases.forEach((name, spec) {
    test('$name -> ${spec.$1}', () async {
      await spec.$2(client);
      expectCall('POST', spec.$1);
    });
  });

  test('harmonics puts the harmonic in the path, not the body', () async {
    await client.western.harmonics({'harmonic': 5, 'latitude': 1});
    expectCall('POST', '/v2/western/harmonics/5');
    expect((seen.single as http.Request).body, '{"latitude":1}');
  });

  test('harmonics without a harmonic is rejected before any request', () {
    expect(() => client.western.harmonics({'latitude': 1}),
        throwsA(isA<ArgumentError>()));
    expect(seen, isEmpty);
  });

  test('festivals uses /upcoming with from and a derived day window', () async {
    await client.astrology
        .festivals(startDate: '2026-10-01', endDate: '2026-10-10');
    expectCall('GET', '/v2/astrology/festivals/upcoming');
    expect(seen.single.url.queryParameters, {'from': '2026-10-01', 'days': '10'});
  });

  test('stellium reports that the route does not exist', () {
    // ignore: deprecated_member_use_from_same_package
    expect(client.western.stellium(bd), throwsA(isA<UnsupportedError>()));
    expect(seen, isEmpty);
  });
}
