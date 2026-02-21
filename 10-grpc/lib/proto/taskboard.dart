// =============================================================================
// proto/taskboard.dart — Hand-written equivalent of protoc-gen-dart output
// =============================================================================
//
// In a real project, you would NOT write this file by hand. Instead, you
// would run:
//
//   protoc --dart_out=grpc:lib/proto proto/taskboard.proto
//
// That generates several files:
//   - taskboard.pb.dart       (message classes extending GeneratedMessage)
//   - taskboard.pbenum.dart   (enum types, if any)
//   - taskboard.pbjson.dart   (JSON metadata for reflection)
//   - taskboard.pbgrpc.dart   (client stub & service base classes)
//
// This file provides plain Dart classes that mirror the proto messages,
// plus a gRPC client stub class that uses the `grpc` package directly.
// The API surface is designed to match what protoc would generate, so
// switching to real generated code requires minimal changes.
//
// KEY DIFFERENCES from real protoc output:
//   1. Real generated messages extend `GeneratedMessage` from package:protobuf
//   2. Real messages use field numbers and binary serialization
//   3. Real client stubs use `ClientChannel` and `CallOptions` from package:grpc
//   4. Real server-streaming RPCs return `ResponseStream<T>`
//
// We replicate the essential API shape so the rest of the app code (services,
// repositories, cubits) can be written against these types and would work
// with real generated code after a simple import swap.
// =============================================================================

import 'dart:async';

import 'package:grpc/grpc.dart';

// ---------------------------------------------------------------------------
// Message classes
// ---------------------------------------------------------------------------

/// GrpcBoard mirrors the `Board` protobuf message.
///
/// In real generated code, this would extend `GeneratedMessage` and have
/// methods like `writeToBuffer()`, `mergeFromBuffer()`, etc.
class GrpcBoard {
  /// Unique board identifier.
  final String id;

  /// Human-readable board name.
  final String name;

  /// Ordered list of columns in this board.
  final List<GrpcColumn> columns;

  GrpcBoard({
    required this.id,
    required this.name,
    required this.columns,
  });

  /// Factory to create from a Map (simulating protobuf JSON deserialization).
  ///
  /// Real generated code would use `Board.fromBuffer(bytes)` or
  /// `Board.fromJson(jsonString)` instead.
  factory GrpcBoard.fromMap(Map<String, dynamic> map) {
    return GrpcBoard(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      columns: (map['columns'] as List<dynamic>?)
              ?.map((c) => GrpcColumn.fromMap(c as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'columns': columns.map((c) => c.toMap()).toList(),
      };
}

/// GrpcColumn mirrors the `Column` protobuf message.
class GrpcColumn {
  final String id;
  final String name;
  final int position;
  final List<GrpcCard> cards;

  GrpcColumn({
    required this.id,
    required this.name,
    required this.position,
    required this.cards,
  });

  factory GrpcColumn.fromMap(Map<String, dynamic> map) {
    return GrpcColumn(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      position: map['position'] as int? ?? 0,
      cards: (map['cards'] as List<dynamic>?)
              ?.map((c) => GrpcCard.fromMap(c as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'position': position,
        'cards': cards.map((c) => c.toMap()).toList(),
      };
}

/// GrpcCard mirrors the `Card` protobuf message.
class GrpcCard {
  final String id;
  final String title;
  final String description;
  final String columnId;
  final int position;

  GrpcCard({
    required this.id,
    required this.title,
    required this.description,
    required this.columnId,
    required this.position,
  });

  factory GrpcCard.fromMap(Map<String, dynamic> map) {
    return GrpcCard(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      columnId: map['columnId'] as String? ?? map['column_id'] as String? ?? '',
      position: map['position'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'columnId': columnId,
        'position': position,
      };
}

/// GrpcBoardUpdate mirrors the `BoardUpdate` protobuf message.
///
/// Sent by the server-streaming `WatchBoard` RPC whenever the board changes.
class GrpcBoardUpdate {
  /// The type of change: "initial", "card_created", "card_moved", "card_deleted"
  final String type;

  /// The full board state after the change.
  final GrpcBoard board;

  GrpcBoardUpdate({
    required this.type,
    required this.board,
  });

  factory GrpcBoardUpdate.fromMap(Map<String, dynamic> map) {
    return GrpcBoardUpdate(
      type: map['type'] as String? ?? '',
      board: GrpcBoard.fromMap(map['board'] as Map<String, dynamic>? ?? {}),
    );
  }
}

// ---------------------------------------------------------------------------
// Request/Response wrapper classes
// ---------------------------------------------------------------------------

/// Empty message (no fields).
class GrpcEmpty {
  const GrpcEmpty();
}

/// Request to identify a board.
class GrpcBoardRequest {
  final String boardId;
  GrpcBoardRequest({required this.boardId});
}

/// Response containing a list of boards.
class GrpcBoardList {
  final List<GrpcBoard> boards;
  GrpcBoardList({required this.boards});
}

/// Request to create a new card.
class GrpcCreateCardRequest {
  final String boardId;
  final String columnId;
  final String title;
  final String description;

  GrpcCreateCardRequest({
    required this.boardId,
    required this.columnId,
    required this.title,
    required this.description,
  });
}

/// Request to move a card to a different column/position.
class GrpcMoveCardRequest {
  final String cardId;
  final String targetColumnId;
  final int targetPosition;

  GrpcMoveCardRequest({
    required this.cardId,
    required this.targetColumnId,
    required this.targetPosition,
  });
}

/// Request to delete a card.
class GrpcDeleteCardRequest {
  final String cardId;
  GrpcDeleteCardRequest({required this.cardId});
}

// ---------------------------------------------------------------------------
// Client stub
// ---------------------------------------------------------------------------

/// TaskBoardServiceClient wraps a gRPC [ClientChannel] and provides typed
/// methods for each RPC in the TaskBoardService.
///
/// In real generated code (taskboard.pbgrpc.dart), this class would:
///   1. Extend `Client` from package:grpc
///   2. Use `ClientMethod<Req, Resp>` descriptors for each RPC
///   3. Handle binary protobuf serialization automatically
///
/// This hand-written version uses the raw gRPC channel and simulates
/// the same API surface so the rest of the app can be written identically.
///
/// ## Usage:
/// ```dart
/// final channel = ClientChannel(
///   'localhost',
///   port: 50051,
///   options: ChannelOptions(credentials: ChannelCredentials.insecure()),
/// );
/// final client = TaskBoardServiceClient(channel);
/// final boards = await client.getBoards(GrpcEmpty());
/// ```
class TaskBoardServiceClient {
  /// The underlying gRPC channel.
  final ClientChannel _channel;

  // Alternative: you could accept CallOptions for default metadata/deadlines
  // final CallOptions? _defaultOptions;

  TaskBoardServiceClient(this._channel);

  /// GetBoards — fetches all boards (unary RPC).
  ///
  /// In real generated code, this would serialize [request] to protobuf bytes,
  /// send via the channel, and deserialize the response.
  ///
  /// Since we don't have real protobuf serialization, this is a stub that
  /// the [GrpcService] class wraps with actual gRPC calls.
  Future<GrpcBoardList> getBoards(
    GrpcEmpty request, {
    CallOptions? options,
  }) async {
    // Stub — the actual gRPC call is made in GrpcService
    throw UnimplementedError(
      'This stub must be replaced with real protoc-generated code, '
      'or use GrpcService which makes direct gRPC calls.',
    );
  }

  /// GetBoard — fetches a single board (unary RPC).
  Future<GrpcBoard> getBoard(
    GrpcBoardRequest request, {
    CallOptions? options,
  }) async {
    throw UnimplementedError('Use GrpcService for actual gRPC calls');
  }

  /// CreateCard — creates a new card (unary RPC).
  Future<GrpcCard> createCard(
    GrpcCreateCardRequest request, {
    CallOptions? options,
  }) async {
    throw UnimplementedError('Use GrpcService for actual gRPC calls');
  }

  /// MoveCard — moves a card (unary RPC).
  Future<GrpcCard> moveCard(
    GrpcMoveCardRequest request, {
    CallOptions? options,
  }) async {
    throw UnimplementedError('Use GrpcService for actual gRPC calls');
  }

  /// DeleteCard — deletes a card (unary RPC).
  Future<GrpcEmpty> deleteCard(
    GrpcDeleteCardRequest request, {
    CallOptions? options,
  }) async {
    throw UnimplementedError('Use GrpcService for actual gRPC calls');
  }

  /// WatchBoard — server-streaming RPC for real-time board updates.
  ///
  /// Returns a [ResponseStream] that yields [GrpcBoardUpdate] messages
  /// whenever the board changes. The stream stays open until the client
  /// cancels or the server closes the connection.
  ///
  /// In real generated code:
  /// ```dart
  /// ResponseStream<BoardUpdate> watchBoard(BoardRequest request, {CallOptions? options});
  /// ```
  ResponseStream<GrpcBoardUpdate> watchBoard(
    GrpcBoardRequest request, {
    CallOptions? options,
  }) {
    throw UnimplementedError('Use GrpcService for actual gRPC calls');
  }

  /// Returns the underlying channel (useful for shutdown).
  ClientChannel get channel => _channel;
}
