import '../client.dart';

/// Palmistry endpoints under `/v2/palmistry/`.
///
/// 5 endpoints: lines, mounts, fingers, shapes, AI reading.
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

  /// AI-powered palm reading (placeholder).
  Future<Map<String, dynamic>> aiReading() =>
      _client.post('/v2/palmistry/ai-reading', {});
}
