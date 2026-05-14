/// Mantra recommendation.
class MantraRecommendation {
  final String mantra;
  final String? deity;
  final String? purpose;
  final int? count;
  final String? bestTime;

  const MantraRecommendation({
    required this.mantra,
    this.deity,
    this.purpose,
    this.count,
    this.bestTime,
  });

  factory MantraRecommendation.fromJson(Map<String, dynamic> json) =>
      MantraRecommendation(
        mantra: json['mantra'] as String? ?? '',
        deity: json['deity'] as String?,
        purpose: json['purpose'] as String?,
        count: json['count'] as int?,
        bestTime: json['bestTime'] as String? ??
            json['best_time'] as String?,
      );
}
