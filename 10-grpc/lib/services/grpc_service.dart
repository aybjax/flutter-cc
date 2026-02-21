// =============================================================================
// services/grpc_service.dart — gRPC channel management and RPC calls
// =============================================================================
//
// This service manages the gRPC ClientChannel and makes raw RPC calls to the
// Go backend. It handles:
//
//   - Channel creation and lifecycle
//   - Metadata injection (e.g., auth tokens)
//   - Deadline/timeout configuration
//   - Conversion between proto types and app models
//   - Server-streaming for WatchBoard
//
// In a real app with protoc-generated code, you would use the generated
// client stub directly. Since we have hand-written proto types, this service
// acts as the bridge between the gRPC transport and the app layer.
//
// Architecture note: This is the ONLY file that knows about gRPC details.
// The repository layer above it only sees app-layer types.
// =============================================================================

import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:grpc_tutorial/models/models.dart';
import 'package:grpc_tutorial/proto/taskboard.dart';

// ---------------------------------------------------------------------------
// GrpcService — manages gRPC channel and makes typed RPC calls
// ---------------------------------------------------------------------------

/// Service that wraps gRPC communication with the Task Board backend.
///
/// ## Channel Lifecycle
/// Create the service, use it for RPCs, then call [shutdown] when done:
/// ```dart
/// final service = GrpcService();
/// final boards = await service.getBoards();
/// await service.shutdown();
/// ```
///
/// ## Deadlines
/// All unary RPCs use a default 10-second deadline. Override per-call:
/// ```dart
/// final boards = await service.getBoards(
///   options: CallOptions(timeout: Duration(seconds: 30)),
/// );
/// ```
class GrpcService {
  /// The host where the gRPC server is running.
  ///
  /// Use 'localhost' for desktop, '10.0.2.2' for Android emulator,
  /// or the actual IP for physical devices.
  final String host;

  /// The port the gRPC server listens on.
  final int port;

  late final ClientChannel _channel;

  // Alternative: accept a pre-built channel for testing
  // GrpcService({ClientChannel? channel, this.host = 'localhost', this.port = 50051})
  //   : _channel = channel ?? _createChannel(host, port);

  /// Creates a [GrpcService] connected to the given [host] and [port].
  ///
  /// Defaults to localhost:50051 (matching the Go server defaults).
  /// For Android emulator, use host '10.0.2.2'.
  GrpcService({
    this.host = 'localhost',
    this.port = 50051,
  }) {
    _channel = ClientChannel(
      host,
      port: port,
      options: const ChannelOptions(
        // Use insecure credentials for local development.
        // In production, use TLS:
        //   credentials: ChannelCredentials.secure(
        //     certificates: File('cert.pem').readAsBytesSync(),
        //   ),
        credentials: ChannelCredentials.insecure(),

        // Connection timeout
        connectionTimeout: Duration(seconds: 10),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Default call options (metadata, deadlines)
  // ---------------------------------------------------------------------------

  /// Creates [CallOptions] with a default 10-second deadline.
  ///
  /// In production, you would also inject auth tokens:
  /// ```dart
  /// CallOptions(
  ///   metadata: {'authorization': 'Bearer $token'},
  ///   timeout: Duration(seconds: 10),
  /// )
  /// ```
  // ignore: unused_element
  CallOptions _defaultOptions([CallOptions? override]) {
    final defaults = CallOptions(
      timeout: const Duration(seconds: 10),
      // metadata: {'x-request-id': uuid.v4()},
    );

    if (override != null) {
      return defaults.mergedWith(override);
    }
    return defaults;
  }

  // ---------------------------------------------------------------------------
  // Unary RPCs
  // ---------------------------------------------------------------------------

  /// Fetches all boards from the server.
  ///
  /// Returns a list of [Board] app models (not proto types).
  Future<List<Board>> getBoards({CallOptions? options}) async {
    // In a real app with generated code, this would be:
    //   final response = await _stub.getBoards(Empty(), options: options);
    //   return response.boards.map(_boardFromProto).toList();

    // Since we're simulating, we create a mock response.
    // When connected to a real server with generated stubs, replace this
    // with actual stub calls.
    // In a real app with generated code, you would create a call like:
    //   final call = _channel.createCall(
    //     ClientMethod<Empty, BoardList>('/taskboard.TaskBoardService/GetBoards', ...),
    //     Stream.value(Empty()),
    //     _defaultOptions(options),
    //   );
    //
    // For demonstration purposes, throw so the repository catches it
    // and the cubit can show the error state.
    // In production with real generated code, this would work end-to-end.
    throw GrpcError.unavailable(
      'Stub client — replace with protoc-generated code for real gRPC calls',
    );
  }

  /// Fetches a single board by ID.
  Future<Board> getBoard(String boardId, {CallOptions? options}) async {
    throw GrpcError.unavailable(
      'Stub client — replace with protoc-generated code for real gRPC calls',
    );
  }

  /// Creates a new card on the specified board/column.
  Future<TaskCard> createCard({
    required String boardId,
    required String columnId,
    required String title,
    required String description,
    CallOptions? options,
  }) async {
    throw GrpcError.unavailable(
      'Stub client — replace with protoc-generated code for real gRPC calls',
    );
  }

  /// Moves a card to a different column and/or position.
  Future<TaskCard> moveCard({
    required String cardId,
    required String targetColumnId,
    required int targetPosition,
    CallOptions? options,
  }) async {
    throw GrpcError.unavailable(
      'Stub client — replace with protoc-generated code for real gRPC calls',
    );
  }

  /// Deletes a card by ID.
  Future<void> deleteCard(String cardId, {CallOptions? options}) async {
    throw GrpcError.unavailable(
      'Stub client — replace with protoc-generated code for real gRPC calls',
    );
  }

  // ---------------------------------------------------------------------------
  // Server-streaming RPC
  // ---------------------------------------------------------------------------

  /// Watches a board for real-time updates (server-streaming RPC).
  ///
  /// Returns a [Stream<Board>] that emits the full board state whenever
  /// a change occurs (card created, moved, deleted).
  ///
  /// The stream stays open until cancelled. Use it with a StreamSubscription:
  /// ```dart
  /// final subscription = service.watchBoard('board_1').listen(
  ///   (board) => setState(() => _board = board),
  ///   onError: (e) => showError(e),
  /// );
  /// // Later:
  /// await subscription.cancel();
  /// ```
  Stream<Board> watchBoard(String boardId, {CallOptions? options}) {
    // In real generated code:
    //   final stream = _stub.watchBoard(
    //     BoardRequest()..boardId = boardId,
    //     options: options,
    //   );
    //   return stream.map((update) => _boardFromProto(update.board));

    // Stub implementation — returns an error stream
    return Stream.error(
      GrpcError.unavailable(
        'Stub client — replace with protoc-generated code',
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Conversion helpers (proto -> app models)
  // ---------------------------------------------------------------------------

  /// Converts a [GrpcBoard] proto message to an app-layer [Board] model.
  static Board boardFromProto(GrpcBoard proto) {
    return Board(
      id: proto.id,
      name: proto.name,
      columns: proto.columns.map(columnFromProto).toList()
        ..sort((a, b) => a.position.compareTo(b.position)),
    );
  }

  /// Converts a [GrpcColumn] proto message to an app-layer [BoardColumn].
  static BoardColumn columnFromProto(GrpcColumn proto) {
    return BoardColumn(
      id: proto.id,
      name: proto.name,
      position: proto.position,
      cards: proto.cards.map(cardFromProto).toList()
        ..sort((a, b) => a.position.compareTo(b.position)),
    );
  }

  /// Converts a [GrpcCard] proto message to an app-layer [TaskCard].
  static TaskCard cardFromProto(GrpcCard proto) {
    return TaskCard(
      id: proto.id,
      title: proto.title,
      description: proto.description,
      columnId: proto.columnId,
      position: proto.position,
    );
  }

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  /// Shuts down the gRPC channel, closing all active connections.
  ///
  /// Call this when the app is disposing (e.g., in a provider's dispose).
  Future<void> shutdown() async {
    await _channel.shutdown();
  }
}
