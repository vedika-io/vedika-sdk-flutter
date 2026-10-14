import '../client.dart';

/// Standalone numerology endpoints under `/v2/astrology/`.
///
/// Core numerology (7 endpoints) plus expanded Pythagorean, Chaldean,
/// Lo Shu, Vedic, Kabbalah, and applied numerology (25+ endpoints).
class NumerologyService {
  final VedikaClient _client;
  NumerologyService(this._client);

  // ── Core Numerology ──────────────────────────────────────────────

  /// Life path number from date of birth.
  Future<Map<String, dynamic>> lifePath(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/numerology/life-path', params);

  /// Destiny (expression) number from full name.
  Future<Map<String, dynamic>> destiny(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/numerology/destiny', params);

  /// Personality (consonants) number.
  Future<Map<String, dynamic>> personality(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/numerology/personality', params);

  /// Soul urge (vowels) number.
  Future<Map<String, dynamic>> soulUrge(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/numerology/soul-urge', params);

  /// Complete numerology profile.
  Future<Map<String, dynamic>> complete(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/numerology/complete', params);

  /// Numerology compatibility.
  Future<Map<String, dynamic>> compatibility(
          Map<String, dynamic> params) =>
      _client.post('/v2/astrology/numerology/compatibility', params);

  // ── Expanded: Pythagorean ────────────────────────────────────────

  /// Pythagorean life path.
  Future<Map<String, dynamic>> pythagoreanLifePath(
          Map<String, dynamic> params) =>
      _client.post('/v2/astrology/numerology/life-path', params);

  /// Pythagorean personal year.
  Future<Map<String, dynamic>> pythagoreanPersonalYear(
          Map<String, dynamic> params) =>
      _client.post('/v2/astrology/numerology/personal-year', params);

  /// Pythagorean personal month.
  Future<Map<String, dynamic>> pythagoreanPersonalMonth(
          Map<String, dynamic> params) =>
      _client.post('/v2/astrology/numerology/personal-month', params);

  /// Pythagorean pinnacles and challenges.
  Future<Map<String, dynamic>> pythagoreanPinnacles(
          Map<String, dynamic> params) =>
      _client.post('/v2/astrology/numerology/pinnacle', params);

  // ── Expanded: Chaldean ───────────────────────────────────────────

  /// Chaldean name number.
  Future<Map<String, dynamic>> chaldeanName(
          Map<String, dynamic> params) =>
      _client.post('/v2/astrology/numerology/chaldean/name', params);

  /// Chaldean compound number. The compound-number reading is part of the
  /// Chaldean name response, so this calls the same route as [chaldeanName].
  Future<Map<String, dynamic>> chaldeanCompound(
          Map<String, dynamic> params) =>
      _client.post('/v2/astrology/numerology/chaldean/name', params);

  // ── Expanded: Lo Shu Grid ────────────────────────────────────────

  /// Lo Shu magic square grid.
  Future<Map<String, dynamic>> loShuGrid(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/numerology/lo-shu-grid', params);

  // ── Expanded: Vedic Numerology ───────────────────────────────────

  /// Vedic numerology (Mulank, Bhagyank, Namank).
  Future<Map<String, dynamic>> vedicName(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/numerology/vedic/sankhya', params);

  // ── Expanded: Kabbalah ───────────────────────────────────────────

  /// Kabbalah numerology.
  Future<Map<String, dynamic>> kabbalah(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/numerology/kabbalah', params);

  // ── Applied ──────────────────────────────────────────────────────

  /// Business name numerology.
  Future<Map<String, dynamic>> businessName(
          Map<String, dynamic> params) =>
      _client.post('/v2/astrology/numerology/business-name', params);

  /// Phone number numerology.
  Future<Map<String, dynamic>> phoneNumber(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/numerology/phone-number', params);

  /// Address numerology.
  Future<Map<String, dynamic>> address(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/numerology/address', params);
}
