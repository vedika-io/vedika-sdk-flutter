import '../client.dart';

/// Geocode utility endpoints under `/v2/geocode/`.
///
/// 3 GET endpoints (free, no wallet deduction):
/// search, resolve, reverse.
class GeocodeService {
  final VedikaClient _client;
  GeocodeService(this._client);

  /// Search/autocomplete for a place.
  Future<Map<String, dynamic>> search({required String query}) =>
      _client.get('/v2/geocode/search', queryParams: {'q': query});

  /// Resolve a placeId to coordinates + timezone.
  Future<Map<String, dynamic>> resolve({
    required String placeId,
    String? birthDate,
  }) =>
      _client.get('/v2/geocode/resolve', queryParams: {
        'placeId': placeId,
        if (birthDate != null) 'birthDate': birthDate,
      });

  /// Reverse geocode: lat/lng to nearest city.
  Future<Map<String, dynamic>> reverse({
    required double latitude,
    required double longitude,
  }) =>
      _client.get('/v2/geocode/reverse', queryParams: {
        'lat': latitude.toString(),
        'lng': longitude.toString(),
      });
}
