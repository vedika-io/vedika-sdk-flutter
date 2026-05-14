/// Matrimony compatibility result.
class CompatibilityResult {
  final double totalScore;
  final double maxScore;
  final double percentage;
  final String? verdict;
  final List<MatchingFactor>? factors;

  const CompatibilityResult({
    required this.totalScore,
    required this.maxScore,
    required this.percentage,
    this.verdict,
    this.factors,
  });

  factory CompatibilityResult.fromJson(Map<String, dynamic> json) =>
      CompatibilityResult(
        totalScore: (json['totalScore'] as num? ??
                json['total_score'] as num? ??
                0)
            .toDouble(),
        maxScore: (json['maxScore'] as num? ??
                json['max_score'] as num? ??
                36)
            .toDouble(),
        percentage:
            (json['percentage'] as num? ?? 0).toDouble(),
        verdict: json['verdict'] as String?,
        factors: (json['factors'] as List?)
            ?.map(
                (e) => MatchingFactor.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

/// A single matching factor (e.g., Varna, Vashya, Tara).
class MatchingFactor {
  final String name;
  final double score;
  final double maxScore;
  final String? description;

  const MatchingFactor({
    required this.name,
    required this.score,
    required this.maxScore,
    this.description,
  });

  factory MatchingFactor.fromJson(Map<String, dynamic> json) =>
      MatchingFactor(
        name: json['name'] as String? ?? '',
        score: (json['score'] as num? ?? 0).toDouble(),
        maxScore:
            (json['maxScore'] as num? ?? json['max_score'] as num? ?? 0)
                .toDouble(),
        description: json['description'] as String?,
      );
}
