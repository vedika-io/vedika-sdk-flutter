import '../client.dart';

/// Chinese astrology endpoints under `/v2/chinese/`.
///
/// 15 endpoints: zodiac, Ba Zi, Feng Shui, Zi Wei, compatibility,
/// predictions, lucky attributes, daily/monthly/yearly, calendar.
class ChineseService {
  final VedikaClient _client;
  ChineseService(this._client);

  // ── POST Endpoints ───────────────────────────────────────────────

  /// Chinese zodiac animal for a year.
  Future<Map<String, dynamic>> zodiacAnimal({required int year}) =>
      _client.post('/v2/chinese/zodiac-animal', {'year': year});

  /// Five Element for a year.
  Future<Map<String, dynamic>> element({required int year}) =>
      _client.post('/v2/chinese/element', {'year': year});

  /// Ba Zi (Four Pillars) chart.
  Future<Map<String, dynamic>> baziChart({required String datetime}) =>
      _client.post('/v2/chinese/bazi/chart', {'datetime': datetime});

  /// Ba Zi analysis.
  Future<Map<String, dynamic>> baziAnalysis({required String datetime}) =>
      _client.post('/v2/chinese/bazi/analysis', {'datetime': datetime});

  /// Zodiac animal compatibility.
  Future<Map<String, dynamic>> compatibility({
    required String animal1,
    required String animal2,
  }) =>
      _client.post('/v2/chinese/compatibility', {
        'animal1': animal1,
        'animal2': animal2,
      });

  /// Year prediction for a zodiac animal.
  Future<Map<String, dynamic>> yearPrediction({
    required String animal,
    int? year,
  }) =>
      _client.post('/v2/chinese/year-prediction', {
        'animal': animal,
        if (year != null) 'year': year,
      });

  /// Lucky attributes (numbers, colors, directions).
  Future<Map<String, dynamic>> lucky({
    required String animal,
    int? year,
  }) =>
      _client.post('/v2/chinese/lucky', {
        'animal': animal,
        if (year != null) 'year': year,
      });

  /// Flying Stars for a year.
  Future<Map<String, dynamic>> flyingStars({int? year}) =>
      _client.post('/v2/chinese/feng-shui/flying-stars', {
        if (year != null) 'year': year,
      });

  /// Kua Number for Feng Shui.
  Future<Map<String, dynamic>> kuaNumber({
    required int birthYear,
    required String gender,
  }) =>
      _client.post('/v2/chinese/feng-shui/kua-number', {
        'birthYear': birthYear,
        'gender': gender,
      });

  /// Auspicious/inauspicious directions for a Kua number.
  Future<Map<String, dynamic>> directions({required int kuaNumber}) =>
      _client.post('/v2/chinese/feng-shui/directions', {
        'kuaNumber': kuaNumber,
      });

  /// Zi Wei Dou Shu chart.
  Future<Map<String, dynamic>> ziWei({required String datetime}) =>
      _client.post('/v2/chinese/zi-wei', {'datetime': datetime});

  // ── GET Endpoints ────────────────────────────────────────────────

  /// Daily Chinese horoscope.
  Future<Map<String, dynamic>> daily({String? animal, String? date}) =>
      _client.get('/v2/chinese/daily', queryParams: {
        if (animal != null) 'animal': animal,
        if (date != null) 'date': date,
      });

  /// Monthly Chinese horoscope.
  Future<Map<String, dynamic>> monthly({
    String? animal,
    int? year,
    int? month,
  }) =>
      _client.get('/v2/chinese/monthly', queryParams: {
        if (animal != null) 'animal': animal,
        if (year != null) 'year': year.toString(),
        if (month != null) 'month': month.toString(),
      });

  /// Yearly Chinese horoscope.
  Future<Map<String, dynamic>> yearly({String? animal, int? year}) =>
      _client.get('/v2/chinese/yearly', queryParams: {
        if (animal != null) 'animal': animal,
        if (year != null) 'year': year.toString(),
      });

  /// Chinese calendar date info.
  Future<Map<String, dynamic>> calendar({String? date}) =>
      _client.get('/v2/chinese/calendar', queryParams: {
        if (date != null) 'date': date,
      });
}
