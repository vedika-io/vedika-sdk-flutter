import '../client.dart';

/// Lenormand card endpoints under `/v2/lenormand/`.
///
/// 5 endpoints: single draw, three-card line, grand tableau,
/// card lookup, combination meaning.
class LenormandService {
  final VedikaClient _client;
  LenormandService(this._client);

  /// Draw a single Lenormand card.
  Future<Map<String, dynamic>> drawSingle({
    String? question,
    int? seed,
  }) =>
      _client.post('/v2/lenormand/draw/single', {
        if (question != null) 'question': question,
        if (seed != null) 'seed': seed,
      });

  /// Three-card line spread.
  Future<Map<String, dynamic>> drawThree({
    String? question,
    int? seed,
  }) =>
      _client.post('/v2/lenormand/draw/three', {
        if (question != null) 'question': question,
        if (seed != null) 'seed': seed,
      });

  /// Grand Tableau (all 36 cards).
  Future<Map<String, dynamic>> grandTableau({
    int? significatorId,
    int? seed,
  }) =>
      _client.post('/v2/lenormand/draw/grand-tableau', {
        if (significatorId != null) 'significatorId': significatorId,
        if (seed != null) 'seed': seed,
      });

  /// Lookup a Lenormand card by name.
  Future<Map<String, dynamic>> card(String name) =>
      _client.get('/v2/lenormand/card/${Uri.encodeComponent(name)}');

  /// Two-card combination meaning.
  Future<Map<String, dynamic>> combination({
    required String cardA,
    required String cardB,
  }) =>
      _client.post('/v2/lenormand/combination', {
        'cardA': cardA,
        'cardB': cardB,
      });
}
