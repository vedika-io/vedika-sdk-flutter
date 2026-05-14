import '../client.dart';

/// Dream interpretation endpoints under `/v2/dreams/`.
///
/// 6 endpoints: symbol lookup, catalog, themes, interpret,
/// lucky numbers, frequency analysis.
class DreamService {
  final VedikaClient _client;
  DreamService(this._client);

  // ── GET Endpoints ────────────────────────────────────────────────

  /// Lookup a dream symbol.
  Future<Map<String, dynamic>> symbol(String symbol) =>
      _client.get('/v2/dreams/symbol/${Uri.encodeComponent(symbol)}');

  /// Full dream symbol catalog.
  Future<Map<String, dynamic>> catalog() =>
      _client.get('/v2/dreams/catalog');

  /// List dream themes.
  Future<Map<String, dynamic>> themes() =>
      _client.get('/v2/dreams/themes');

  // ── POST Endpoints ───────────────────────────────────────────────

  /// Interpret a dream description.
  Future<Map<String, dynamic>> interpret({required String description}) =>
      _client.post('/v2/dreams/interpret', {'description': description});

  /// Lucky numbers from dream symbols.
  Future<Map<String, dynamic>> luckyNumbers(
          {required List<String> symbols}) =>
      _client.post('/v2/dreams/lucky-numbers', {'symbols': symbols});

  /// Dream frequency analysis.
  Future<Map<String, dynamic>> frequency(
          {required List<Map<String, dynamic>> entries}) =>
      _client.post('/v2/dreams/frequency', {'entries': entries});
}
