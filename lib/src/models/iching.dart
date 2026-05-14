/// An I Ching hexagram.
class Hexagram {
  final int number;
  final String name;
  final String chineseName;
  final String meaning;
  final String image;
  final String judgment;
  final List<String>? lines;
  final List<int>? changingLines;

  const Hexagram({
    required this.number,
    required this.name,
    this.chineseName = '',
    this.meaning = '',
    this.image = '',
    this.judgment = '',
    this.lines,
    this.changingLines,
  });

  factory Hexagram.fromJson(Map<String, dynamic> json) => Hexagram(
        number: json['number'] as int? ?? 0,
        name: json['name'] as String? ?? '',
        chineseName: json['chineseName'] as String? ??
            json['chinese_name'] as String? ??
            '',
        meaning: json['meaning'] as String? ?? '',
        image: json['image'] as String? ?? '',
        judgment: json['judgment'] as String? ?? '',
        lines:
            (json['lines'] as List?)?.map((e) => e.toString()).toList(),
        changingLines: (json['changingLines'] as List?)
            ?.map((e) => e as int)
            .toList(),
      );
}
