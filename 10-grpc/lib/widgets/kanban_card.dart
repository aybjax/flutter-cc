// =============================================================================
// widgets/kanban_card.dart — Visual representation of a task card
// =============================================================================
//
// Renders a single task card with its title and description. Used by
// DraggableCard as the visual content (both in normal and dragging states).
//
// This widget is purely presentational — it doesn't handle drag gestures
// or state management. That's the job of DraggableCard.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:grpc_tutorial/models/models.dart';

// ---------------------------------------------------------------------------
// KanbanCard
// ---------------------------------------------------------------------------

/// A visual card widget showing a task's title and description.
///
/// Used inside [DraggableCard] as the child content. Can also be used
/// standalone for previews or non-interactive lists.
///
/// The card uses Material 3 styling with elevation for the drag feedback.
class KanbanCard extends StatelessWidget {
  /// The task card data to display.
  final TaskCard card;

  /// Whether this card is being dragged (affects styling).
  final bool isDragging;

  /// Optional callback when the card is tapped.
  final VoidCallback? onTap;

  /// Optional callback when the delete action is triggered.
  final VoidCallback? onDelete;

  const KanbanCard({
    super.key,
    required this.card,
    this.isDragging = false,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: isDragging ? 8 : 1,
      // Reduce opacity when dragging to indicate the original position
      color: isDragging
          ? theme.colorScheme.surfaceContainerHigh.withValues(alpha: 0.5)
          : theme.colorScheme.surfaceContainerHigh,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        // Alternative: add a left border for visual categorization
        // side: BorderSide(
        //   color: _getCategoryColor(card.category),
        //   width: 3,
        // ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title row with optional delete button
              Row(
                children: [
                  Expanded(
                    child: Text(
                      card.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (onDelete != null)
                    InkWell(
                      onTap: onDelete,
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ),
                ],
              ),

              // Description (if present)
              if (card.description.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  card.description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],

              // Alternative: show a drag handle icon
              // const SizedBox(height: 8),
              // Icon(Icons.drag_handle, size: 16, color: theme.colorScheme.outline),
            ],
          ),
        ),
      ),
    );
  }
}
