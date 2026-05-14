/// Daily horoscope prediction.
class DailyHoroscope {
  final String sign;
  final String date;
  final String? prediction;
  final String? mood;
  final int? luckyNumber;
  final String? luckyColor;
  final String? compatibility;

  const DailyHoroscope({
    required this.sign,
    required this.date,
    this.prediction,
    this.mood,
    this.luckyNumber,
    this.luckyColor,
    this.compatibility,
  });

  factory DailyHoroscope.fromJson(Map<String, dynamic> json) =>
      DailyHoroscope(
        sign: json['sign'] as String? ?? '',
        date: json['date'] as String? ?? '',
        prediction: json['prediction'] as String?,
        mood: json['mood'] as String?,
        luckyNumber: json['luckyNumber'] as int? ??
            json['lucky_number'] as int?,
        luckyColor: json['luckyColor'] as String? ??
            json['lucky_color'] as String?,
        compatibility: json['compatibility'] as String?,
      );
}
