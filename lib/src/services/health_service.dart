import '../client.dart';

/// Health astrology endpoints under `/v2/health/`.
///
/// 8 POST endpoints: vulnerabilities, timing, remedies,
/// Ayurvedic type, mental wellness, chakra, yoga, diet.
class HealthService {
  final VedikaClient _client;
  HealthService(this._client);

  /// Health vulnerabilities based on planetary positions.
  Future<Map<String, dynamic>> vulnerabilities(
          Map<String, dynamic> params) =>
      _client.post('/v2/health/vulnerabilities', params);

  /// Health timing (favorable/unfavorable periods).
  Future<Map<String, dynamic>> timing(Map<String, dynamic> params) =>
      _client.post('/v2/health/timing', params);

  /// Health remedies.
  Future<Map<String, dynamic>> remedies(Map<String, dynamic> params) =>
      _client.post('/v2/health/remedies', params);

  /// Ayurvedic body type (Vata/Pitta/Kapha).
  Future<Map<String, dynamic>> ayurvedicType(
          Map<String, dynamic> params) =>
      _client.post('/v2/health/ayurvedic-type', params);

  /// Mental wellness analysis.
  Future<Map<String, dynamic>> mentalWellness(
          Map<String, dynamic> params) =>
      _client.post('/v2/health/mental-wellness', params);

  /// Chakra health analysis.
  Future<Map<String, dynamic>> chakra(Map<String, dynamic> params) =>
      _client.post('/v2/health/chakra', params);

  /// Yoga practice recommendations.
  Future<Map<String, dynamic>> yogaRecommendation(
          Map<String, dynamic> params) =>
      _client.post('/v2/health/yoga-recommendation', params);

  /// Diet recommendations.
  Future<Map<String, dynamic>> diet(Map<String, dynamic> params) =>
      _client.post('/v2/health/diet', params);
}
