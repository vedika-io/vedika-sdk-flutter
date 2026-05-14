import '../client.dart';

/// Daily content endpoints under `/v2/daily/`.
///
/// 12 GET endpoints: horoscope, tarot, angel number, crystal, mantra,
/// panchang, muhurta, moon phase, rune, I Ching, bundle, feed.
class DailyService {
  final VedikaClient _client;
  DailyService(this._client);

  /// Daily horoscope for a zodiac sign.
  Future<Map<String, dynamic>> horoscope(String sign, {String? date}) =>
      _client.get('/v2/daily/horoscope/$sign', queryParams: {
        if (date != null) 'date': date,
      });

  /// Daily tarot card.
  Future<Map<String, dynamic>> tarot({String? date}) =>
      _client.get('/v2/daily/tarot', queryParams: {
        if (date != null) 'date': date,
      });

  /// Daily angel number.
  Future<Map<String, dynamic>> angelNumber({String? date}) =>
      _client.get('/v2/daily/angel-number', queryParams: {
        if (date != null) 'date': date,
      });

  /// Daily crystal recommendation.
  Future<Map<String, dynamic>> crystal({String? date}) =>
      _client.get('/v2/daily/crystal', queryParams: {
        if (date != null) 'date': date,
      });

  /// Daily mantra.
  Future<Map<String, dynamic>> mantra({String? date}) =>
      _client.get('/v2/daily/mantra', queryParams: {
        if (date != null) 'date': date,
      });

  /// Daily panchang.
  Future<Map<String, dynamic>> panchang({String? date}) =>
      _client.get('/v2/daily/panchang', queryParams: {
        if (date != null) 'date': date,
      });

  /// Daily muhurta windows.
  Future<Map<String, dynamic>> muhurta({String? date}) =>
      _client.get('/v2/daily/muhurta', queryParams: {
        if (date != null) 'date': date,
      });

  /// Daily moon phase.
  Future<Map<String, dynamic>> moonPhase({String? date}) =>
      _client.get('/v2/daily/moon-phase', queryParams: {
        if (date != null) 'date': date,
      });

  /// Daily rune.
  Future<Map<String, dynamic>> rune({String? date}) =>
      _client.get('/v2/daily/rune', queryParams: {
        if (date != null) 'date': date,
      });

  /// Daily I Ching hexagram.
  Future<Map<String, dynamic>> iching({String? date}) =>
      _client.get('/v2/daily/iching', queryParams: {
        if (date != null) 'date': date,
      });

  /// Daily bundle (all daily content combined).
  Future<Map<String, dynamic>> bundle({String? date}) =>
      _client.get('/v2/daily/bundle', queryParams: {
        if (date != null) 'date': date,
      });

  /// Daily content feed (JSON, RSS, or XML).
  Future<Map<String, dynamic>> feed({
    String format = 'json',
    String? date,
  }) =>
      _client.get('/v2/daily/feed/$format', queryParams: {
        if (date != null) 'date': date,
      });
}
