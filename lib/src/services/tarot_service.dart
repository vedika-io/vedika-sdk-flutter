import '../client.dart';

/// Tarot card endpoints under `/v2/tarot/`.
///
/// 25 endpoints: 8 GET (card lookups) + 17 POST (readings & draws).
class TarotService {
  final VedikaClient _client;
  TarotService(this._client);

  // ── GET: Card Database ───────────────────────────────────────────

  /// Daily card of the day.
  Future<Map<String, dynamic>> cardOfTheDay() =>
      _client.get('/v2/tarot/card-of-the-day');

  /// All 22 Major Arcana cards.
  Future<Map<String, dynamic>> majorArcana() =>
      _client.get('/v2/tarot/cards/major-arcana');

  /// All 56 Minor Arcana cards.
  Future<Map<String, dynamic>> minorArcana() =>
      _client.get('/v2/tarot/cards/minor-arcana');

  /// Cards by suit (wands, cups, swords, pentacles).
  Future<Map<String, dynamic>> cardsBySuit(String suit) =>
      _client.get('/v2/tarot/cards/suit/$suit');

  /// Single card lookup by name.
  Future<Map<String, dynamic>> card(String name) =>
      _client.get('/v2/tarot/card/${Uri.encodeComponent(name)}');

  /// List all available spread types.
  Future<Map<String, dynamic>> spreads() =>
      _client.get('/v2/tarot/spreads');

  /// Zodiac-tarot associations for a sign.
  Future<Map<String, dynamic>> zodiacCards(String sign) =>
      _client.get('/v2/tarot/zodiac/$sign');

  /// Cards by element (fire, water, air, earth).
  Future<Map<String, dynamic>> elementCards(String element) =>
      _client.get('/v2/tarot/element/$element');

  // ── POST: Readings & Draws ───────────────────────────────────────

  /// Single card draw.
  Future<Map<String, dynamic>> drawSingle({String? question, int? seed}) =>
      _client.post('/v2/tarot/draw/single', {
        if (question != null) 'question': question,
        if (seed != null) 'seed': seed,
      });

  /// Three-card spread (Past/Present/Future).
  Future<Map<String, dynamic>> drawThreeCard(
          {String? question, int? seed}) =>
      _client.post('/v2/tarot/draw/three-card', {
        if (question != null) 'question': question,
        if (seed != null) 'seed': seed,
      });

  /// Celtic Cross (10 cards).
  Future<Map<String, dynamic>> drawCelticCross(
          {String? question, int? seed}) =>
      _client.post('/v2/tarot/draw/celtic-cross', {
        if (question != null) 'question': question,
        if (seed != null) 'seed': seed,
      });

  /// Yes/No binary answer.
  Future<Map<String, dynamic>> drawYesNo(
          {required String question, int? seed}) =>
      _client.post('/v2/tarot/draw/yes-no', {
        'question': question,
        if (seed != null) 'seed': seed,
      });

  /// Love/relationship spread (6 cards).
  Future<Map<String, dynamic>> drawLove({String? question, int? seed}) =>
      _client.post('/v2/tarot/draw/love', {
        if (question != null) 'question': question,
        if (seed != null) 'seed': seed,
      });

  /// Career guidance spread.
  Future<Map<String, dynamic>> drawCareer(
          {String? question, int? seed}) =>
      _client.post('/v2/tarot/draw/career', {
        if (question != null) 'question': question,
        if (seed != null) 'seed': seed,
      });

  /// Horseshoe spread (7 cards).
  Future<Map<String, dynamic>> drawHorseshoe(
          {String? question, int? seed}) =>
      _client.post('/v2/tarot/draw/horseshoe', {
        if (question != null) 'question': question,
        if (seed != null) 'seed': seed,
      });

  /// Relationship spread (two people).
  Future<Map<String, dynamic>> drawRelationship(
          {String? question, int? seed}) =>
      _client.post('/v2/tarot/draw/relationship', {
        if (question != null) 'question': question,
        if (seed != null) 'seed': seed,
      });

  /// Monthly forecast (12 cards).
  Future<Map<String, dynamic>> drawMonthly(
          {String? question, int? seed}) =>
      _client.post('/v2/tarot/draw/monthly', {
        if (question != null) 'question': question,
        if (seed != null) 'seed': seed,
      });

  /// Weekly forecast (7 cards).
  Future<Map<String, dynamic>> drawWeekly(
          {String? question, int? seed}) =>
      _client.post('/v2/tarot/draw/weekly', {
        if (question != null) 'question': question,
        if (seed != null) 'seed': seed,
      });

  /// Spiritual guidance spread.
  Future<Map<String, dynamic>> drawSpiritual(
          {String? question, int? seed}) =>
      _client.post('/v2/tarot/draw/spiritual', {
        if (question != null) 'question': question,
        if (seed != null) 'seed': seed,
      });

  /// Decision-making spread.
  Future<Map<String, dynamic>> drawDecision(
          {String? question, int? seed}) =>
      _client.post('/v2/tarot/draw/decision', {
        if (question != null) 'question': question,
        if (seed != null) 'seed': seed,
      });

  /// Past life reading.
  Future<Map<String, dynamic>> drawPastLife(
          {String? question, int? seed}) =>
      _client.post('/v2/tarot/draw/past-life', {
        if (question != null) 'question': question,
        if (seed != null) 'seed': seed,
      });

  /// Chakra alignment (7 cards).
  Future<Map<String, dynamic>> drawChakra(
          {String? question, int? seed}) =>
      _client.post('/v2/tarot/draw/chakra', {
        if (question != null) 'question': question,
        if (seed != null) 'seed': seed,
      });

  /// Custom draw with user-defined card count.
  Future<Map<String, dynamic>> drawCustom(
          {String? question, int? cardCount, int? seed}) =>
      _client.post('/v2/tarot/draw/custom', {
        if (question != null) 'question': question,
        if (cardCount != null) 'cardCount': cardCount,
        if (seed != null) 'seed': seed,
      });

  /// Tarot compatibility between two people.
  Future<Map<String, dynamic>> compatibility(
          {String? personA, String? personB, int? seed}) =>
      _client.post('/v2/tarot/compatibility', {
        if (personA != null) 'personA': personA,
        if (personB != null) 'personB': personB,
        if (seed != null) 'seed': seed,
      });

  /// AI interpretation with free-form question.
  Future<Map<String, dynamic>> aiInterpretation(
          {required String question, int? cardCount, int? seed}) =>
      _client.post('/v2/tarot/ai-interpretation', {
        'question': question,
        if (cardCount != null) 'cardCount': cardCount,
        if (seed != null) 'seed': seed,
      });

  /// Astro-fusion: birth chart + tarot combined reading.
  Future<Map<String, dynamic>> astroFusion(
          {String? dateOfBirth, String? question, int? seed}) =>
      _client.post('/v2/tarot/astro-fusion', {
        if (dateOfBirth != null) 'dateOfBirth': dateOfBirth,
        if (question != null) 'question': question,
        if (seed != null) 'seed': seed,
      });
}
