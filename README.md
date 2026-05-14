# Vedika SDK for Flutter/Dart

Official Flutter/Dart SDK for the [Vedika Intelligence API](https://vedika.io) -- the world's most comprehensive astrology and spiritual intelligence API.

Covers **500+ endpoints** across **23 domains** including Vedic astrology, Western astrology, tarot, Chinese astrology, I Ching, numerology, crystals, runes, human design, palmistry, and more.

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  vedika_sdk: ^1.0.0
```

Then run:

```bash
dart pub get
```

## Quick Start

```dart
import 'package:vedika_sdk/vedika_sdk.dart';

void main() async {
  final vedika = VedikaClient(apiKey: 'vk_live_YOUR_API_KEY');

  try {
    // Get a birth chart
    final chart = await vedika.astrology.birthChart(BirthDetails(
      datetime: '1990-06-15T10:30:00',
      latitude: 18.5204,
      longitude: 73.8567,
      timezone: 'Asia/Kolkata',
    ));
    print('Birth chart: ${chart['data']}');

    // Draw a tarot card
    final tarot = await vedika.tarot.drawSingle(
      question: 'What energy surrounds me today?',
    );
    print('Tarot: ${tarot['data']}');

    // Daily horoscope
    final horoscope = await vedika.daily.horoscope('aries');
    print('Horoscope: ${horoscope['data']}');

  } on VedikaAuthError {
    print('Invalid API key');
  } on VedikaInsufficientCredits {
    print('Please add funds to your wallet');
  } finally {
    vedika.dispose();
  }
}
```

## Available Services

| Service | Domain | Endpoints | Description |
|---------|--------|-----------|-------------|
| `vedika.astrology` | Vedic Astrology | 70+ | Birth charts, dashas, doshas, panchang, muhurta, KP, Jaimini, Tajaka, Vastu, Lal Kitab, numerology, festivals |
| `vedika.western` | Western Astrology | 50+ | Natal, transits, progressions, solar returns, synastry, composites, midpoints, harmonics, astrocartography |
| `vedika.tarot` | Tarot | 25 | Card database, 15 spread types, AI interpretation, compatibility, astro-fusion |
| `vedika.chinese` | Chinese Astrology | 15 | Zodiac, Ba Zi, Feng Shui, Zi Wei, compatibility, daily/monthly/yearly |
| `vedika.iching` | I Ching | 8 | Hexagram casting, lookup, changing lines, question, interpretation, compatibility |
| `vedika.numerology` | Numerology | 18+ | Pythagorean, Chaldean, Lo Shu, Vedic, Kabbalah, business/phone/address |
| `vedika.matrimony` | Matrimony | 15 | Compatibility, dosha cancellation, North/South match, bulk match, D9, PDF report |
| `vedika.humanDesign` | Human Design | 10 | BodyGraph, type, strategy, authority, profile, centers, gates, channels |
| `vedika.crystals` | Crystals | 10 | Zodiac/planet/chakra lookup, healing, compatibility, birth crystal, meditation |
| `vedika.spiritual` | Spiritual | 10 | Mantra, deity, meditation, pilgrimage, puja, rudraksha, yantra, karma, fasting |
| `vedika.health` | Health | 8 | Vulnerabilities, Ayurvedic type, mental wellness, chakra, yoga, diet |
| `vedika.career` | Career & Finance | 7 | Suitable careers, timing, promotion, wealth, investment, business, property |
| `vedika.daily` | Daily Content | 12 | Horoscope, tarot, angel number, crystal, mantra, panchang, moon phase, rune, I Ching, bundle, feed |
| `vedika.dreams` | Dreams | 6 | Symbol lookup, catalog, themes, interpret, lucky numbers, frequency |
| `vedika.angelNumbers` | Angel Numbers | 5 | Lookup, daily, personal, repeating, message |
| `vedika.biorhythm` | Biorhythm | 6 | Chart, today, critical days, compatibility, forecast, best days |
| `vedika.lifestyle` | Lifestyle | 8 | Love compatibility, zodiac gifts/food/travel/fitness, fortune cookie, spirit animal |
| `vedika.lenormand` | Lenormand | 5 | Single/three/grand tableau draw, card lookup, combination |
| `vedika.oracle` | Oracle Cards | 4 | Single/three draw, daily, themes |
| `vedika.palmistry` | Palmistry | 5 | Lines, mounts, fingers, shapes, AI reading |
| `vedika.runes` | Runes | 5 | Single/three/five draw, meaning, catalog |
| `vedika.calculators` | Calculators | 5 | FLAMES, love score, moon sign, sun sign, nakshatra finder |
| `vedika.reports` | Reports | 7 | Nakshatra predictions, house/rashi/planet reports, complete life report |
| `vedika.widgets` | Widgets | 5 | Embeddable HTML widgets (horoscope, tarot, compatibility, panchang, birth chart) |
| `vedika.geocode` | Geocode | 3 | Search, resolve, reverse (free utility) |

## Error Handling

The SDK throws typed exceptions:

```dart
try {
  final result = await vedika.tarot.drawSingle();
} on VedikaAuthError catch (e) {
  // 401 - Invalid or missing API key
  print(e.message);
} on VedikaInsufficientCredits catch (e) {
  // 402 - Wallet balance too low
  print(e.message);
} on VedikaSubscriptionError catch (e) {
  // 403 - Subscription inactive
  print(e.message);
} on VedikaRateLimitError catch (e) {
  // 429 - Rate limit exceeded
  print('Retry after ${e.retryAfterSeconds} seconds');
} on VedikaServerError catch (e) {
  // 5xx - Server error
  print(e.message);
} on VedikaApiError catch (e) {
  // Any other API error
  print(e.message);
}
```

## Configuration

```dart
final vedika = VedikaClient(
  apiKey: 'vk_live_YOUR_KEY',
  baseUrl: 'https://api.vedika.io',  // default
  timeout: Duration(seconds: 60),     // default: 30s
);
```

## Testing

Inject a mock HTTP client for testing:

```dart
import 'package:http/testing.dart';

final mockClient = MockClient((request) async {
  return http.Response('{"success": true, "data": {}}', 200);
});

final vedika = VedikaClient(
  apiKey: 'vk_test_key',
  httpClient: mockClient,
);
```

## Response Format

All endpoints return `Map<String, dynamic>` with this structure:

```json
{
  "success": true,
  "data": { ... },
  "billing": {
    "charged": 0.003,
    "currency": "USD"
  },
  "meta": {
    "engine": "vedika-intelligence",
    "version": "2.1.0"
  }
}
```

Use the typed model classes for parsing:

```dart
final response = await vedika.astrology.birthChart(birthDetails);
final planets = (response['data']['planets'] as List)
    .map((p) => PlanetPosition.fromJson(p))
    .toList();
```

## Multi-language Support

Most endpoints support `?lang=` parameter for responses in 31 languages:

```dart
final panchang = await vedika.astrology.panchang({
  'datetime': '2026-01-01T06:00:00',
  'latitude': 18.52,
  'longitude': 73.85,
  'lang': 'hi', // Hindi
});
```

## Links

- [API Documentation](https://vedika.io/docs)
- [Dashboard](https://vedika.io/dashboard)
- [JavaScript SDK](https://www.npmjs.com/package/vedika-sdk)
- [Python SDK](https://pypi.org/project/vedika-sdk/)

## License

MIT License. See [LICENSE](LICENSE).
