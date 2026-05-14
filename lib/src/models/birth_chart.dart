/// A planet position in a birth chart.
class PlanetPosition {
  final String name;
  final double longitude;
  final String sign;
  final int house;
  final String? nakshatra;
  final int? pada;
  final bool? isRetrograde;

  const PlanetPosition({
    required this.name,
    required this.longitude,
    required this.sign,
    required this.house,
    this.nakshatra,
    this.pada,
    this.isRetrograde,
  });

  factory PlanetPosition.fromJson(Map<String, dynamic> json) =>
      PlanetPosition(
        name: json['name'] as String? ?? '',
        longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
        sign: json['sign'] as String? ?? '',
        house: json['house'] as int? ?? 0,
        nakshatra: json['nakshatra'] as String?,
        pada: json['pada'] as int?,
        isRetrograde: json['isRetrograde'] as bool? ??
            json['is_retrograde'] as bool?,
      );
}

/// An aspect between two planets.
class Aspect {
  final String planet1;
  final String planet2;
  final String type;
  final double orb;
  final bool? isApplying;

  const Aspect({
    required this.planet1,
    required this.planet2,
    required this.type,
    required this.orb,
    this.isApplying,
  });

  factory Aspect.fromJson(Map<String, dynamic> json) => Aspect(
        planet1: json['planet1'] as String? ?? '',
        planet2: json['planet2'] as String? ?? '',
        type: json['type'] as String? ?? json['aspect'] as String? ?? '',
        orb: (json['orb'] as num?)?.toDouble() ?? 0.0,
        isApplying: json['isApplying'] as bool?,
      );
}

/// A house cusp in a birth chart.
class HouseCusp {
  final int house;
  final double longitude;
  final String sign;

  const HouseCusp({
    required this.house,
    required this.longitude,
    required this.sign,
  });

  factory HouseCusp.fromJson(Map<String, dynamic> json) => HouseCusp(
        house: json['house'] as int? ?? 0,
        longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
        sign: json['sign'] as String? ?? '',
      );
}
