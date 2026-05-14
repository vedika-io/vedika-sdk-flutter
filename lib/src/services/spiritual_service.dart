import '../client.dart';

/// Spiritual endpoints under `/v2/spiritual/`.
///
/// 10 POST endpoints: mantra, deity, meditation, pilgrimage, puja,
/// rudraksha, yantra, past-life, karma, fasting.
/// All require birth details for chart-based recommendations.
class SpiritualService {
  final VedikaClient _client;
  SpiritualService(this._client);

  /// Personalized mantra recommendation.
  Future<Map<String, dynamic>> mantra(Map<String, dynamic> params) =>
      _client.post('/v2/spiritual/mantra', params);

  /// Deity recommendation based on chart.
  Future<Map<String, dynamic>> deity(Map<String, dynamic> params) =>
      _client.post('/v2/spiritual/deity', params);

  /// Meditation type recommendation.
  Future<Map<String, dynamic>> meditation(Map<String, dynamic> params) =>
      _client.post('/v2/spiritual/meditation', params);

  /// Pilgrimage recommendations for dosha remediation.
  Future<Map<String, dynamic>> pilgrimage({
    List<String>? doshas,
  }) =>
      _client.post('/v2/spiritual/pilgrimage', {
        if (doshas != null) 'doshas': doshas,
      });

  /// Puja (worship) recommendation.
  Future<Map<String, dynamic>> puja(Map<String, dynamic> params) =>
      _client.post('/v2/spiritual/puja', params);

  /// Rudraksha bead recommendation.
  Future<Map<String, dynamic>> rudraksha(Map<String, dynamic> params) =>
      _client.post('/v2/spiritual/rudraksha', params);

  /// Yantra recommendation.
  Future<Map<String, dynamic>> yantra(Map<String, dynamic> params) =>
      _client.post('/v2/spiritual/yantra', params);

  /// Past-life analysis.
  Future<Map<String, dynamic>> pastLife(Map<String, dynamic> params) =>
      _client.post('/v2/spiritual/past-life', params);

  /// Karma analysis.
  Future<Map<String, dynamic>> karma(Map<String, dynamic> params) =>
      _client.post('/v2/spiritual/karma', params);

  /// Fasting recommendation.
  Future<Map<String, dynamic>> fasting(Map<String, dynamic> params) =>
      _client.post('/v2/spiritual/fasting', params);
}
