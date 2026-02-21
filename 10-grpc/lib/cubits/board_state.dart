// =============================================================================
// cubits/board_state.dart — Freezed state for the BoardCubit
// =============================================================================
//
// Uses freezed union types to represent all possible states of the board UI.
// This ensures exhaustive handling in the UI layer — you can't forget to
// handle an error state because the compiler will warn you.
//
// State flow:
//   initial -> loading -> loaded | error
//                          |
//                          v
//                       loading (on refresh) -> loaded | error
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grpc_tutorial/models/models.dart';

part 'board_state.freezed.dart';

// ---------------------------------------------------------------------------
// BoardListState — state for the board list screen
// ---------------------------------------------------------------------------

/// State for the board list screen.
@freezed
sealed class BoardListState with _$BoardListState {
  /// Initial state before any data is loaded.
  const factory BoardListState.initial() = BoardListInitial;

  /// Loading state while fetching boards.
  const factory BoardListState.loading() = BoardListLoading;

  /// Loaded state with a list of boards.
  const factory BoardListState.loaded(List<Board> boards) = BoardListLoaded;

  /// Error state with a failure description.
  const factory BoardListState.error(BoardFailure failure) = BoardListError;
}

// ---------------------------------------------------------------------------
// BoardDetailState — state for the single board (Kanban) screen
// ---------------------------------------------------------------------------

/// State for the board detail (Kanban) screen.
///
/// Tracks both the board data and whether we're watching for live updates.
@freezed
sealed class BoardDetailState with _$BoardDetailState {
  /// Initial state before the board is loaded.
  const factory BoardDetailState.initial() = BoardDetailInitial;

  /// Loading state while fetching the board.
  const factory BoardDetailState.loading() = BoardDetailLoading;

  /// Loaded state with the full board data.
  ///
  /// [isWatching] indicates whether the server-streaming WatchBoard RPC
  /// is active, providing real-time updates.
  const factory BoardDetailState.loaded(
    Board board, {
    @Default(false) bool isWatching,
  }) = BoardDetailLoaded;

  /// Error state with a failure description.
  const factory BoardDetailState.error(BoardFailure failure) = BoardDetailError;
}
