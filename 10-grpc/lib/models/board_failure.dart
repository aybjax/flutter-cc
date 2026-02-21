// =============================================================================
// models/board_failure.dart — Freezed union type for board operation failures
// =============================================================================
//
// Uses freezed union types (sealed classes) to represent all possible failure
// modes. This pairs with dartz's Either<BoardFailure, T> for type-safe error
// handling without exceptions.
//
// Pattern:
//   Either<BoardFailure, Board> result = await repo.getBoard(id);
//   result.fold(
//     (failure) => failure.map(
//       connectionError: (_) => showError('No connection'),
//       notFound: (_) => showError('Board not found'),
//       ...
//     ),
//     (board) => showBoard(board),
//   );
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'board_failure.freezed.dart';

// ---------------------------------------------------------------------------
// BoardFailure union type
// ---------------------------------------------------------------------------

/// Represents all possible failure modes for board operations.
///
/// Using a freezed union instead of exceptions gives us:
///   - Exhaustive pattern matching (compiler warns if we miss a case)
///   - No runtime surprises from uncaught exceptions
///   - Clear documentation of what can go wrong
@freezed
sealed class BoardFailure with _$BoardFailure {
  /// The gRPC server is unreachable or the connection was lost.
  const factory BoardFailure.connectionError(String message) =
      _ConnectionError;

  /// The requested board/card/column was not found on the server.
  const factory BoardFailure.notFound(String message) = _NotFound;

  /// The server rejected the request due to invalid data.
  const factory BoardFailure.invalidArgument(String message) =
      _InvalidArgument;

  /// The server encountered an internal error.
  const factory BoardFailure.serverError(String message) = _ServerError;

  /// An unexpected error that doesn't fit other categories.
  const factory BoardFailure.unexpected(String message) = _Unexpected;

  // Alternative: you could add a `timeout` variant for deadline exceeded:
  // const factory BoardFailure.timeout(String message) = _Timeout;
}
