/// Base exception for all Vedika API errors.
class VedikaApiError implements Exception {
  /// Human-readable error message.
  final String message;

  /// HTTP status code, if available.
  final int? statusCode;

  /// Raw response body, if available.
  final Map<String, dynamic>? body;

  const VedikaApiError(this.message, {this.statusCode, this.body});

  /// Machine-readable error `code` from the response body (for example
  /// `INSUFFICIENT_BALANCE`, `DAILY_LIMIT_EXCEEDED`), if the API sent one.
  String? get code {
    final value = body?['code'];
    return value is String ? value : null;
  }

  @override
  String toString() => 'VedikaApiError($statusCode): $message';
}

/// Thrown when the API key is invalid or missing (HTTP 401).
class VedikaAuthError extends VedikaApiError {
  const VedikaAuthError(super.message, {super.statusCode = 401, super.body});
}

/// Thrown when the wallet balance is insufficient (HTTP 402).
///
/// A 402 is never retried: the call was refused before any charge. Top up the
/// wallet (see [purchaseUrl]) and call again.
class VedikaInsufficientCredits extends VedikaApiError {
  const VedikaInsufficientCredits(super.message,
      {super.statusCode = 402, super.body});

  Object? _wallet(String key) {
    final wallet = body?['wallet'];
    if (wallet is Map && wallet[key] != null) return wallet[key];
    return body?[key];
  }

  static double? _asDouble(Object? value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  /// Amount this call needed, in USD (`wallet.required`).
  double? get required => _asDouble(_wallet('required'));

  /// Wallet balance at the time of the call, in USD (`wallet.available`).
  double? get available => _asDouble(_wallet('available'));

  /// How much more is needed, in USD (`wallet.deficit`).
  double? get deficit => _asDouble(_wallet('deficit'));

  /// Where to add funds (`purchaseUrl`), if the API sent one.
  String? get purchaseUrl {
    final value = body?['purchaseUrl'];
    return value is String ? value : null;
  }
}

/// Thrown when a request is refused with HTTP 429.
///
/// A 429 has several causes, so read [code], not the rate-limit headers (they
/// describe the per-minute limiter, which may not be the one that refused you).
class VedikaRateLimitError extends VedikaApiError {
  /// Seconds to wait, from the body's `retryAfter` (falling back to the
  /// `Retry-After` header). Only meaningful when [isRetryable] is true.
  final int? retryAfterSeconds;

  const VedikaRateLimitError(super.message,
      {super.statusCode = 429, super.body, this.retryAfterSeconds});

  /// True for `DAILY_LIMIT_EXCEEDED`: the daily call allowance is spent and
  /// retrying will keep failing until it resets or the plan is upgraded.
  bool get isDailyLimit => code == 'DAILY_LIMIT_EXCEEDED';

  /// True when waiting [retryAfterSeconds] and calling again can succeed.
  /// False for the daily and plan limits, which a retry cannot clear.
  bool get isRetryable => code != 'DAILY_LIMIT_EXCEEDED' &&
      code != 'PLAN_LIMIT_EXCEEDED';

  /// Where to upgrade the plan (`upgradeUrl`), if the API sent one.
  String? get upgradeUrl {
    final value = body?['upgradeUrl'];
    return value is String ? value : null;
  }
}

/// Thrown on server errors (HTTP 5xx).
class VedikaServerError extends VedikaApiError {
  const VedikaServerError(super.message, {super.statusCode, super.body});
}

/// Thrown when the subscription is inactive (HTTP 403).
class VedikaSubscriptionError extends VedikaApiError {
  const VedikaSubscriptionError(super.message,
      {super.statusCode = 403, super.body});
}

/// Thrown when a call carried an `Idempotency-Key` that the endpoint does not
/// accept (HTTP 422, `IDEMPOTENCY_NOT_SUPPORTED`). No charge was attempted.
/// Call again without `idempotencyKey`.
class VedikaIdempotencyNotSupportedError extends VedikaApiError {
  const VedikaIdempotencyNotSupportedError(super.message,
      {super.statusCode = 422, super.body});
}
