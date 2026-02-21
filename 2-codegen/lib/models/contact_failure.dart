// =============================================================================
// Contact Failure — Freezed Union Types
// =============================================================================
// Concepts demonstrated:
// - Freezed union types (sealed classes) for exhaustive error handling
// - Multiple factory constructors → multiple subtypes
// - when() / map() for pattern matching on union variants
// - How to use union types with dartz Either<Failure, Success>
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_failure.freezed.dart';

// =============================================================================
// Union Types with Freezed
// =============================================================================
// A "union type" is a type that can be one of several variants. In Dart,
// this is similar to sealed classes. Freezed generates the variants as
// separate classes that all implement the base type.
//
// Why union types for errors?
// - Exhaustive: the compiler forces you to handle every variant
// - Type-safe: each variant can carry different data
// - No exceptions: errors are values, not thrown objects
// - Composable: works perfectly with dartz Either

/// Represents all the ways a contact operation can fail.
///
/// Usage with dartz:
/// ```dart
/// Either<ContactFailure, Contact> result = repository.getContact(id);
/// result.fold(
///   (failure) => failure.when(
///     notFound: (id) => 'Contact $id not found',
///     validationError: (field, message) => 'Invalid $field: $message',
///     storageError: (message) => 'Storage error: $message',
///     unexpected: (error) => 'Unexpected: $error',
///   ),
///   (contact) => 'Found: ${contact.name}',
/// );
/// ```
@freezed
sealed class ContactFailure with _$ContactFailure {
  /// The requested contact ID was not found.
  const factory ContactFailure.notFound({required String id}) = _NotFound;

  /// A field failed validation (e.g., empty name, invalid email).
  const factory ContactFailure.validationError({
    required String field,
    required String message,
  }) = _ValidationError;

  /// Something went wrong with local storage.
  const factory ContactFailure.storageError({required String message}) =
      _StorageError;

  /// A catch-all for unexpected errors (e.g., serialization failures).
  const factory ContactFailure.unexpected({required Object error}) =
      _Unexpected;
}

// =============================================================================
// Pattern Matching with when() and map()
// =============================================================================
//
// Freezed generates two pattern-matching methods:
//
// 1. when() — provides the FIELDS of each variant:
//    failure.when(
//      notFound: (id) => ...,
//      validationError: (field, message) => ...,
//      storageError: (message) => ...,
//      unexpected: (error) => ...,
//    );
//
// 2. map() — provides the VARIANT OBJECT itself:
//    failure.map(
//      notFound: (notFound) => notFound.id,
//      validationError: (valError) => valError.field,
//      storageError: (storError) => storError.message,
//      unexpected: (unexpected) => unexpected.error,
//    );
//
// 3. maybeWhen() / maybeMap() — same as above but with an `orElse` fallback:
//    failure.maybeWhen(
//      notFound: (id) => 'Not found: $id',
//      orElse: () => 'Something went wrong',
//    );
//
// All of these are EXHAUSTIVE — if you add a new variant to the union,
// the compiler will force you to handle it everywhere when/map is used.
