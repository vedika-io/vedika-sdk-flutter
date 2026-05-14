/// Base exception for all Vedika API errors.
class VedikaApiError implements Exception {
  /// Human-readable error message.
  final String message;

  /// HTTP status code, if available.
  final int? statusCode;

  /// Raw response body, if available.
  final Map<String, dynamic>? body;

  const VedikaApiError(this.message, {this.statusCode, this.body});

  @override
  String toString() => 'VedikaApiError($statusCode): $message';
}

/// Thrown when the API key is invalid or missing (HTTP 401).
class VedikaAuthError extends VedikaApiError {
  const VedikaAuthError(super.message, {super.statusCode = 401, super.body});
}

/// Thrown when the wallet balance is insufficient (HTTP 402).
class VedikaInsufficientCredits extends VedikaApiError {
  const VedikaInsufficientCredits(super.message,
      {super.statusCode = 402, super.body});
}

/// Thrown when the rate limit is exceeded (HTTP 429).
class VedikaRateLimitError extends VedikaApiError {
  /// Seconds until the rate limit resets.
  final int? retryAfterSeconds;

  const VedikaRateLimitError(super.message,
      {super.statusCode = 429, super.body, this.retryAfterSeconds});
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
