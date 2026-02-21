// =============================================================================
// ProductFailure - Freezed union type for typed error handling
// =============================================================================
// Demonstrates: Union types with freezed, typed failures instead of exceptions
// Used with dartz Either<ProductFailure, T> for functional error handling
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_failure.freezed.dart';

// ---------------------------------------------------------------------------
// ProductFailure union
// ---------------------------------------------------------------------------

/// Typed failure union for product-related operations.
///
/// Using freezed unions instead of raw exceptions gives us:
/// - Exhaustive pattern matching with `when`/`map`
/// - Type-safe error handling
/// - Better testability
@freezed
sealed class ProductFailure with _$ProductFailure {
  /// Network-related failure (timeout, no connection, etc.).
  const factory ProductFailure.networkError(String message) = _NetworkError;

  /// Server returned an error response.
  const factory ProductFailure.serverError(int statusCode, String message) =
      _ServerError;

  /// Data parsing or format error.
  const factory ProductFailure.parseError(String message) = _ParseError;

  /// Product not found.
  const factory ProductFailure.notFound(String productId) = _NotFound;

  /// Unexpected/unknown failure.
  const factory ProductFailure.unexpected(String message) = _Unexpected;
}

// Alternative: You could use sealed classes directly (Dart 3 feature):
// sealed class ProductFailure {
//   const ProductFailure();
// }
// class NetworkError extends ProductFailure { ... }
// class ServerError extends ProductFailure { ... }
