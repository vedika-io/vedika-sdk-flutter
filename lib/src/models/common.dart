/// Standard API response wrapper.
class VedikaResponse<T> {
  final bool success;
  final T? data;
  final BillingInfo? billing;
  final MetaInfo? meta;
  final String? error;

  const VedikaResponse({
    required this.success,
    this.data,
    this.billing,
    this.meta,
    this.error,
  });

  factory VedikaResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromData,
  ) {
    return VedikaResponse(
      success: json['success'] as bool? ?? false,
      data: json['data'] != null ? fromData(json['data']) : null,
      billing: json['billing'] != null
          ? BillingInfo.fromJson(json['billing'] as Map<String, dynamic>)
          : null,
      meta: json['meta'] != null
          ? MetaInfo.fromJson(json['meta'] as Map<String, dynamic>)
          : null,
      error: json['error'] as String?,
    );
  }
}

/// Billing info returned with every paid API call.
class BillingInfo {
  final double charged;
  final String currency;
  final bool? refunded;

  const BillingInfo({
    required this.charged,
    this.currency = 'USD',
    this.refunded,
  });

  factory BillingInfo.fromJson(Map<String, dynamic> json) => BillingInfo(
        charged: (json['charged'] as num?)?.toDouble() ?? 0.0,
        currency: json['currency'] as String? ?? 'USD',
        refunded: json['refunded'] as bool?,
      );
}

/// Metadata returned with every response.
class MetaInfo {
  final String engine;
  final String version;

  const MetaInfo({required this.engine, required this.version});

  factory MetaInfo.fromJson(Map<String, dynamic> json) => MetaInfo(
        engine: json['engine'] as String? ?? '',
        version: json['version'] as String? ?? '',
      );
}

/// Birth details used across many endpoints.
class BirthDetails {
  final String datetime;
  final double latitude;
  final double longitude;
  final String timezone;

  const BirthDetails({
    required this.datetime,
    required this.latitude,
    required this.longitude,
    this.timezone = 'Asia/Kolkata',
  });

  Map<String, dynamic> toJson() => {
        'datetime': datetime,
        'latitude': latitude,
        'longitude': longitude,
        'timezone': timezone,
      };
}

/// A pair of birth details for matching/compatibility endpoints.
class MatchingPair {
  final BirthDetails male;
  final BirthDetails female;

  const MatchingPair({required this.male, required this.female});

  Map<String, dynamic> toJson() => {
        'male': male.toJson(),
        'female': female.toJson(),
      };
}
