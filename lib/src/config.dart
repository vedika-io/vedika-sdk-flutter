/// Configuration for the Vedika Intelligence API client.
class VedikaConfig {
  /// Your Vedika API key (format: `vk_live_*` or `vk_ent_*`).
  final String apiKey;

  /// Base URL for the API. Defaults to `https://api.vedika.io`.
  final String baseUrl;

  /// Request timeout. Defaults to 30 seconds.
  final Duration timeout;

  /// Creates a new [VedikaConfig].
  ///
  /// [apiKey] is required. Obtain one from https://vedika.io/dashboard.
  const VedikaConfig({
    required this.apiKey,
    this.baseUrl = 'https://api.vedika.io',
    this.timeout = const Duration(seconds: 30),
  });
}
