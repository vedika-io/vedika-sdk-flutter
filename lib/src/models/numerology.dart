/// Numerology profile result.
class NumerologyProfile {
  final int? lifePath;
  final int? destiny;
  final int? personality;
  final int? soulUrge;
  final int? maturity;
  final String? name;
  final String? dateOfBirth;
  final Map<String, dynamic>? details;

  const NumerologyProfile({
    this.lifePath,
    this.destiny,
    this.personality,
    this.soulUrge,
    this.maturity,
    this.name,
    this.dateOfBirth,
    this.details,
  });

  factory NumerologyProfile.fromJson(Map<String, dynamic> json) =>
      NumerologyProfile(
        lifePath: json['lifePath'] as int? ?? json['life_path'] as int?,
        destiny: json['destiny'] as int?,
        personality: json['personality'] as int?,
        soulUrge: json['soulUrge'] as int? ?? json['soul_urge'] as int?,
        maturity: json['maturity'] as int?,
        name: json['name'] as String?,
        dateOfBirth: json['dateOfBirth'] as String? ??
            json['date_of_birth'] as String?,
        details: json['details'] as Map<String, dynamic>?,
      );
}
