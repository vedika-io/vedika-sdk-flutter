import '../client.dart';

/// Embeddable HTML widget endpoints under `/v2/widget/`.
///
/// 5 GET endpoints returning self-contained HTML for iframe embedding.
/// Supports light/dark themes.
class WidgetService {
  final VedikaClient _client;
  WidgetService(this._client);

  /// Horoscope widget HTML.
  Future<String> horoscope({
    String sign = 'aries',
    String theme = 'light',
  }) =>
      _client.getRaw('/v2/widget/horoscope', queryParams: {
        'sign': sign,
        'theme': theme,
      });

  /// Tarot card widget HTML.
  Future<String> tarot({String theme = 'light'}) =>
      _client.getRaw('/v2/widget/tarot', queryParams: {
        'theme': theme,
      });

  /// Compatibility widget HTML.
  Future<String> compatibility({
    String sign1 = 'aries',
    String sign2 = 'leo',
    String theme = 'light',
  }) =>
      _client.getRaw('/v2/widget/compatibility', queryParams: {
        'sign1': sign1,
        'sign2': sign2,
        'theme': theme,
      });

  /// Panchang widget HTML.
  Future<String> panchang({
    String lang = 'en',
    String theme = 'light',
  }) =>
      _client.getRaw('/v2/widget/panchang', queryParams: {
        'lang': lang,
        'theme': theme,
      });

  /// Birth chart widget HTML.
  Future<String> birthChart({String theme = 'light'}) =>
      _client.getRaw('/v2/widget/birth-chart', queryParams: {
        'theme': theme,
      });
}
