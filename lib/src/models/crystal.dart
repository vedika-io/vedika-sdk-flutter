/// A crystal/gemstone.
class Crystal {
  final String name;
  final String? zodiacSign;
  final String? planet;
  final String? chakra;
  final String? element;
  final String? color;
  final List<String>? healingProperties;
  final String? cleansing;
  final String? meditation;

  const Crystal({
    required this.name,
    this.zodiacSign,
    this.planet,
    this.chakra,
    this.element,
    this.color,
    this.healingProperties,
    this.cleansing,
    this.meditation,
  });

  factory Crystal.fromJson(Map<String, dynamic> json) => Crystal(
        name: json['name'] as String? ?? '',
        zodiacSign: json['zodiacSign'] as String? ??
            json['zodiac_sign'] as String?,
        planet: json['planet'] as String?,
        chakra: json['chakra'] as String?,
        element: json['element'] as String?,
        color: json['color'] as String?,
        healingProperties: (json['healingProperties'] as List? ??
                json['healing_properties'] as List?)
            ?.map((e) => e.toString())
            .toList(),
        cleansing: json['cleansing'] as String?,
        meditation: json['meditation'] as String?,
      );
}
