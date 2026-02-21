// =============================================================================
// Failure Types (Freezed Union)
// =============================================================================
// Defines all failure cases the app can encounter. Using @freezed gives us
// exhaustive pattern matching so we never forget to handle an error case.
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

// ---------------------------------------------------------------------------
// Failure union type
// ---------------------------------------------------------------------------

/// Represents all possible failure states in the application.
///
/// Each variant carries a [message] describing what went wrong.
/// The presentation layer pattern-matches on these to show appropriate UI.
///
/// Example usage:
/// ```dart
/// failure.when(
///   server: (msg) => showSnackBar('Server: $msg'),
///   network: (msg) => showSnackBar('Network: $msg'),
///   unauthorized: (msg) => navigateToLogin(),
///   unknown: (msg) => showSnackBar(msg),
/// );
/// ```
@freezed
class Failure with _$Failure {
  /// Server returned an error response (4xx, 5xx).
  const factory Failure.server({
    @Default('Server error occurred') String message,
  }) = ServerFailure;

  /// No internet connection or DNS resolution failed.
  const factory Failure.network({
    @Default('Network error. Please check your connection.') String message,
  }) = NetworkFailure;

  /// Token expired or invalid - user needs to re-authenticate.
  const factory Failure.unauthorized({
    @Default('Session expired. Please login again.') String message,
  }) = UnauthorizedFailure;

  /// Catch-all for unexpected errors (parsing, null, etc.).
  const factory Failure.unknown({
    @Default('An unexpected error occurred') String message,
  }) = UnknownFailure;

  // Alternative: you could add more specific failures:
  // const factory Failure.cache({String message}) = CacheFailure;
  // const factory Failure.validation({String message, Map<String, String>? fields}) = ValidationFailure;
}
