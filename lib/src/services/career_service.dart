import '../client.dart';

/// Career and finance endpoints under `/v2/career/`.
///
/// 7 POST endpoints: suitable careers, timing, promotion,
/// wealth timing, investment, business start, property.
class CareerService {
  final VedikaClient _client;
  CareerService(this._client);

  /// Suitable career fields based on chart.
  Future<Map<String, dynamic>> suitable(Map<String, dynamic> params) =>
      _client.post('/v2/career/suitable', params);

  /// Career timing (favorable periods).
  Future<Map<String, dynamic>> timing(Map<String, dynamic> params) =>
      _client.post('/v2/career/timing', params);

  /// Promotion periods.
  Future<Map<String, dynamic>> promotion(Map<String, dynamic> params) =>
      _client.post('/v2/career/promotion', params);

  /// Wealth timing analysis.
  Future<Map<String, dynamic>> wealthTiming(
          Map<String, dynamic> params) =>
      _client.post('/v2/career/finance/wealth-timing', params);

  /// Investment timing.
  Future<Map<String, dynamic>> investmentTiming(
          Map<String, dynamic> params) =>
      _client.post('/v2/career/finance/investment', params);

  /// Auspicious time to start a business.
  Future<Map<String, dynamic>> businessStart(
          Map<String, dynamic> params) =>
      _client.post('/v2/career/finance/business-start', params);

  /// Property purchase timing.
  Future<Map<String, dynamic>> propertyTiming(
          Map<String, dynamic> params) =>
      _client.post('/v2/career/finance/property', params);
}
