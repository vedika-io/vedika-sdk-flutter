import '../client.dart';

/// Palmistry endpoints under `/v2/palmistry/`.
///
/// Palm references, AI readings and follow-up questions.
class PalmistryService {
  final VedikaClient _client;
  PalmistryService(this._client);

  /// Major palm lines reference.
  Future<Map<String, dynamic>> lines() =>
      _client.get('/v2/palmistry/lines');

  /// Palm mounts reference.
  Future<Map<String, dynamic>> mounts() =>
      _client.get('/v2/palmistry/mounts');

  /// Finger types reference.
  Future<Map<String, dynamic>> fingers() =>
      _client.get('/v2/palmistry/fingers');

  /// Hand shapes reference.
  Future<Map<String, dynamic>> shapes() =>
      _client.get('/v2/palmistry/shapes');

  /// Ask a follow-up question about a stored palm reading.
  ///
  /// [readingId] comes from a palm reading. When [language] is omitted, the
  /// API detects it from [question]. Earlier [history] messages are sent in
  /// their original order. Reuse [idempotencyKey] when retrying one question.
  Future<Map<String, dynamic>> ask(
    String readingId,
    String question, {
    String? language,
    List<Map<String, String>>? history,
    String? idempotencyKey,
  }) =>
      _client.post('/v2/palmistry/ask', {
        'readingId': readingId,
        'question': question,
        if (language != null) 'language': language,
        if (history != null) 'history': history,
      }, idempotencyKey: idempotencyKey);

  /// AI-powered palm reading (placeholder).
  Future<Map<String, dynamic>> aiReading() =>
      _client.post('/v2/palmistry/ai-reading', {});
}
