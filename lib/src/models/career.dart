/// Career suitability result.
class CareerSuitability {
  final List<String> suitableCareers;
  final String? dominantPlanet;
  final String? tenthHouseLord;
  final Map<String, dynamic>? details;

  const CareerSuitability({
    required this.suitableCareers,
    this.dominantPlanet,
    this.tenthHouseLord,
    this.details,
  });

  factory CareerSuitability.fromJson(Map<String, dynamic> json) =>
      CareerSuitability(
        suitableCareers: (json['suitableCareers'] as List? ??
                json['suitable_careers'] as List? ??
                json['careers'] as List? ??
                [])
            .map((e) => e.toString())
            .toList(),
        dominantPlanet: json['dominantPlanet'] as String? ??
            json['dominant_planet'] as String?,
        tenthHouseLord: json['tenthHouseLord'] as String? ??
            json['tenth_house_lord'] as String?,
        details: json['details'] as Map<String, dynamic>?,
      );
}
