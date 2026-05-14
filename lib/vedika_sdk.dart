/// Vedika Intelligence API SDK for Flutter/Dart.
///
/// Provides typed access to 500+ endpoints across 23 domains:
/// astrology, tarot, numerology, Chinese astrology, I Ching,
/// crystals, runes, human design, palmistry, and more.
///
/// ```dart
/// import 'package:vedika_sdk/vedika_sdk.dart';
///
/// final vedika = VedikaClient(apiKey: 'vk_live_...');
///
/// // Vedic birth chart
/// final chart = await vedika.astrology.birthChart(BirthDetails(
///   datetime: '1990-06-15T10:30:00',
///   latitude: 18.5204,
///   longitude: 73.8567,
/// ));
///
/// // Tarot reading
/// final reading = await vedika.tarot.drawThreeCard(
///   question: 'What does my week look like?',
/// );
///
/// vedika.dispose();
/// ```
library vedika_sdk;

// Core
export 'src/client.dart';
export 'src/config.dart';
export 'src/exceptions.dart';

// Models
export 'src/models/common.dart';
export 'src/models/birth_chart.dart';
export 'src/models/dasha.dart';
export 'src/models/dosha.dart';
export 'src/models/tarot.dart';
export 'src/models/chinese.dart';
export 'src/models/iching.dart';
export 'src/models/numerology.dart';
export 'src/models/matrimony.dart';
export 'src/models/human_design.dart';
export 'src/models/crystal.dart';
export 'src/models/spiritual.dart';
export 'src/models/health.dart';
export 'src/models/career.dart';
export 'src/models/daily.dart';

// Services
export 'src/services/astrology_service.dart';
export 'src/services/western_service.dart';
export 'src/services/tarot_service.dart';
export 'src/services/chinese_service.dart';
export 'src/services/iching_service.dart';
export 'src/services/numerology_service.dart';
export 'src/services/matrimony_service.dart';
export 'src/services/human_design_service.dart';
export 'src/services/crystal_service.dart';
export 'src/services/spiritual_service.dart';
export 'src/services/health_service.dart';
export 'src/services/career_service.dart';
export 'src/services/daily_service.dart';
export 'src/services/dream_service.dart';
export 'src/services/angel_number_service.dart';
export 'src/services/biorhythm_service.dart';
export 'src/services/lifestyle_service.dart';
export 'src/services/lenormand_service.dart';
export 'src/services/oracle_service.dart';
export 'src/services/palmistry_service.dart';
export 'src/services/rune_service.dart';
export 'src/services/calculator_service.dart';
export 'src/services/report_service.dart';
export 'src/services/widget_service.dart';
export 'src/services/geocode_service.dart';
