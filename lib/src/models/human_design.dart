/// Human Design type result.
class HumanDesignType {
  final String type;
  final String strategy;
  final String signature;
  final String notSelfTheme;

  const HumanDesignType({
    required this.type,
    required this.strategy,
    this.signature = '',
    this.notSelfTheme = '',
  });

  factory HumanDesignType.fromJson(Map<String, dynamic> json) =>
      HumanDesignType(
        type: json['type'] as String? ?? '',
        strategy: json['strategy'] as String? ?? '',
        signature: json['signature'] as String? ?? '',
        notSelfTheme: json['notSelfTheme'] as String? ??
            json['not_self_theme'] as String? ??
            '',
      );
}

/// A Human Design center (defined/undefined).
class HumanDesignCenter {
  final String name;
  final bool isDefined;
  final String? theme;

  const HumanDesignCenter({
    required this.name,
    required this.isDefined,
    this.theme,
  });

  factory HumanDesignCenter.fromJson(Map<String, dynamic> json) =>
      HumanDesignCenter(
        name: json['name'] as String? ?? '',
        isDefined: json['isDefined'] as bool? ??
            json['is_defined'] as bool? ??
            json['defined'] as bool? ??
            false,
        theme: json['theme'] as String?,
      );
}
