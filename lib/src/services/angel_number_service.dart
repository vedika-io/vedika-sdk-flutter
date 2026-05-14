import '../client.dart';

/// Angel number endpoints under `/v2/angel-numbers/`.
///
/// 5 endpoints: lookup, daily, personal, repeating, message.
class AngelNumberService {
  final VedikaClient _client;
  AngelNumberService(this._client);

  // ── GET Endpoints ────────────────────────────────────────────────

  /// Lookup the meaning of an angel number.
  Future<Map<String, dynamic>> lookup(int number) =>
      _client.get('/v2/angel-numbers/lookup/$number');

  /// Daily angel number.
  Future<Map<String, dynamic>> daily({String? date}) =>
      _client.get('/v2/angel-numbers/daily', queryParams: {
        if (date != null) 'date': date,
      });

  // ── POST Endpoints ───────────────────────────────────────────────

  /// Personal angel number from date of birth.
  Future<Map<String, dynamic>> personal({required String dateOfBirth}) =>
      _client.post(
          '/v2/angel-numbers/personal', {'dateOfBirth': dateOfBirth});

  /// Analyze repeating number patterns.
  Future<Map<String, dynamic>> repeating(
          {required List<int> numbers}) =>
      _client.post('/v2/angel-numbers/repeating', {'numbers': numbers});

  /// Angel message for a question.
  Future<Map<String, dynamic>> message({required String question}) =>
      _client.post('/v2/angel-numbers/message', {'question': question});
}
