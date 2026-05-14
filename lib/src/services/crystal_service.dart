import '../client.dart';

/// Crystal/gemstone endpoints under `/v2/crystals/`.
///
/// 10 endpoints: zodiac, planet, chakra lookup, properties, catalog,
/// cleansing, healing, compatibility, birth crystal, meditation.
class CrystalService {
  final VedikaClient _client;
  CrystalService(this._client);

  // ── GET Endpoints ────────────────────────────────────────────────

  /// Crystals for a zodiac sign.
  Future<Map<String, dynamic>> byZodiac(String sign) =>
      _client.get('/v2/crystals/by-zodiac/$sign');

  /// Crystals for a planet.
  Future<Map<String, dynamic>> byPlanet(String planet) =>
      _client.get('/v2/crystals/by-planet/$planet');

  /// Crystals for a chakra.
  Future<Map<String, dynamic>> byChakra(String chakra) =>
      _client.get('/v2/crystals/by-chakra/$chakra');

  /// Detailed properties of a crystal by name.
  Future<Map<String, dynamic>> properties(String name) =>
      _client.get(
          '/v2/crystals/properties/${Uri.encodeComponent(name)}');

  /// Full crystal catalog.
  Future<Map<String, dynamic>> catalog() =>
      _client.get('/v2/crystals/catalog');

  /// Cleansing methods for crystals.
  Future<Map<String, dynamic>> cleansing() =>
      _client.get('/v2/crystals/cleansing');

  // ── POST Endpoints ───────────────────────────────────────────────

  /// Crystals for a healing purpose.
  Future<Map<String, dynamic>> healing({required String property}) =>
      _client.post('/v2/crystals/healing', {'property': property});

  /// Compatibility between two crystals.
  Future<Map<String, dynamic>> compatibility({
    required String crystal1,
    required String crystal2,
  }) =>
      _client.post('/v2/crystals/compatibility', {
        'crystal1': crystal1,
        'crystal2': crystal2,
      });

  /// Birth crystal from date of birth.
  Future<Map<String, dynamic>> birthCrystal(
          {required String dateOfBirth}) =>
      _client.post(
          '/v2/crystals/birth-crystal', {'dateOfBirth': dateOfBirth});

  /// Crystal meditation guide.
  Future<Map<String, dynamic>> meditation({required String crystal}) =>
      _client.post('/v2/crystals/meditation', {'crystal': crystal});
}
