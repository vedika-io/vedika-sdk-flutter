/// Health vulnerability from astrological analysis.
class HealthVulnerability {
  final String area;
  final String? planet;
  final String? house;
  final double? risk;
  final String? description;

  const HealthVulnerability({
    required this.area,
    this.planet,
    this.house,
    this.risk,
    this.description,
  });

  factory HealthVulnerability.fromJson(Map<String, dynamic> json) =>
      HealthVulnerability(
        area: json['area'] as String? ?? '',
        planet: json['planet'] as String?,
        house: json['house']?.toString(),
        risk: (json['risk'] as num?)?.toDouble(),
        description: json['description'] as String?,
      );
}

/// Ayurvedic body type result.
class AyurvedicType {
  final String primaryDosha;
  final String? secondaryDosha;
  final Map<String, dynamic>? doshaBalance;
  final List<String>? recommendations;

  const AyurvedicType({
    required this.primaryDosha,
    this.secondaryDosha,
    this.doshaBalance,
    this.recommendations,
  });

  factory AyurvedicType.fromJson(Map<String, dynamic> json) =>
      AyurvedicType(
        primaryDosha: json['primaryDosha'] as String? ??
            json['primary_dosha'] as String? ??
            '',
        secondaryDosha: json['secondaryDosha'] as String? ??
            json['secondary_dosha'] as String?,
        doshaBalance: json['doshaBalance'] as Map<String, dynamic>? ??
            json['dosha_balance'] as Map<String, dynamic>?,
        recommendations: (json['recommendations'] as List?)
            ?.map((e) => e.toString())
            .toList(),
      );
}
