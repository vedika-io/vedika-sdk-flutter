import '../client.dart';
import '../models/common.dart';

/// Human Design endpoints under `/v2/human-design/`.
///
/// 10 endpoints: chart, type, strategy, authority, profile,
/// centers, gates, channels, compatibility, transit.
class HumanDesignService {
  final VedikaClient _client;
  HumanDesignService(this._client);

  /// Full BodyGraph chart.
  Future<Map<String, dynamic>> chart(BirthDetails bd) =>
      _client.post('/v2/human-design/chart', bd.toJson());

  /// Type + Strategy + Signature.
  Future<Map<String, dynamic>> type(BirthDetails bd) =>
      _client.post('/v2/human-design/type', bd.toJson());

  /// Strategy for decision-making.
  Future<Map<String, dynamic>> strategy(BirthDetails bd) =>
      _client.post('/v2/human-design/strategy', bd.toJson());

  /// Inner authority.
  Future<Map<String, dynamic>> authority(BirthDetails bd) =>
      _client.post('/v2/human-design/authority', bd.toJson());

  /// Profile (line/line).
  Future<Map<String, dynamic>> profile(BirthDetails bd) =>
      _client.post('/v2/human-design/profile', bd.toJson());

  /// Defined/undefined centers.
  Future<Map<String, dynamic>> centers(BirthDetails bd) =>
      _client.post('/v2/human-design/centers', bd.toJson());

  /// Activated gates.
  Future<Map<String, dynamic>> gates(BirthDetails bd) =>
      _client.post('/v2/human-design/gates', bd.toJson());

  /// Active channels.
  Future<Map<String, dynamic>> channels(BirthDetails bd) =>
      _client.post('/v2/human-design/channels', bd.toJson());

  /// Compatibility between two BodyGraphs.
  Future<Map<String, dynamic>> compatibility(MatchingPair pair) =>
      _client.post('/v2/human-design/compatibility', pair.toJson());

  /// Current transit influence.
  Future<Map<String, dynamic>> transit({String? date}) =>
      _client.post('/v2/human-design/transit', {
        if (date != null) 'transitDate': date,
      });
}
