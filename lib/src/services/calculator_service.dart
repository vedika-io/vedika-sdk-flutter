import '../client.dart';

/// Fun calculator endpoints under `/v2/calculators/`.
///
/// 5 endpoints: FLAMES, love score, moon sign, sun sign,
/// nakshatra finder.
class CalculatorService {
  final VedikaClient _client;
  CalculatorService(this._client);

  /// FLAMES relationship test.
  Future<Map<String, dynamic>> flames(String name1, String name2) =>
      _client.get(
          '/v2/calculators/flames/${Uri.encodeComponent(name1)}/${Uri.encodeComponent(name2)}');

  /// Love score between two names.
  Future<Map<String, dynamic>> loveScore(String name1, String name2) =>
      _client.get(
          '/v2/calculators/love-score/${Uri.encodeComponent(name1)}/${Uri.encodeComponent(name2)}');

  /// Moon sign from birth details.
  Future<Map<String, dynamic>> moonSign(Map<String, dynamic> params) =>
      _client.post('/v2/calculators/moon-sign', params);

  /// Sun sign from birth details.
  Future<Map<String, dynamic>> sunSign(Map<String, dynamic> params) =>
      _client.post('/v2/calculators/sun-sign', params);

  /// Nakshatra finder from birth details.
  Future<Map<String, dynamic>> nakshatraFinder(
          Map<String, dynamic> params) =>
      _client.post('/v2/calculators/nakshatra-finder', params);
}
