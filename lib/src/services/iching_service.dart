import '../client.dart';

/// I Ching endpoints under `/v2/iching/`.
///
/// 8 endpoints: hexagram casting, lookup, changing lines,
/// question-based casting, interpretation, compatibility,
/// daily, trigrams.
class IChingService {
  final VedikaClient _client;
  IChingService(this._client);

  // ── POST Endpoints ───────────────────────────────────────────────

  /// Cast a hexagram (random or seeded).
  Future<Map<String, dynamic>> cast({int? seed}) =>
      _client.post('/v2/iching/cast', {
        if (seed != null) 'seed': seed,
      });

  /// Analyze changing lines.
  Future<Map<String, dynamic>> changingLines({required List<int> lines}) =>
      _client.post('/v2/iching/changing-lines', {'lines': lines});

  /// Cast a hexagram with a specific question.
  Future<Map<String, dynamic>> question({
    required String question,
    int? seed,
  }) =>
      _client.post('/v2/iching/question', {
        'question': question,
        if (seed != null) 'seed': seed,
      });

  /// Full interpretation of a casting.
  Future<Map<String, dynamic>> interpretation({
    String? question,
    int? seed,
  }) =>
      _client.post('/v2/iching/interpretation', {
        if (question != null) 'question': question,
        if (seed != null) 'seed': seed,
      });

  /// Compatibility between two hexagrams.
  Future<Map<String, dynamic>> compatibility({
    required int hexagram1,
    required int hexagram2,
  }) =>
      _client.post('/v2/iching/compatibility', {
        'hexagram1': hexagram1,
        'hexagram2': hexagram2,
      });

  // ── GET Endpoints ────────────────────────────────────────────────

  /// Lookup a specific hexagram (1-64).
  Future<Map<String, dynamic>> hexagram(int number) =>
      _client.get('/v2/iching/hexagram/$number');

  /// Daily I Ching reading.
  Future<Map<String, dynamic>> daily({String? date}) =>
      _client.get('/v2/iching/daily', queryParams: {
        if (date != null) 'date': date,
      });

  /// List all 8 trigrams.
  Future<Map<String, dynamic>> trigrams() =>
      _client.get('/v2/iching/trigrams');
}
