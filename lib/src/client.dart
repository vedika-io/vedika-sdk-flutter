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
  VedikaClient({
    required String apiKey,
    String? baseUrl,
    Duration? timeout,
    http.Client? httpClient,
  })  : config = VedikaConfig(
          apiKey: apiKey,
          baseUrl: baseUrl ?? 'https://api.vedika.io',
          timeout: timeout ?? const Duration(seconds: 30),
        ),
        _httpClient = httpClient ?? http.Client(),
        _ownsClient = httpClient == null {
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

  /// Sends a GET request to the Vedika API.
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, String>? queryParams,
  }) async {
    final uri = Uri.parse('${config.baseUrl}$path')
        .replace(queryParameters: queryParams);
    final response = await _httpClient
        .get(uri, headers: _headers)
        .timeout(config.timeout);
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
    final response = await _httpClient
        .get(uri, headers: _headers)
        .timeout(config.timeout);
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
    final response = await _httpClient
        .post(uri, headers: _headers, body: jsonEncode(body))
        .timeout(config.timeout);
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
        if (response.statusCode >= 500) {
          throw VedikaServerError(
            body['error']?.toString() ??
                'Server error: ${response.statusCode}',
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
