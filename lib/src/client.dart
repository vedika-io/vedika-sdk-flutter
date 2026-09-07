import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'config.dart';
import 'exceptions.dart';
import 'services/astrology_service.dart';
import 'services/western_service.dart';
import 'services/tarot_service.dart';
import 'services/chinese_service.dart';
import 'services/iching_service.dart';
import 'services/numerology_service.dart';
import 'services/matrimony_service.dart';
import 'services/human_design_service.dart';
import 'services/crystal_service.dart';
import 'services/spiritual_service.dart';
import 'services/health_service.dart';
import 'services/career_service.dart';
import 'services/daily_service.dart';
import 'services/dream_service.dart';
import 'services/angel_number_service.dart';
import 'services/biorhythm_service.dart';
import 'services/lifestyle_service.dart';
import 'services/lenormand_service.dart';
import 'services/oracle_service.dart';
import 'services/palmistry_service.dart';
import 'services/rune_service.dart';
import 'services/calculator_service.dart';
import 'services/report_service.dart';
import 'services/widget_service.dart';
import 'services/geocode_service.dart';

/// Main client for the Vedika Intelligence API.
///
/// Instantiate with your API key and access all 23 domain services:
///
/// ```dart
/// final vedika = VedikaClient(apiKey: 'vk_live_...');
/// final chart = await vedika.astrology.birthChart(birthDetails);
/// vedika.dispose();
/// ```
class VedikaClient {
  /// SDK configuration (API key, base URL, timeout).
  final VedikaConfig config;

  final http.Client _httpClient;
  final bool _ownsClient;

  /// The single host this client is permitted to send the API key to, pinned at
  /// construction from the validated [config.baseUrl].
  late final String _allowedHost;

  /// The canonical Vedika API origin. The only host allowed by default.
  static const String vedikaApiHost = 'api.vedika.io';

  /// Vedic astrology: birth charts, dashas, doshas, panchang, muhurta,
  /// matching, predictions, KP, Jaimini, Tajaka, Vastu, Lal Kitab,
  /// numerology, ashtakavarga, divisional charts, and more.
  late final AstrologyService astrology;

  /// Western (tropical) astrology: natal charts, transits, progressions,
  /// solar returns, synastry, composites, midpoints, harmonics.
  late final WesternService western;

  /// Tarot: 25 endpoints for card lookups, spreads, readings, AI
  /// interpretation, compatibility, and astro-fusion.
  late final TarotService tarot;

  /// Chinese astrology: zodiac, Ba Zi, Feng Shui, Zi Wei, compatibility,
  /// daily/monthly/yearly forecasts, calendar.
  late final ChineseService chinese;

  /// I Ching: hexagram casting, lookup, changing lines, daily readings,
  /// question-based casting, trigrams, interpretation.
  late final IChingService iching;

  /// Numerology (standalone): life path, destiny, personality, soul urge,
  /// complete profile, and compatibility.
  late final NumerologyService numerology;

  /// Matrimony: compatibility scoring, dosha cancellation, North/South
  /// matching, Mangal quick-check, Nadi, bulk match, D9 analysis.
  late final MatrimonyService matrimony;

  /// Human Design: BodyGraph chart, type, strategy, authority, profile,
  /// centers, gates, channels, compatibility, transit.
  late final HumanDesignService humanDesign;

  /// Crystals and gemstones: zodiac/planet/chakra lookup, properties,
  /// catalog, healing, compatibility, birth crystal, meditation.
  late final CrystalService crystals;

  /// Spiritual: mantra, deity, meditation, pilgrimage, puja, rudraksha,
  /// yantra, past-life, karma, fasting.
  late final SpiritualService spiritual;

  /// Health astrology: vulnerabilities, timing, remedies, Ayurvedic type,
  /// mental wellness, chakra, yoga, diet.
  late final HealthService health;

  /// Career and finance: suitable careers, timing, promotion, wealth,
  /// investment, business start, property.
  late final CareerService career;

  /// Daily content: horoscope, tarot, angel number, crystal, mantra,
  /// panchang, muhurta, moon phase, rune, I Ching, bundle, feed.
  late final DailyService daily;

  /// Dream interpretation: symbol lookup, catalog, themes, interpret,
  /// lucky numbers, frequency analysis.
  late final DreamService dreams;

  /// Angel numbers: lookup, daily, personal, repeating, message.
  late final AngelNumberService angelNumbers;

  /// Biorhythm: chart, today, critical days, compatibility, forecast,
  /// best days.
  late final BiorhythmService biorhythm;

  /// Lifestyle: love compatibility, zodiac gifts/food/travel/fitness,
  /// fortune cookie, spirit animal, lucky color.
  late final LifestyleService lifestyle;

  /// Lenormand: single/three-card/grand tableau draws, card lookup,
  /// combination interpretation.
  late final LenormandService lenormand;

  /// Oracle cards: single/three-card draw, daily, themes.
  late final OracleService oracle;

  /// Palmistry: lines, mounts, fingers, shapes, AI reading.
  late final PalmistryService palmistry;

  /// Runes (Elder Futhark): single/three/five draw, meaning lookup,
  /// catalog.
  late final RuneService runes;

  /// Fun calculators: FLAMES, love score, moon sign, sun sign,
  /// nakshatra finder.
  late final CalculatorService calculators;

  /// Reports: nakshatra predictions (daily/weekly/monthly),
  /// house/rashi/planet reports, complete life report.
  late final ReportService reports;

  /// Embeddable HTML widgets: horoscope, tarot, compatibility,
  /// panchang, birth chart.
  late final WidgetService widgets;

  /// Geocode utilities: search, resolve, reverse.
  late final GeocodeService geocode;

  /// Creates a [VedikaClient].
  ///
  /// [apiKey] is required. Format: `vk_live_*` (production)
  /// or `vk_ent_*` (enterprise).
  ///
  /// Optionally inject a custom [httpClient] for testing.
  ///
  /// [trustedHosts] is the deliberate, per-host escape hatch for a customer
  /// gateway or reverse proxy. You must name the exact host the API key is
  /// allowed to reach; there is no blanket "any host" switch, because that is
  /// the bug this gate exists to prevent.
  VedikaClient({
    required String apiKey,
    String? baseUrl,
    Duration? timeout,
    http.Client? httpClient,
    bool allowInsecureHttp = false,
    List<String> trustedHosts = const [],
  })  : config = VedikaConfig(
          apiKey: apiKey,
          baseUrl: baseUrl ?? 'https://api.vedika.io',
          timeout: timeout ?? const Duration(seconds: 30),
        ),
        _httpClient = httpClient ?? http.Client(),
        _ownsClient = httpClient == null {
    // Credential-routing policy (R-004). Two independent gates, both closed by
    // default:
    //   scheme - the key rides only on HTTPS, so a cleartext baseUrl can't ship
    //            it in the clear. HTTP is allowed for loopback (local dev);
    //            remote HTTP only behind an explicit, clearly-unsafe opt-in.
    //   origin - the key is attached only for the Vedika API host, loopback, or
    //            a host the caller named in [trustedHosts]. Without this an
    //            attacker-supplied baseUrl (remote config, deep link, QR) makes
    //            a shipped mobile app POST the customer's key to the attacker.
    // Throws on anything else, before any request can carry the key.
    _assertSafeBaseUrl(config.baseUrl, allowInsecureHttp, trustedHosts);
    _allowedHost = Uri.parse(config.baseUrl).host.toLowerCase();
    astrology = AstrologyService(this);
    western = WesternService(this);
    tarot = TarotService(this);
    chinese = ChineseService(this);
    iching = IChingService(this);
    numerology = NumerologyService(this);
    matrimony = MatrimonyService(this);
    humanDesign = HumanDesignService(this);
    crystals = CrystalService(this);
    spiritual = SpiritualService(this);
    health = HealthService(this);
    career = CareerService(this);
    daily = DailyService(this);
    dreams = DreamService(this);
    angelNumbers = AngelNumberService(this);
    biorhythm = BiorhythmService(this);
    lifestyle = LifestyleService(this);
    lenormand = LenormandService(this);
    oracle = OracleService(this);
    palmistry = PalmistryService(this);
    runes = RuneService(this);
    calculators = CalculatorService(this);
    reports = ReportService(this);
    widgets = WidgetService(this);
    geocode = GeocodeService(this);
  }

  /// Sends a request with redirect-following DISABLED.
  ///
  /// Credential-routing hardening (R-004): the `http` convenience methods
  /// (`get`/`post`) follow redirects with `followRedirects = true` and re-send
  /// the `Authorization` header to the redirect destination, leaking the API
  /// key to whatever origin a 3xx points at. Building the request explicitly
  /// with `followRedirects = false` means a 3xx is returned as-is and surfaces
  /// as an error in [_handleResponse] — the key is never forwarded.
  Future<http.Response> _send(
    String method,
    Uri uri, {
    String? body,
  }) async {
    // Defence in depth: never attach the key to a host other than the one
    // validated at construction. The URI is built from config.baseUrl plus a
    // fixed "/v2/..." path, so this cannot fire today - it is here so that any
    // future change to URI construction fails closed instead of leaking.
    if (uri.host.toLowerCase() != _allowedHost) {
      throw ArgumentError.value(
        uri.toString(),
        'uri',
        'refusing to send credentials to "${uri.host}"; this client is '
            'pinned to "$_allowedHost"',
      );
    }
    final request = http.Request(method, uri);
    request.headers.addAll(_headers);
    request.followRedirects = false;
    if (body != null) request.body = body;
    final streamed = await _httpClient.send(request).timeout(config.timeout);
    return http.Response.fromStream(streamed);
  }

  /// Sends a GET request to the Vedika API.
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, String>? queryParams,
  }) async {
    final uri = Uri.parse('${config.baseUrl}$path')
        .replace(queryParameters: queryParams);
    final response = await _send('GET', uri);
    return _handleResponse(response);
  }

  /// Sends a GET request and returns the raw response body as a string.
  /// Used for widget endpoints that return HTML.
  Future<String> getRaw(
    String path, {
    Map<String, String>? queryParams,
  }) async {
    final uri = Uri.parse('${config.baseUrl}$path')
        .replace(queryParameters: queryParams);
    final response = await _send('GET', uri);
    if (response.statusCode != 200) {
      _handleResponse(response); // will throw
    }
    return response.body;
  }

  /// Sends a POST request to the Vedika API.
  Future<Map<String, dynamic>> post(
    String path,
    Map<String, dynamic> body,
  ) async {
    final uri = Uri.parse('${config.baseUrl}$path');
    final response = await _send('POST', uri, body: jsonEncode(body));
    return _handleResponse(response);
  }

  Map<String, String> get _headers => {
        'Authorization': 'Bearer ${config.apiKey}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-SDK': 'vedika-flutter/1.0.0',
      };

  Map<String, dynamic> _handleResponse(http.Response response) {
    Map<String, dynamic> body;
    try {
      body = jsonDecode(response.body) as Map<String, dynamic>;
    } catch (_) {
      body = {'error': response.body};
    }

    switch (response.statusCode) {
      case 200:
        return body;
      case 401:
        throw VedikaAuthError(
          body['error']?.toString() ?? 'Invalid API key',
          body: body,
        );
      case 402:
        throw VedikaInsufficientCredits(
          body['error']?.toString() ?? 'Insufficient wallet balance',
          body: body,
        );
      case 403:
        throw VedikaSubscriptionError(
          body['message']?.toString() ?? 'Subscription inactive',
          body: body,
        );
      case 429:
        throw VedikaRateLimitError(
          body['message']?.toString() ?? 'Rate limit exceeded',
          body: body,
          retryAfterSeconds:
              int.tryParse(response.headers['retry-after'] ?? ''),
        );
      default:
        if (response.statusCode >= 300 && response.statusCode < 400) {
          // Credential-routing (R-004): redirects are not followed, so the API
          // key is never forwarded to the redirect destination. A 3xx from the
          // API is unexpected and surfaced as an error rather than chased.
          throw VedikaApiError(
            'Unexpected redirect (HTTP ${response.statusCode}) not followed; '
            'credentials were not forwarded. Check baseUrl.',
            statusCode: response.statusCode,
            body: body,
          );
        }
        if (response.statusCode >= 500) {
          throw VedikaServerError(
            body['error']?.toString() ?? 'Server error: ${response.statusCode}',
            statusCode: response.statusCode,
            body: body,
          );
        }
        throw VedikaApiError(
          body['error']?.toString() ?? 'API error: ${response.statusCode}',
          statusCode: response.statusCode,
          body: body,
        );
    }
  }

  /// True only for genuine loopback: the literal `localhost` or a loopback IP
  /// (127.0.0.0/8, ::1). A DNS name that merely starts with "127." (e.g.
  /// `127.attacker.invalid`) is NOT loopback and must not bypass the policy.
  static bool _isLoopbackHost(String host) {
    final h = host.replaceAll(RegExp(r'^\[|\]$'), '').toLowerCase();
    if (h == 'localhost' || h == '::1') return true;
    // Parse-only 127.0.0.0/8 check. Deliberately NOT dart:io's
    // InternetAddress — that is unavailable on Flutter Web (compiled to JS it
    // throws UnsupportedOperation), which made http://127.0.0.1 dev unusable
    // there. Safe-direction: unusual loopback forms fall through and simply
    // require the allowInsecureHttp opt-in.
    final m = RegExp(r'^127\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$').firstMatch(h);
    if (m == null) return false;
    for (var i = 1; i <= 3; i++) {
      if ((int.tryParse(m.group(i)!) ?? 999) > 255) return false;
    }
    return true;
  }

  /// True when [host] is the Vedika API origin, loopback, or a host the caller
  /// explicitly named in `trustedHosts`. Exact, case-insensitive match only:
  /// suffix matching would accept `api.vedika.io.attacker.invalid`.
  static bool _isAllowedHost(String host, List<String> trustedHosts) {
    final h = host.toLowerCase();
    if (h == vedikaApiHost) return true;
    if (_isLoopbackHost(h)) return true;
    for (final t in trustedHosts) {
      final candidate = t.trim().toLowerCase();
      // A wildcard is not an allowlist. Reject it rather than honour it.
      if (candidate.isEmpty || candidate.contains('*')) continue;
      if (candidate == h) return true;
    }
    return false;
  }

  /// Enforce the credential-routing policy (R-004): scheme gate and origin
  /// gate. Throws [ArgumentError] on a disallowed baseUrl, so the key is never
  /// shipped in the clear or off-domain by misconfiguration.
  static void _assertSafeBaseUrl(
      String baseUrl, bool allowInsecureHttp, List<String> trustedHosts) {
    final uri = Uri.tryParse(baseUrl);
    if (uri == null || !uri.hasScheme) {
      throw ArgumentError.value(baseUrl, 'baseUrl', 'is not a valid URL');
    }
    // Reject embedded credentials / path / query / fragment: the URL
    // "https://api.vedika.io@attacker.invalid" parses with host
    // "attacker.invalid" but reads as api.vedika.io, so the Bearer key would
    // ride to the attacker on the first request. (R-004 credential routing)
    if (uri.userInfo.isNotEmpty) {
      throw ArgumentError.value(baseUrl, 'baseUrl',
          'must not contain embedded credentials (user:pass@host)');
    }
    if ((uri.path.isNotEmpty && uri.path != '/') ||
        uri.hasQuery ||
        uri.fragment.isNotEmpty) {
      throw ArgumentError.value(baseUrl, 'baseUrl',
          'must be a bare origin (scheme://host[:port]) with no path/query/fragment');
    }
    // Origin gate. Deliberately evaluated BEFORE the scheme decision so that
    // allowInsecureHttp relaxes the scheme only and can never widen the host.
    if (!_isAllowedHost(uri.host, trustedHosts)) {
      throw ArgumentError.value(
        baseUrl,
        'baseUrl',
        'host "${uri.host}" is not an approved Vedika origin - the API key '
            'would be sent off-domain. Use https://$vedikaApiHost, or name the '
            'host in trustedHosts if you deliberately route through a proxy',
      );
    }
    if (uri.scheme == 'https') return;
    if (uri.scheme == 'http') {
      if (_isLoopbackHost(uri.host) || allowInsecureHttp) return;
      throw ArgumentError.value(
        baseUrl,
        'baseUrl',
        'must be https:// — http:// is allowed only for loopback, or set '
            'allowInsecureHttp: true to opt in to remote cleartext HTTP',
      );
    }
    throw ArgumentError.value(
        baseUrl, 'baseUrl', 'must use the http or https scheme');
  }

  /// Closes the underlying HTTP client.
  ///
  /// Only closes the client if it was created by this instance
  /// (not injected via constructor).
  void dispose() {
    if (_ownsClient) {
      _httpClient.close();
    }
  }
}
