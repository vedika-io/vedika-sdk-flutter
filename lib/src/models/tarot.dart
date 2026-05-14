/// A single tarot card.
class TarotCard {
  final String name;
  final int number;
  final String suit;
  final String uprightMeaning;
  final String reversedMeaning;
  final String? description;
  final String? element;
  final String? keywords;
  final bool? isReversed;

  const TarotCard({
    required this.name,
    required this.number,
    this.suit = '',
    this.uprightMeaning = '',
    this.reversedMeaning = '',
    this.description,
    this.element,
    this.keywords,
    this.isReversed,
  });

  factory TarotCard.fromJson(Map<String, dynamic> json) => TarotCard(
        name: json['name'] as String? ?? '',
        number: json['number'] as int? ?? 0,
        suit: json['suit'] as String? ?? '',
        uprightMeaning: json['uprightMeaning'] as String? ??
            json['upright_meaning'] as String? ??
            json['upright'] as String? ??
            '',
        reversedMeaning: json['reversedMeaning'] as String? ??
            json['reversed_meaning'] as String? ??
            json['reversed'] as String? ??
            '',
        description: json['description'] as String?,
        element: json['element'] as String?,
        keywords: json['keywords'] as String?,
        isReversed: json['isReversed'] as bool?,
      );
}

/// A tarot reading result containing drawn cards and interpretation.
class TarotReading {
  final String spreadType;
  final List<TarotCard> cards;
  final String? interpretation;
  final String? question;

  const TarotReading({
    required this.spreadType,
    required this.cards,
    this.interpretation,
    this.question,
  });

  factory TarotReading.fromJson(Map<String, dynamic> json) => TarotReading(
        spreadType: json['spreadType'] as String? ??
            json['spread_type'] as String? ??
            '',
        cards: (json['cards'] as List?)
                ?.map((e) => TarotCard.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        interpretation: json['interpretation'] as String?,
        question: json['question'] as String?,
      );
}
