// =============================================================================
// models/card.dart — Freezed Card (Task) model
// =============================================================================
//
// Named "TaskCard" instead of "Card" to avoid conflicts with Flutter's
// Material Card widget. This represents a single task/work item on the board.
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'card.freezed.dart';
part 'card.g.dart';

// ---------------------------------------------------------------------------
// TaskCard model
// ---------------------------------------------------------------------------

/// A task card on the Kanban board.
///
/// Each card belongs to exactly one column (identified by [columnId])
/// and has a [position] within that column for ordering.
@freezed
abstract class TaskCard with _$TaskCard {
  /// Creates a [TaskCard] with the given properties.
  const factory TaskCard({
    /// Unique identifier for the card.
    required String id,

    /// Short title of the task.
    required String title,

    /// Longer description of what the task involves.
    @Default('') String description,

    /// The ID of the column this card belongs to.
    required String columnId,

    /// Zero-based position within the column (top to bottom).
    required int position,
  }) = _TaskCard;

  /// Creates a [TaskCard] from a JSON map.
  factory TaskCard.fromJson(Map<String, dynamic> json) =>
      _$TaskCardFromJson(json);
}
