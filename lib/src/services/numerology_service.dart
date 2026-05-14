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
      _client.post('/v2/astrology/life-path', params);

  /// Destiny (expression) number from full name.
  Future<Map<String, dynamic>> destiny(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/destiny-number', params);

  /// Personality (consonants) number.
  Future<Map<String, dynamic>> personality(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/personality-number', params);

  /// Soul urge (vowels) number.
  Future<Map<String, dynamic>> soulUrge(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/soul-urge', params);

  /// Complete numerology profile.
  Future<Map<String, dynamic>> complete(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/numerology-complete', params);

  /// Numerology compatibility.
  Future<Map<String, dynamic>> compatibility(
          Map<String, dynamic> params) =>
      _client.post('/v2/astrology/numerology-compatibility', params);

  // ── Expanded: Pythagorean ────────────────────────────────────────

  /// Pythagorean life path.
  Future<Map<String, dynamic>> pythagoreanLifePath(
          Map<String, dynamic> params) =>
      _client.post('/v2/astrology/pythagorean/life-path', params);

  /// Pythagorean personal year.
  Future<Map<String, dynamic>> pythagoreanPersonalYear(
          Map<String, dynamic> params) =>
      _client.post('/v2/astrology/pythagorean/personal-year', params);

  /// Pythagorean personal month.
  Future<Map<String, dynamic>> pythagoreanPersonalMonth(
          Map<String, dynamic> params) =>
      _client.post('/v2/astrology/pythagorean/personal-month', params);

  /// Pythagorean pinnacles and challenges.
  Future<Map<String, dynamic>> pythagoreanPinnacles(
          Map<String, dynamic> params) =>
      _client.post('/v2/astrology/pythagorean/pinnacles', params);

  // ── Expanded: Chaldean ───────────────────────────────────────────

  /// Chaldean name number.
  Future<Map<String, dynamic>> chaldeanName(
          Map<String, dynamic> params) =>
      _client.post('/v2/astrology/chaldean/name', params);

  /// Chaldean compound number.
  Future<Map<String, dynamic>> chaldeanCompound(
          Map<String, dynamic> params) =>
      _client.post('/v2/astrology/chaldean/compound', params);

  // ── Expanded: Lo Shu Grid ────────────────────────────────────────

  /// Lo Shu magic square grid.
  Future<Map<String, dynamic>> loShuGrid(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/lo-shu/grid', params);

  // ── Expanded: Vedic Numerology ───────────────────────────────────

  /// Vedic name analysis.
  Future<Map<String, dynamic>> vedicName(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/vedic-numerology/name', params);

  // ── Expanded: Kabbalah ───────────────────────────────────────────

  /// Kabbalah numerology.
  Future<Map<String, dynamic>> kabbalah(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/kabbalah/name', params);

  // ── Applied ──────────────────────────────────────────────────────

  /// Business name numerology.
  Future<Map<String, dynamic>> businessName(
          Map<String, dynamic> params) =>
      _client.post('/v2/astrology/numerology/business-name', params);

  /// Phone number numerology.
  Future<Map<String, dynamic>> phoneNumber(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/numerology/phone', params);

  /// Address numerology.
  Future<Map<String, dynamic>> address(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/numerology/address', params);
}
