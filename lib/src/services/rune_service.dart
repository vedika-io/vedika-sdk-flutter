import '../client.dart';

/// Rune (Elder Futhark) endpoints under `/v2/runes/`.
///
/// 5 endpoints: single/three/five draw, meaning lookup, catalog.
class RuneService {
  final VedikaClient _client;
  RuneService(this._client);

  /// Draw a single rune.
  Future<Map<String, dynamic>> drawSingle({int? seed}) =>
      _client.post('/v2/runes/draw/single', {
        if (seed != null) 'seed': seed,
      });

  /// Draw three runes (past/present/future).
  Future<Map<String, dynamic>> drawThree({int? seed}) =>
      _client.post('/v2/runes/draw/three', {
        if (seed != null) 'seed': seed,
      });

  /// Draw five runes (cross spread).
  Future<Map<String, dynamic>> drawFive({int? seed}) =>
      _client.post('/v2/runes/draw/five', {
        if (seed != null) 'seed': seed,
      });

  /// Lookup a rune's meaning by name.
  Future<Map<String, dynamic>> meaning(String rune) =>
      _client.get('/v2/runes/meaning/$rune');

  /// Full Elder Futhark catalog (24 runes).
  Future<Map<String, dynamic>> catalog() =>
      _client.get('/v2/runes/catalog');
}
