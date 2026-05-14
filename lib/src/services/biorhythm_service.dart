import '../client.dart';

/// Biorhythm endpoints under `/v2/biorhythm/`.
///
/// 6 POST endpoints: chart, today, critical days, compatibility,
/// forecast, best days. All based on three sine waves from birth date.
class BiorhythmService {
  final VedikaClient _client;
  BiorhythmService(this._client);

  /// Full biorhythm chart for a date range.
  Future<Map<String, dynamic>> chart({
    required String dateOfBirth,
    String? startDate,
    int days = 30,
  }) =>
      _client.post('/v2/biorhythm/chart', {
        'dateOfBirth': dateOfBirth,
        if (startDate != null) 'startDate': startDate,
        'days': days,
      });

  /// Today's biorhythm values.
  Future<Map<String, dynamic>> today({required String dateOfBirth}) =>
      _client.post('/v2/biorhythm/today', {'dateOfBirth': dateOfBirth});

  /// Upcoming critical (crossing) days.
  Future<Map<String, dynamic>> criticalDays({
    required String dateOfBirth,
    int daysAhead = 30,
  }) =>
      _client.post('/v2/biorhythm/critical-days', {
        'dateOfBirth': dateOfBirth,
        'daysAhead': daysAhead,
      });

  /// Biorhythm compatibility between two people.
  Future<Map<String, dynamic>> compatibility({
    required String dateOfBirth1,
    required String dateOfBirth2,
    String? targetDate,
  }) =>
      _client.post('/v2/biorhythm/compatibility', {
        'dateOfBirth1': dateOfBirth1,
        'dateOfBirth2': dateOfBirth2,
        if (targetDate != null) 'targetDate': targetDate,
      });

  /// Short-term forecast.
  Future<Map<String, dynamic>> forecast({
    required String dateOfBirth,
    int daysAhead = 7,
  }) =>
      _client.post('/v2/biorhythm/forecast', {
        'dateOfBirth': dateOfBirth,
        'daysAhead': daysAhead,
      });

  /// Best days in an upcoming period.
  Future<Map<String, dynamic>> bestDays({
    required String dateOfBirth,
    int daysAhead = 30,
    int top = 5,
  }) =>
      _client.post('/v2/biorhythm/best-days', {
        'dateOfBirth': dateOfBirth,
        'daysAhead': daysAhead,
        'top': top,
      });
}
