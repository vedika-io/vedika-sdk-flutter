import '../client.dart';
import '../models/common.dart';

/// Matrimony matching endpoints under `/v2/matrimony/`.
///
/// 15 POST endpoints: compatibility scoring, dosha cancellation,
/// North/South matching, unified match, timing, Mangal quick,
/// Nadi, bulk match, D9 analysis, children, remedies, PDF report,
/// name match, prediction.
class MatrimonyService {
  final VedikaClient _client;
  MatrimonyService(this._client);

  /// Overall compatibility score.
  Future<Map<String, dynamic>> compatibilityScore(MatchingPair pair) =>
      _client.post('/v2/matrimony/compatibility-score', pair.toJson());

  /// Dosha cancellation rules (BPHS/Phaladeepika/Saravali).
  Future<Map<String, dynamic>> doshaCancellation(MatchingPair pair) =>
      _client.post('/v2/matrimony/dosha-cancellation', pair.toJson());

  /// North Indian matching system.
  Future<Map<String, dynamic>> northMatch(MatchingPair pair) =>
      _client.post('/v2/matrimony/north-match', pair.toJson());

  /// South Indian matching system.
  Future<Map<String, dynamic>> southMatch(MatchingPair pair) =>
      _client.post('/v2/matrimony/south-match', pair.toJson());

  /// Unified matching (North + South combined).
  Future<Map<String, dynamic>> unifiedMatch(MatchingPair pair) =>
      _client.post('/v2/matrimony/unified-match', pair.toJson());

  /// Marriage timing analysis.
  Future<Map<String, dynamic>> timing(Map<String, dynamic> params) =>
      _client.post('/v2/matrimony/timing', params);

  /// Quick Mangal Dosha check.
  Future<Map<String, dynamic>> mangalQuick(Map<String, dynamic> params) =>
      _client.post('/v2/matrimony/mangal-quick', params);

  /// Nadi Dosha check.
  Future<Map<String, dynamic>> nadiCheck(MatchingPair pair) =>
      _client.post('/v2/matrimony/nadi-check', pair.toJson());

  /// Bulk matching against multiple profiles.
  Future<Map<String, dynamic>> bulkMatch({
    required Map<String, dynamic> primary,
    required List<Map<String, dynamic>> profiles,
  }) =>
      _client.post('/v2/matrimony/bulk-match', {
        'primary': primary,
        'profiles': profiles,
      });

  /// Navamsa (D9) marriage analysis.
  Future<Map<String, dynamic>> d9Analysis(Map<String, dynamic> params) =>
      _client.post('/v2/matrimony/d9-analysis', params);

  /// Children timing and prognosis.
  Future<Map<String, dynamic>> children(Map<String, dynamic> params) =>
      _client.post('/v2/matrimony/children', params);

  /// Dosha remedies.
  Future<Map<String, dynamic>> remedies({String dosha = 'Mangal Dosha'}) =>
      _client.post('/v2/matrimony/remedies', {'dosha': dosha});

  /// PDF match report.
  Future<Map<String, dynamic>> pdfReport(MatchingPair pair) =>
      _client.post('/v2/matrimony/pdf-report', pair.toJson());

  /// Name-based match.
  Future<Map<String, dynamic>> nameMatch({
    required String name1,
    required String name2,
  }) =>
      _client.post('/v2/matrimony/name-match', {
        'name1': name1,
        'name2': name2,
      });

  /// Marriage prediction.
  Future<Map<String, dynamic>> prediction(Map<String, dynamic> params) =>
      _client.post('/v2/matrimony/prediction', params);
}
