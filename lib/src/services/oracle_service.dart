import '../client.dart';

/// Oracle card endpoints under `/v2/oracle/`.
///
/// 4 endpoints: single draw, three-card draw, daily, themes.
class OracleService {
  final VedikaClient _client;
  OracleService(this._client);

  /// Draw a single oracle card.
  Future<Map<String, dynamic>> drawSingle({
    String? question,
    int? seed,
  }) =>
      _client.post('/v2/oracle/draw/single', {
        if (question != null) 'question': question,
        if (seed != null) 'seed': seed,
      });

  /// Three-card oracle draw.
  Future<Map<String, dynamic>> drawThree({
    String? question,
    int? seed,
  }) =>
      _client.post('/v2/oracle/draw/three', {
        if (question != null) 'question': question,
        if (seed != null) 'seed': seed,
      });

  /// Daily oracle card.
  Future<Map<String, dynamic>> daily() =>
      _client.get('/v2/oracle/daily');

  /// List oracle themes.
  Future<Map<String, dynamic>> themes() =>
      _client.get('/v2/oracle/themes');
}
