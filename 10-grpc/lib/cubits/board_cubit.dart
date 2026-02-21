// =============================================================================
// cubits/board_cubit.dart — Cubits for board list and board detail
// =============================================================================
//
// Two cubits are defined here:
//   - BoardListCubit: manages the list of all boards
//   - BoardDetailCubit: manages a single board's Kanban view with streaming
//
// Both use the repository for data access and emit freezed state objects.
// The BoardDetailCubit demonstrates server-streaming gRPC with WatchBoard.
// =============================================================================

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_tutorial/cubits/board_state.dart';
import 'package:grpc_tutorial/repositories/board_repository.dart';

// ---------------------------------------------------------------------------
// BoardListCubit — manages the board list
// ---------------------------------------------------------------------------

/// Cubit for the board list screen.
///
/// Fetches all available boards and emits the appropriate state.
class BoardListCubit extends Cubit<BoardListState> {
  final BoardRepository _repository;

  /// Creates a [BoardListCubit] with the given repository.
  BoardListCubit(this._repository) : super(const BoardListState.initial());

  /// Loads all boards from the server.
  ///
  /// Emits [BoardListLoading], then either [BoardListLoaded] or [BoardListError].
  Future<void> loadBoards() async {
    emit(const BoardListState.loading());

    final result = await _repository.getBoards();

    result.fold(
      (failure) => emit(BoardListState.error(failure)),
      (boards) => emit(BoardListState.loaded(boards)),
    );
  }
}

// ---------------------------------------------------------------------------
// BoardDetailCubit — manages a single board with streaming updates
// ---------------------------------------------------------------------------

/// Cubit for the board detail (Kanban) screen.
///
/// Provides:
///   - One-time board loading via [loadBoard]
///   - Real-time updates via [startWatching] / [stopWatching]
///   - Card CRUD operations (create, move, delete)
///
/// The streaming support uses the server-streaming WatchBoard RPC, which
/// pushes board updates whenever any client modifies the board. This enables
/// real-time collaboration.
class BoardDetailCubit extends Cubit<BoardDetailState> {
  final BoardRepository _repository;
  final String boardId;

  /// Subscription for the WatchBoard server-streaming RPC.
  StreamSubscription<dynamic>? _watchSubscription;

  /// Creates a [BoardDetailCubit] for the given board.
  BoardDetailCubit(this._repository, {required this.boardId})
      : super(const BoardDetailState.initial());

  // ---------------------------------------------------------------------------
  // Load board (one-time fetch)
  // ---------------------------------------------------------------------------

  /// Fetches the board data once (unary GetBoard RPC).
  ///
  /// Use this for initial load. For real-time updates, use [startWatching].
  Future<void> loadBoard() async {
    emit(const BoardDetailState.loading());

    final result = await _repository.getBoard(boardId);

    result.fold(
      (failure) => emit(BoardDetailState.error(failure)),
      (board) => emit(BoardDetailState.loaded(board)),
    );
  }

  // ---------------------------------------------------------------------------
  // Watch board (server-streaming)
  // ---------------------------------------------------------------------------

  /// Starts watching the board for real-time updates.
  ///
  /// This opens a server-streaming gRPC connection. Each time a card is
  /// created, moved, or deleted (by any client), the server pushes the
  /// updated board state.
  ///
  /// Call [stopWatching] to close the stream.
  void startWatching() {
    // Cancel any existing subscription
    _watchSubscription?.cancel();

    _watchSubscription = _repository.watchBoard(boardId).listen(
      (either) {
        either.fold(
          (failure) => emit(BoardDetailState.error(failure)),
          (board) => emit(BoardDetailState.loaded(board, isWatching: true)),
        );
      },
      onError: (Object error) {
        // Stream error — fall back to non-watching loaded state
        // The UI should show a reconnect option
        final currentState = state;
        if (currentState is BoardDetailLoaded) {
          emit(BoardDetailState.loaded(currentState.board, isWatching: false));
        }
      },
      cancelOnError: false, // Keep listening even after errors
    );
  }

  /// Stops watching the board for real-time updates.
  void stopWatching() {
    _watchSubscription?.cancel();
    _watchSubscription = null;

    // Update state to reflect that we're no longer watching
    final currentState = state;
    if (currentState is BoardDetailLoaded) {
      emit(BoardDetailState.loaded(currentState.board, isWatching: false));
    }
  }

  // ---------------------------------------------------------------------------
  // Card operations
  // ---------------------------------------------------------------------------

  /// Creates a new card in the specified column.
  ///
  /// After creation, reloads the board to reflect the change.
  /// If watching is active, the stream will also deliver the update.
  Future<void> createCard({
    required String columnId,
    required String title,
    required String description,
  }) async {
    final result = await _repository.createCard(
      boardId: boardId,
      columnId: columnId,
      title: title,
      description: description,
    );

    result.fold(
      (failure) {
        // Don't replace the current board state on card creation failure.
        // Instead, we could emit a separate "operation failed" state,
        // but for simplicity we'll just reload.
      },
      (_) async {
        // If not watching (which would auto-update), reload manually
        if (_watchSubscription == null) {
          await loadBoard();
        }
      },
    );
  }

  /// Moves a card to a different column and/or position.
  ///
  /// This is called when the user drags a card between columns.
  Future<void> moveCard({
    required String cardId,
    required String targetColumnId,
    required int targetPosition,
  }) async {
    final result = await _repository.moveCard(
      cardId: cardId,
      targetColumnId: targetColumnId,
      targetPosition: targetPosition,
    );

    result.fold(
      (failure) {
        // On failure, reload to revert the optimistic UI update
        loadBoard();
      },
      (_) async {
        if (_watchSubscription == null) {
          await loadBoard();
        }
      },
    );
  }

  /// Deletes a card by ID.
  Future<void> deleteCard(String cardId) async {
    final result = await _repository.deleteCard(cardId);

    result.fold(
      (failure) {
        // Reload on failure to revert any optimistic changes
        loadBoard();
      },
      (_) async {
        if (_watchSubscription == null) {
          await loadBoard();
        }
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  @override
  Future<void> close() {
    _watchSubscription?.cancel();
    return super.close();
  }
}
