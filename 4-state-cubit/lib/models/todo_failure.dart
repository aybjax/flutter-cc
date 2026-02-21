// =============================================================================
// Todo Failure — Freezed Union Types for Error Handling
// =============================================================================
// Concepts demonstrated:
// - Freezed union types (sealed classes) for exhaustive error handling
// - Multiple factory constructors → multiple subtypes
// - when() / map() for pattern matching on union variants
// - How to use union types with dartz Either<Failure, Success>
//
// Cubit + Either pattern:
//   Repository returns: Either<TodoFailure, TodoDetail>
//   Cubit handles: fold(
//     (failure) => emit(TodoDetailState.error(failure)),
//     (detail) => emit(TodoDetailState.loaded(detail)),
//   )
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_failure.freezed.dart';

// =============================================================================
// Union Types for Typed Errors
// =============================================================================
// Instead of throwing exceptions or returning error strings, we use a sealed
// union type. This gives us:
// 1. Exhaustive checking — the compiler forces handling every variant
// 2. Typed data per variant — each error carries relevant info
// 3. No try/catch — errors are values in the return type
// 4. Composable with Either — fits naturally into functional error handling

/// Represents all the ways a todo operation can fail.
///
/// Usage with dartz Either:
/// ```dart
/// Either<TodoFailure, TodoDetail> result = await repository.getTodo(id);
/// result.fold(
///   (failure) => failure.when(
///     network: (message) => 'Network error: $message',
///     server: (message, code) => 'Server error $code: $message',
///     unauthorized: () => 'Please login again',
///     notFound: (id) => 'Todo #$id not found',
///     validation: (field, message) => 'Invalid $field: $message',
///     unexpected: (error) => 'Unexpected: $error',
///   ),
///   (todo) => 'Found: ${todo.title}',
/// );
/// ```
@freezed
sealed class TodoFailure with _$TodoFailure {
  /// A network error (no connectivity, timeout, DNS failure, etc.).
  const factory TodoFailure.network({required String message}) = _Network;

  /// The server returned an error response (4xx/5xx).
  const factory TodoFailure.server({
    required String message,
    required int statusCode,
  }) = _Server;

  /// The auth token is missing or expired (401).
  ///
  /// The UI should redirect to the login screen when this occurs.
  const factory TodoFailure.unauthorized() = _Unauthorized;

  /// The requested resource was not found (404).
  const factory TodoFailure.notFound({required int id}) = _NotFound;

  /// A client-side validation error (empty title, etc.).
  const factory TodoFailure.validation({
    required String field,
    required String message,
  }) = _Validation;

  /// A catch-all for unexpected errors (JSON parsing, etc.).
  const factory TodoFailure.unexpected({required Object error}) = _Unexpected;
}

// =============================================================================
// Pattern Matching with when() and map()
// =============================================================================
//
// Freezed generates two pattern-matching methods:
//
// 1. when() — provides the FIELDS of each variant:
//    failure.when(
//      network: (message) => ...,
//      server: (message, code) => ...,
//      unauthorized: () => ...,
//      notFound: (id) => ...,
//      validation: (field, message) => ...,
//      unexpected: (error) => ...,
//    );
//
// 2. map() — provides the VARIANT OBJECT itself:
//    failure.map(
//      network: (network) => network.message,
//      server: (server) => '${server.statusCode}: ${server.message}',
//      unauthorized: (_) => 'unauthorized',
//      notFound: (nf) => 'not found: ${nf.id}',
//      validation: (v) => '${v.field}: ${v.message}',
//      unexpected: (u) => u.error.toString(),
//    );
//
// 3. maybeWhen() / maybeMap() — same but with orElse fallback:
//    failure.maybeWhen(
//      unauthorized: () => navigateToLogin(),
//      orElse: () => showGenericError(),
//    );
//
// All of these are EXHAUSTIVE — if you add a new variant to the union,
// the compiler will force you to handle it everywhere when/map is used.
//
// Cubit comparison:
// - With ChangeNotifier, you'd typically use String error messages
// - With Cubit + freezed union, errors are typed and exhaustively checked
// - This makes error handling more robust and maintainable
// =============================================================================
