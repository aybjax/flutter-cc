// =============================================================================
// models/board.dart — Freezed Board model
// =============================================================================
//
// This file defines the app-layer Board model using @freezed. It is separate
// from the proto/gRPC types (GrpcBoard) to maintain a clean architecture
// boundary. The repository layer converts between GrpcBoard and Board.
//
// Why separate models?
//   - Proto types are transport-layer concerns (serialization format)
//   - App models are domain-layer concerns (business logic, UI)
//   - Decoupling lets you switch transports (REST, GraphQL) without
//     changing domain code
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grpc_tutorial/models/board_column.dart';

part 'board.freezed.dart';
part 'board.g.dart';

// ---------------------------------------------------------------------------
// Board model
// ---------------------------------------------------------------------------

/// A Kanban board containing multiple columns.
///
/// Uses @freezed for immutability, copyWith, equality, and JSON serialization.
@freezed
abstract class Board with _$Board {
  /// Creates a [Board] with the given [id], [name], and [columns].
  const factory Board({
    /// Unique identifier for the board.
    required String id,

    /// Human-readable name (e.g., "Project Alpha").
    required String name,

    /// Ordered list of columns in this board.
    @Default([]) List<BoardColumn> columns,
  }) = _Board;

  /// Creates a [Board] from a JSON map.
  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);
}
