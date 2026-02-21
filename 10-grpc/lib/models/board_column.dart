// =============================================================================
// models/board_column.dart — Freezed Column model
// =============================================================================
//
// Named "BoardColumn" instead of "Column" to avoid conflicts with Flutter's
// built-in Column widget. This is a common naming convention in Kanban apps.
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grpc_tutorial/models/card.dart';

part 'board_column.freezed.dart';
part 'board_column.g.dart';

// ---------------------------------------------------------------------------
// BoardColumn model
// ---------------------------------------------------------------------------

/// A column (lane/stage) in a Kanban board, such as "To Do" or "In Progress".
///
/// Each column holds an ordered list of [TaskCard] items. The [position]
/// determines the left-to-right ordering of columns on the board.
@freezed
abstract class BoardColumn with _$BoardColumn {
  /// Creates a [BoardColumn] with the given properties.
  const factory BoardColumn({
    /// Unique identifier for the column.
    required String id,

    /// Display name (e.g., "To Do", "In Progress", "Done").
    required String name,

    /// Zero-based position in the board (left to right).
    required int position,

    /// Cards currently in this column, ordered by position.
    @Default([]) List<TaskCard> cards,
  }) = _BoardColumn;

  /// Creates a [BoardColumn] from a JSON map.
  factory BoardColumn.fromJson(Map<String, dynamic> json) =>
      _$BoardColumnFromJson(json);
}
