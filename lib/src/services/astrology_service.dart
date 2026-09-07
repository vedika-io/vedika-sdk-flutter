import '../client.dart';
import '../models/common.dart';

/// Vedic astrology endpoints under `/v2/astrology/`.
///
/// Covers birth charts, dashas, doshas, panchang, muhurta, matching,
/// predictions, KP, Jaimini, Tajaka, Vastu, Lal Kitab, numerology,
/// ashtakavarga, divisional charts, festivals, fixed stars, remedies,
/// house systems, extended transits, prashna, and advanced analysis.
class AstrologyService {
  final VedikaClient _client;
  AstrologyService(this._client);

  // ── Charts & Kundli ──────────────────────────────────────────────

  /// Full birth chart with planetary positions, houses, aspects.
  Future<Map<String, dynamic>> birthChart(BirthDetails bd) =>
      _client.post('/v2/astrology/birth-chart', bd.toJson());

  /// Kundli (North/South Indian chart layout).
  Future<Map<String, dynamic>> kundli(BirthDetails bd) =>
      _client.post('/v2/astrology/kundli', bd.toJson());

  /// Planets-only (lighter response).
  Future<Map<String, dynamic>> planets(BirthDetails bd) =>
      _client.post('/v2/astrology/planets', bd.toJson());

  /// Houses (cusps and lords).
  Future<Map<String, dynamic>> houses(BirthDetails bd) =>
      _client.post('/v2/astrology/houses', bd.toJson());

  // ── Dasha ────────────────────────────────────────────────────────

  /// Vimshottari Maha Dasha periods.
  Future<Map<String, dynamic>> mahaDasha(BirthDetails bd) =>
      _client.post('/v2/astrology/maha-dasha', bd.toJson());

  /// Current dasha (maha + antar + pratyantar).
  Future<Map<String, dynamic>> currentDasha(BirthDetails bd) =>
      _client.post('/v2/astrology/current-dasha', bd.toJson());

  /// Antar Dasha sub-periods for a given Maha Dasha planet.
  Future<Map<String, dynamic>> antarDasha(BirthDetails bd) =>
      _client.post('/v2/astrology/antar-dasha', bd.toJson());

  // ── Doshas ───────────────────────────────────────────────────────

  /// Mangal Dosha (Kuja Dosha) analysis.
  Future<Map<String, dynamic>> mangalDosha(BirthDetails bd) =>
      _client.post('/v2/astrology/mangal-dosha', bd.toJson());

  /// Kaal Sarp Dosha analysis.
  Future<Map<String, dynamic>> kaalSarpDosha(BirthDetails bd) =>
      _client.post('/v2/astrology/kaal-sarp-dosha', bd.toJson());

  /// Sade Sati (Saturn transit over Moon) status.
  Future<Map<String, dynamic>> sadeSati(BirthDetails bd) =>
      _client.post('/v2/astrology/sade-sati', bd.toJson());

  /// Pitra Dosha analysis.
  Future<Map<String, dynamic>> pitraDosha(BirthDetails bd) =>
      _client.post('/v2/astrology/pitra-dosha', bd.toJson());

  // ── Panchang ─────────────────────────────────────────────────────

  /// Daily Panchang for a date and location.
  Future<Map<String, dynamic>> panchang(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/panchang', params);

  /// Tithi details.
  Future<Map<String, dynamic>> tithi(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/tithi', params);

  /// Nakshatra details.
  Future<Map<String, dynamic>> nakshatra(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/nakshatra', params);

  /// Yoga (Panchang yoga, not physical yoga).
  Future<Map<String, dynamic>> yoga(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/yoga', params);

  /// Karana details.
  Future<Map<String, dynamic>> karana(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/karana', params);

  /// Sunrise/sunset/moonrise.
  Future<Map<String, dynamic>> sunMoonTimes(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/sun-moon-times', params);

  // ── Muhurta ──────────────────────────────────────────────────────

  /// Auspicious muhurta for a date and location.
  Future<Map<String, dynamic>> muhurta(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/muhurta', params);

  /// Choghadiya (time divisions of the day).
  Future<Map<String, dynamic>> choghadiya(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/choghadiya', params);

  /// Hora (planetary hour).
  Future<Map<String, dynamic>> hora(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/hora', params);

  // ── Matching ─────────────────────────────────────────────────────

  /// Ashtakoota (8-fold) Guna matching.
  Future<Map<String, dynamic>> gunaMatch(MatchingPair pair) =>
      _client.post('/v2/astrology/guna-match', pair.toJson());

  /// Kundli matching with dosha analysis.
  Future<Map<String, dynamic>> kundliMatch(MatchingPair pair) =>
      _client.post('/v2/astrology/kundli-match', pair.toJson());

  // ── Predictions ──────────────────────────────────────────────────

  /// Daily horoscope for a zodiac sign.
  Future<Map<String, dynamic>> horoscope(String sign, {String? date}) =>
      _client.get('/v2/astrology/horoscope/$sign',
          queryParams: date != null ? {'date': date} : null);

  /// List valid zodiac signs (free, no auth).
  Future<Map<String, dynamic>> horoscopeSigns() =>
      _client.get('/v2/astrology/horoscope-signs');

  // ── Transits ─────────────────────────────────────────────────────

  /// Saturn transit (Gochar).
  Future<Map<String, dynamic>> saturnTransit(BirthDetails bd) =>
      _client.post('/v2/astrology/saturn-transit', bd.toJson());

  /// Moon transit.
  Future<Map<String, dynamic>> moonTransit(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/moon-transit', params);

  // ── Strength ─────────────────────────────────────────────────────

  /// Shadbala (six-fold strength).
  Future<Map<String, dynamic>> shadbala(BirthDetails bd) =>
      _client.post('/v2/astrology/shadbala', bd.toJson());

  /// Ashtakavarga point table.
  Future<Map<String, dynamic>> ashtakavarga(BirthDetails bd) =>
      _client.post('/v2/astrology/ashtakavarga', bd.toJson());

  /// Sarvashtakavarga (combined Ashtakavarga).
  Future<Map<String, dynamic>> sarvashtakavarga(BirthDetails bd) =>
      _client.post('/v2/astrology/sarvashtakavarga', bd.toJson());

  // ── Divisional Charts ────────────────────────────────────────────

  /// Navamsa (D9) chart.
  Future<Map<String, dynamic>> navamsa(BirthDetails bd) =>
      _client.post('/v2/astrology/navamsa', bd.toJson());

  /// Dashamsa (D10) chart.
  Future<Map<String, dynamic>> dashamsa(BirthDetails bd) =>
      _client.post('/v2/astrology/dashamsa', bd.toJson());

  /// Saptamsa (D7) chart.
  Future<Map<String, dynamic>> saptamsa(BirthDetails bd) =>
      _client.post('/v2/astrology/saptamsa', bd.toJson());

  // ── Numerology (under /v2/astrology/) ────────────────────────────

  /// Life path number.
  Future<Map<String, dynamic>> lifePath(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/life-path', params);

  /// Destiny number.
  Future<Map<String, dynamic>> destinyNumber(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/destiny-number', params);

  /// Complete numerology profile.
  Future<Map<String, dynamic>> numerologyComplete(
          Map<String, dynamic> params) =>
      _client.post('/v2/astrology/numerology-complete', params);

  // ── Varshaphal ───────────────────────────────────────────────────

  /// Solar return (Varshaphal) chart.
  Future<Map<String, dynamic>> varshaphal(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/varshaphal', params);

  // ── KP System ────────────────────────────────────────────────────

  /// KP birth chart (Placidus cusps, sub-lords, significators).
  Future<Map<String, dynamic>> kpChart(BirthDetails bd) =>
      _client.post('/v2/astrology/kp/birth-chart', bd.toJson());

  /// KP horary chart.
  Future<Map<String, dynamic>> kpHorary(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/kp/horary', params);

  /// KP significators.
  Future<Map<String, dynamic>> kpSignificators(BirthDetails bd) =>
      _client.post('/v2/astrology/kp/significators', bd.toJson());

  /// KP sub-lord table.
  Future<Map<String, dynamic>> kpSubLordTable(BirthDetails bd) =>
      _client.post('/v2/astrology/kp/sublord-table', bd.toJson());

  /// KP prediction.
  Future<Map<String, dynamic>> kpPrediction(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/kp/prediction', params);

  // ── Vastu (80 operations, 17 families) ────────────────────────────
  // 2026-08-10: the previous three methods pointed at /vastu/mandala,
  // /vastu/entrance and /vastu/room-placement — none of which exist in the
  // 76-operation surface, so every call 404'd. These are repointed at the real
  // paths and joined by helpers covering the full family set, plus a generic
  // escape hatch for the long tail. Vastu takes a BUILDING (plot polygon, room
  // list, compass zone), never a birth chart.

  /// Any Vastu operation by its path suffix under `/v2/astrology/vastu/`.
  /// e.g. `vastu('score/overall', {rooms: [...]})`.
  ///
  /// The 11 `reference/*` tables (10 original + `reference/gate-obstructions`)
  /// are GET-only (a POST returns 405) and `direction/declination` is a
  /// GET+POST dual whose verified path is GET-with-query, so both dispatch
  /// GET (params become query string); everything else is POST. Mirrors
  /// vedika-v2/src/vastu.rs.
  Future<Map<String, dynamic>> vastu(String op, Map<String, dynamic> params) {
    final path = op.replaceAll(RegExp(r'^/+'), '');
    if (path.startsWith('reference/') || path == 'direction/declination') {
      return _client.get(
        '/v2/astrology/vastu/$path',
        queryParams: params.map((k, v) => MapEntry(k, '$v')),
      );
    }
    return _client.post('/v2/astrology/vastu/$path', params);
  }

  /// A GET reference table, e.g. `reference/mandala/9-zone`,
  /// `reference/mandala/45-devatas`, `reference/directions/8`,
  /// `reference/defects/catalog`, `reference/remedies/catalog`,
  /// `reference/gate-obstructions`.
  Future<Map<String, dynamic>> vastuReference(String table) =>
      _client.get('/v2/astrology/vastu/${table.replaceAll(RegExp(r'^/+'), '')}');

  /// Project a mandala onto a plot. [scheme] is `9-zone`, `81-pada` or
  /// `brahmasthan`. Body: `{plotPolygon, bearingDeg}`.
  Future<Map<String, dynamic>> vastuMandalaProject(
          String scheme, Map<String, dynamic> params) =>
      _client.post('/v2/astrology/vastu/mandala/project/$scheme', params);

  /// Back-compat alias — now the 9-zone mandala projection (was the dead
  /// `/vastu/mandala`). Body: `{plotPolygon, bearingDeg}`.
  Future<Map<String, dynamic>> vastuMandala(Map<String, dynamic> params) =>
      vastuMandalaProject('9-zone', params);

  /// Door-pada classifier. Body: `{plotPolygon, doorXY, bearingDeg}`.
  Future<Map<String, dynamic>> vastuEntrancePada(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/vastu/entrance/pada', params);

  /// Entrance recommendation. Body: `{plot, ...}`.
  Future<Map<String, dynamic>> vastuEntranceRecommend(
          Map<String, dynamic> params) =>
      _client.post('/v2/astrology/vastu/entrance/recommend', params);

  /// Back-compat alias — now the door-pada classifier (was the dead
  /// `/vastu/entrance`).
  Future<Map<String, dynamic>> vastuEntrance(Map<String, dynamic> params) =>
      vastuEntrancePada(params);

  /// Single-room placement, e.g. `vastuRoom('kitchen', {zone: 'southeast'})`.
  /// [roomType]: kitchen, bedroom, pooja, toilet, staircase, study, living,
  /// dining, store, water-storage.
  Future<Map<String, dynamic>> vastuRoom(
          String roomType, Map<String, dynamic> params) =>
      _client.post('/v2/astrology/vastu/room/$roomType', params);

  /// Back-compat alias — routes to `/room/{roomType}` from the params
  /// (was the dead `/vastu/room-placement`). Provide `roomType` in [params].
  Future<Map<String, dynamic>> vastuRoomPlacement(
      Map<String, dynamic> params) {
    final roomType = (params['roomType'] ?? params['room'] ?? 'kitchen').toString();
    final body = Map<String, dynamic>.from(params)..remove('roomType')..remove('room');
    return vastuRoom(roomType, body);
  }

  /// Site placement, e.g. `vastuPlacement('borewell', {zone: 'north-east'})`.
  Future<Map<String, dynamic>> vastuPlacement(
          String feature, Map<String, dynamic> params) =>
      _client.post('/v2/astrology/vastu/placement/$feature', params);

  /// Compliance audit. [kind]: `single-room`, `floor-plan`,
  /// `floor-plan-detailed`. Body: `{rooms: [...], plot?}`.
  Future<Map<String, dynamic>> vastuAudit(
          String kind, Map<String, dynamic> params) =>
      _client.post('/v2/astrology/vastu/audit/$kind', params);

  /// Vastu score. [kind]: `overall`, `zone-wise`, `compliance-index`.
  Future<Map<String, dynamic>> vastuScore(
          String kind, Map<String, dynamic> params) =>
      _client.post('/v2/astrology/vastu/score/$kind', params);

  /// Generate up to 3 ranked floor plans from a plot + room programme.
  Future<Map<String, dynamic>> vastuPlanGenerate(
          Map<String, dynamic> params) =>
      _client.post('/v2/astrology/vastu/plan/generate', params);

  /// Generate a floor plan from a high-level brief (BHK, bathrooms, parking…).
  Future<Map<String, dynamic>> vastuPlanFromRequirements(
          Map<String, dynamic> params) =>
      _client.post('/v2/astrology/vastu/plan/from-requirements', params);

  /// Magnetic declination (true-north correction) for a location. India grid.
  Future<Map<String, dynamic>> vastuDeclination(
          {required double lat, required double lon, String? date}) =>
      _client.get('/v2/astrology/vastu/direction/declination', queryParams: {
        'lat': lat.toString(),
        'lon': lon.toString(),
        if (date != null) 'date': date,
      });

  // ── Lal Kitab ────────────────────────────────────────────────────

  /// Lal Kitab chart.
  Future<Map<String, dynamic>> lalkitabChart(BirthDetails bd) =>
      _client.post('/v2/astrology/lalkitab/chart', bd.toJson());

  /// Lal Kitab remedies (totke).
  Future<Map<String, dynamic>> lalkitabRemedies(BirthDetails bd) =>
      _client.post('/v2/astrology/lalkitab/remedies', bd.toJson());

  /// Lal Kitab debts (rin).
  Future<Map<String, dynamic>> lalkitabDebts(BirthDetails bd) =>
      _client.post('/v2/astrology/lalkitab/debts', bd.toJson());

  // ── Jaimini ──────────────────────────────────────────────────────

  /// Jaimini Chara Karakas.
  Future<Map<String, dynamic>> jaiminiCharaKarakas(BirthDetails bd) =>
      _client.post('/v2/astrology/jaimini/chara-karakas', bd.toJson());

  /// Jaimini Arudha Padas.
  Future<Map<String, dynamic>> jaiminiArudhaPadas(BirthDetails bd) =>
      _client.post('/v2/astrology/jaimini/arudha-padas', bd.toJson());

  // ── Tajaka ───────────────────────────────────────────────────────

  /// Tajaka yogas.
  Future<Map<String, dynamic>> tajakaYogas(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/tajaka/yogas', params);

  /// Tajaka sahams (Arabic parts).
  Future<Map<String, dynamic>> tajakaSahams(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/tajaka/sahams', params);

  // ── Prashna (Horary) ─────────────────────────────────────────────

  /// Prashna chart at query moment.
  Future<Map<String, dynamic>> prashnaChart(Map<String, dynamic> params) =>
      _client.post('/v2/astrology/prashna/chart', params);

  // ── Festivals ────────────────────────────────────────────────────

  /// Hindu festivals for a date range.
  Future<Map<String, dynamic>> festivals({
    String? startDate,
    String? endDate,
  }) =>
      _client.get('/v2/astrology/festivals', queryParams: {
        if (startDate != null) 'startDate': startDate,
        if (endDate != null) 'endDate': endDate,
      });

  // ── Fixed Stars & Asteroids ──────────────────────────────────────

  /// Fixed stars near chart positions.
  Future<Map<String, dynamic>> fixedStars(BirthDetails bd) =>
      _client.post('/v2/astrology/fixed-stars/natal', bd.toJson());

  /// Asteroid positions (Chiron, Lilith, etc.).
  Future<Map<String, dynamic>> asteroids(BirthDetails bd) =>
      _client.post('/v2/astrology/asteroids/natal', bd.toJson());

  // ── Remedies ─────────────────────────────────────────────────────

  /// Gemstone remedy recommendations.
  Future<Map<String, dynamic>> remedyGemstone(BirthDetails bd) =>
      _client.post('/v2/astrology/remedies/gemstone', bd.toJson());

  /// Mantra remedy recommendations.
  Future<Map<String, dynamic>> remedyMantra(BirthDetails bd) =>
      _client.post('/v2/astrology/remedies/mantra', bd.toJson());

  // ── Advanced ─────────────────────────────────────────────────────

  /// Sudarshana Chakra.
  Future<Map<String, dynamic>> sudarshanChakra(BirthDetails bd) =>
      _client.post('/v2/astrology/sudarshana-chakra', bd.toJson());

  /// Bhava analysis.
  Future<Map<String, dynamic>> bhavaAnalysis(BirthDetails bd) =>
      _client.post('/v2/astrology/bhava/analysis', bd.toJson());

  /// Pricing info (free endpoint).
  Future<Map<String, dynamic>> pricing() =>
      _client.get('/v2/astrology/pricing');
}
