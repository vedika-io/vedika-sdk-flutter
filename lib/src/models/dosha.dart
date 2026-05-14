/// Dosha analysis result.
class DoshaResult {
  final String doshaName;
  final bool isPresent;
  final double? severity;
  final String? description;
  final List<String>? remedies;
  final bool? isCancelled;
  final String? cancellationReason;

  const DoshaResult({
    required this.doshaName,
    required this.isPresent,
    this.severity,
    this.description,
    this.remedies,
    this.isCancelled,
    this.cancellationReason,
  });

  factory DoshaResult.fromJson(Map<String, dynamic> json) => DoshaResult(
        doshaName: json['doshaName'] as String? ??
            json['dosha_name'] as String? ??
            json['name'] as String? ??
            '',
        isPresent: json['isPresent'] as bool? ??
            json['is_present'] as bool? ??
            json['present'] as bool? ??
            false,
        severity: (json['severity'] as num?)?.toDouble(),
        description: json['description'] as String?,
        remedies: (json['remedies'] as List?)
            ?.map((e) => e.toString())
            .toList(),
        isCancelled: json['isCancelled'] as bool? ??
            json['is_cancelled'] as bool?,
        cancellationReason: json['cancellationReason'] as String? ??
            json['cancellation_reason'] as String?,
      );
}
