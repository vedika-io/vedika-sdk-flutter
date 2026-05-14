/// Chinese zodiac animal result.
class ChineseZodiac {
  final String animal;
  final String element;
  final String yinYang;
  final int year;
  final String? characteristics;
  final List<String>? compatible;
  final List<String>? incompatible;

  const ChineseZodiac({
    required this.animal,
    required this.element,
    this.yinYang = '',
    required this.year,
    this.characteristics,
    this.compatible,
    this.incompatible,
  });

  factory ChineseZodiac.fromJson(Map<String, dynamic> json) => ChineseZodiac(
        animal: json['animal'] as String? ?? '',
        element: json['element'] as String? ?? '',
        yinYang: json['yinYang'] as String? ??
            json['yin_yang'] as String? ??
            '',
        year: json['year'] as int? ?? 0,
        characteristics: json['characteristics'] as String?,
        compatible: (json['compatible'] as List?)
            ?.map((e) => e.toString())
            .toList(),
        incompatible: (json['incompatible'] as List?)
            ?.map((e) => e.toString())
            .toList(),
      );
}

/// Ba Zi (Four Pillars) chart.
class BaZiChart {
  final Map<String, dynamic> yearPillar;
  final Map<String, dynamic> monthPillar;
  final Map<String, dynamic> dayPillar;
  final Map<String, dynamic> hourPillar;
  final String? dayMaster;

  const BaZiChart({
    required this.yearPillar,
    required this.monthPillar,
    required this.dayPillar,
    required this.hourPillar,
    this.dayMaster,
  });

  factory BaZiChart.fromJson(Map<String, dynamic> json) => BaZiChart(
        yearPillar: (json['yearPillar'] ?? json['year_pillar'] ?? {})
            as Map<String, dynamic>,
        monthPillar: (json['monthPillar'] ?? json['month_pillar'] ?? {})
            as Map<String, dynamic>,
        dayPillar: (json['dayPillar'] ?? json['day_pillar'] ?? {})
            as Map<String, dynamic>,
        hourPillar: (json['hourPillar'] ?? json['hour_pillar'] ?? {})
            as Map<String, dynamic>,
        dayMaster: json['dayMaster'] as String? ??
            json['day_master'] as String?,
      );
}
