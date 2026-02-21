// =============================================================================
// repositories/board_repository.dart — Either-based repository wrapping gRPC
// =============================================================================
//
// The repository pattern creates a clean boundary between the data/transport
// layer (gRPC) and the business logic layer (cubits). Benefits:
//
//   - Cubits never deal with gRPC errors or proto types directly
//   - All errors are converted to typed BoardFailure values
//   - Return types use Either<BoardFailure, T> for explicit error handling
//   - Easy to swap gRPC for REST/GraphQL by changing only this layer
//   - Easy to mock for testing (just implement the same interface)
//
// The repository catches all gRPC exceptions and converts them to the
// appropriate BoardFailure variant using gRPC status codes.
// =============================================================================

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc_tutorial/models/models.dart';
import 'package:grpc_tutorial/services/grpc_service.dart';

// ---------------------------------------------------------------------------
// BoardRepository
// ---------------------------------------------------------------------------

/// Repository that wraps [GrpcService] calls with Either-based error handling.
///
/// Every public method returns `Either<BoardFailure, T>` so the caller
/// knows exactly what can go wrong and must handle both cases.
///
/// ## Usage with cubits:
/// ```dart
/// final result = await repository.getBoard('board_1');
/// result.fold(
///   (failure) => emit(BoardState.error(failure)),
///   (board) => emit(BoardState.loaded(board)),
/// );
/// ```
class BoardRepository {
  final GrpcService _grpcService;

  /// Creates a [BoardRepository] backed by the given [GrpcService].
  BoardRepository(this._grpcService);

  // Alternative: accept an abstract interface for testing:
  // BoardRepository(GrpcServiceInterface service) : _grpcService = service;

  // ---------------------------------------------------------------------------
  // Board operations
  // ---------------------------------------------------------------------------

  /// Fetches all available boards.
  ///
  /// Returns [Right] with the board list on success, or [Left] with a
  /// [BoardFailure] describing what went wrong.
  Future<Either<BoardFailure, List<Board>>> getBoards() async {
    try {
      final boards = await _grpcService.getBoards();
      return right(boards);
    } on GrpcError catch (e) {
      return left(_mapGrpcError(e));
    } catch (e) {
      return left(BoardFailure.unexpected(e.toString()));
    }
  }

  /// Fetches a single board with all its columns and cards.
  Future<Either<BoardFailure, Board>> getBoard(String boardId) async {
    try {
      final board = await _grpcService.getBoard(boardId);
      return right(board);
    } on GrpcError catch (e) {
      return left(_mapGrpcError(e));
    } catch (e) {
      return left(BoardFailure.unexpected(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Card operations
  // ---------------------------------------------------------------------------

  /// Creates a new card in the specified column.
  Future<Either<BoardFailure, TaskCard>> createCard({
    required String boardId,
    required String columnId,
    required String title,
    required String description,
  }) async {
    try {
      final card = await _grpcService.createCard(
        boardId: boardId,
        columnId: columnId,
        title: title,
        description: description,
      );
      return right(card);
    } on GrpcError catch (e) {
      return left(_mapGrpcError(e));
    } catch (e) {
      return left(BoardFailure.unexpected(e.toString()));
    }
  }

  /// Moves a card to a different column and/or position.
  Future<Either<BoardFailure, TaskCard>> moveCard({
    required String cardId,
    required String targetColumnId,
    required int targetPosition,
  }) async {
    try {
      final card = await _grpcService.moveCard(
        cardId: cardId,
        targetColumnId: targetColumnId,
        targetPosition: targetPosition,
      );
      return right(card);
    } on GrpcError catch (e) {
      return left(_mapGrpcError(e));
    } catch (e) {
      return left(BoardFailure.unexpected(e.toString()));
    }
  }

  /// Deletes a card by ID.
  Future<Either<BoardFailure, Unit>> deleteCard(String cardId) async {
    try {
      await _grpcService.deleteCard(cardId);
      return right(unit);
    } on GrpcError catch (e) {
      return left(_mapGrpcError(e));
    } catch (e) {
      return left(BoardFailure.unexpected(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Streaming
  // ---------------------------------------------------------------------------

  /// Returns a stream of board updates for real-time synchronization.
  ///
  /// The stream emits Either values: Left for errors, Right for board updates.
  /// This allows the cubit to handle connection errors gracefully without
  /// the stream terminating.
  Stream<Either<BoardFailure, Board>> watchBoard(String boardId) {
    return _grpcService.watchBoard(boardId).map<Either<BoardFailure, Board>>(
      (board) => right(board),
    ).handleError(
      (Object error) {
        if (error is GrpcError) {
          return left(_mapGrpcError(error));
        }
        return left(BoardFailure.unexpected(error.toString()));
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Error mapping
  // ---------------------------------------------------------------------------

  /// Converts a [GrpcError] to the appropriate [BoardFailure] variant.
  ///
  /// gRPC status codes map cleanly to our failure types:
  ///   - UNAVAILABLE, DEADLINE_EXCEEDED -> connectionError
  ///   - NOT_FOUND                      -> notFound
  ///   - INVALID_ARGUMENT               -> invalidArgument
  ///   - INTERNAL, UNKNOWN              -> serverError
  ///   - everything else                -> unexpected
  BoardFailure _mapGrpcError(GrpcError error) {
    final message = error.message ?? 'Unknown gRPC error';

    switch (error.code) {
      case StatusCode.unavailable:
      case StatusCode.deadlineExceeded:
        return BoardFailure.connectionError(message);

      case StatusCode.notFound:
        return BoardFailure.notFound(message);

      case StatusCode.invalidArgument:
        return BoardFailure.invalidArgument(message);

      case StatusCode.internal:
      case StatusCode.unknown:
        return BoardFailure.serverError(message);

      default:
        return BoardFailure.unexpected('gRPC ${error.code}: $message');
    }
  }

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  /// Shuts down the underlying gRPC service.
  Future<void> dispose() async {
    await _grpcService.shutdown();
  }
}
