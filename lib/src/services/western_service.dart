import '../client.dart';
import '../models/common.dart';

/// Western (tropical zodiac) astrology endpoints under `/v2/western/`.
///
/// Covers natal charts, transits, progressions, solar returns,
/// synastry, composites, midpoints, harmonics, directions,
/// astrocartography, and more.
class WesternService {
  final VedikaClient _client;
  WesternService(this._client);

  // ── Natal ────────────────────────────────────────────────────────

  /// Full natal chart (tropical zodiac).
  Future<Map<String, dynamic>> natalChart(BirthDetails bd) =>
      _client.post('/v2/western/natal-chart', bd.toJson());

  // ── Transits ─────────────────────────────────────────────────────

  /// Transit chart for a date.
  Future<Map<String, dynamic>> transitChart(Map<String, dynamic> params) =>
      _client.post('/v2/western/transit-chart', params);

  /// Transit planetary positions.
  Future<Map<String, dynamic>> transitPositions(
          Map<String, dynamic> params) =>
      _client.post('/v2/western/transit-positions', params);

  /// Transit aspects to natal planets.
  Future<Map<String, dynamic>> transitAspects(
          Map<String, dynamic> params) =>
      _client.post('/v2/western/transit-aspects', params);

  // ── Progressions ─────────────────────────────────────────────────

  /// Secondary progressions.
  Future<Map<String, dynamic>> progressions(Map<String, dynamic> params) =>
      _client.post('/v2/western/progressions', params);

  /// Progressed positions.
  Future<Map<String, dynamic>> progressionPositions(
          Map<String, dynamic> params) =>
      _client.post('/v2/western/progression-positions', params);

  /// Progressed aspects.
  Future<Map<String, dynamic>> progressionAspects(
          Map<String, dynamic> params) =>
      _client.post('/v2/western/progression-aspects', params);

  // ── Solar Return ─────────────────────────────────────────────────

  /// Solar return chart.
  Future<Map<String, dynamic>> solarReturn(Map<String, dynamic> params) =>
      _client.post('/v2/western/solar-return', params);

  /// Solar return positions.
  Future<Map<String, dynamic>> solarReturnPositions(
          Map<String, dynamic> params) =>
      _client.post('/v2/western/solar-return-positions', params);

  /// Solar return aspects.
  Future<Map<String, dynamic>> solarReturnAspects(
          Map<String, dynamic> params) =>
      _client.post('/v2/western/solar-return-aspects', params);

  // ── Relationships ────────────────────────────────────────────────

  /// Synastry (inter-chart comparison).
  Future<Map<String, dynamic>> synastry(MatchingPair pair) =>
      _client.post('/v2/western/synastry', pair.toJson());

  /// Synastry aspects.
  Future<Map<String, dynamic>> synastryAspects(MatchingPair pair) =>
      _client.post('/v2/western/synastry-aspects', pair.toJson());

  /// Composite chart.
  Future<Map<String, dynamic>> composite(MatchingPair pair) =>
      _client.post('/v2/western/composite', pair.toJson());

  /// Composite aspects.
  Future<Map<String, dynamic>> compositeAspects(MatchingPair pair) =>
      _client.post('/v2/western/composite-aspects', pair.toJson());

  // ── Horoscope ────────────────────────────────────────────────────

  /// Western daily horoscope for a sign.
  Future<Map<String, dynamic>> horoscope(String sign) =>
      _client.get('/v2/western/horoscope/$sign');

  /// Advanced horoscope with transits.
  Future<Map<String, dynamic>> horoscopeAdvanced(String sign) =>
      _client.get('/v2/western/horoscope/$sign/advanced');

  // ── Expansion: Midpoints, Harmonics, etc. ────────────────────────

  /// Midpoints analysis.
  Future<Map<String, dynamic>> midpoints(BirthDetails bd) =>
      _client.post('/v2/western/midpoints', bd.toJson());

  /// Harmonic chart.
  Future<Map<String, dynamic>> harmonics(Map<String, dynamic> params) =>
      _client.post('/v2/western/harmonics', params);

  /// Primary/secondary directions.
  Future<Map<String, dynamic>> directions(Map<String, dynamic> params) =>
      _client.post('/v2/western/directions', params);

  /// Lunar return.
  Future<Map<String, dynamic>> lunarReturn(Map<String, dynamic> params) =>
      _client.post('/v2/western/lunar-return', params);

  /// Arabic parts / lots.
  Future<Map<String, dynamic>> lots(BirthDetails bd) =>
      _client.post('/v2/western/lots', bd.toJson());

  // ── Expansion: Analysis ──────────────────────────────────────────

  /// Astrocartography lines.
  Future<Map<String, dynamic>> astrocartography(BirthDetails bd) =>
      _client.post('/v2/western/astrocartography', bd.toJson());

  /// Aspect pattern detection (Grand Trine, T-Square, etc.).
  Future<Map<String, dynamic>> aspectPatterns(BirthDetails bd) =>
      _client.post('/v2/western/aspect-patterns', bd.toJson());

  /// Stellium detection.
  Future<Map<String, dynamic>> stellium(BirthDetails bd) =>
      _client.post('/v2/western/stellium', bd.toJson());

  // ── Expansion: Extra ─────────────────────────────────────────────

  /// Sect analysis (diurnal/nocturnal).
  Future<Map<String, dynamic>> sect(BirthDetails bd) =>
      _client.post('/v2/western/sect', bd.toJson());

  /// Essential dignities.
  Future<Map<String, dynamic>> dignities(BirthDetails bd) =>
      _client.post('/v2/western/dignities', bd.toJson());

  /// Element balance.
  Future<Map<String, dynamic>> elementBalance(BirthDetails bd) =>
      _client.post('/v2/western/element-balance', bd.toJson());

  /// Modality balance (cardinal/fixed/mutable).
  Future<Map<String, dynamic>> modalityBalance(BirthDetails bd) =>
      _client.post('/v2/western/modality-balance', bd.toJson());

  /// Hemisphere emphasis.
  Future<Map<String, dynamic>> hemisphereEmphasis(BirthDetails bd) =>
      _client.post('/v2/western/hemisphere-emphasis', bd.toJson());

  /// Chart shape pattern (bowl, bucket, locomotive, etc.).
  Future<Map<String, dynamic>> chartShape(BirthDetails bd) =>
      _client.post('/v2/western/chart-shape', bd.toJson());

  /// Pricing info (free endpoint).
  Future<Map<String, dynamic>> pricing() =>
      _client.get('/v2/western/pricing');
}
