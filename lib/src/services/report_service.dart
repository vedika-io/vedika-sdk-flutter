import '../client.dart';

/// Report and prediction endpoints under `/v2/reports/`.
///
/// 7 POST endpoints: nakshatra daily/weekly/monthly prediction,
/// house report, rashi report, planet report, complete life report.
class ReportService {
  final VedikaClient _client;
  ReportService(this._client);

  /// Nakshatra daily prediction.
  Future<Map<String, dynamic>> nakshatraDaily(
          Map<String, dynamic> params) =>
      _client.post('/v2/reports/nakshatra/daily-prediction', params);

  /// Nakshatra weekly prediction.
  Future<Map<String, dynamic>> nakshatraWeekly(
          Map<String, dynamic> params) =>
      _client.post('/v2/reports/nakshatra/weekly-prediction', params);

  /// Nakshatra monthly prediction.
  Future<Map<String, dynamic>> nakshatraMonthly(
          Map<String, dynamic> params) =>
      _client.post('/v2/reports/nakshatra/monthly-prediction', params);

  /// Detailed house (bhava) report.
  Future<Map<String, dynamic>> houseReport(
          Map<String, dynamic> params) =>
      _client.post('/v2/reports/house-report', params);

  /// Rashi (zodiac sign) report.
  Future<Map<String, dynamic>> rashiReport(
          Map<String, dynamic> params) =>
      _client.post('/v2/reports/rashi-report', params);

  /// Planet report.
  Future<Map<String, dynamic>> planetReport(
          Map<String, dynamic> params) =>
      _client.post('/v2/reports/planet-report', params);

  /// Complete life report.
  Future<Map<String, dynamic>> complete(Map<String, dynamic> params) =>
      _client.post('/v2/reports/complete', params);
}
