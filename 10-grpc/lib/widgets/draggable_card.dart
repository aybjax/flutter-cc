// =============================================================================
// widgets/draggable_card.dart — Draggable wrapper for Kanban cards
// =============================================================================
//
// Wraps a KanbanCard with Flutter's Draggable widget to enable drag-and-drop
// between columns. When a card is dragged over a KanbanColumn, it can be
// dropped to move it to that column.
//
// The drag data payload is the TaskCard model itself, which KanbanColumn's
// DragTarget receives and uses to call the MoveCard RPC.
//
// Visual states:
//   - Normal: full card appearance
//   - Dragging: elevated card following the pointer
//   - Origin (childWhenDragging): faded placeholder at the original position
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_tutorial/l10n/app_localizations.dart';
import 'package:grpc_tutorial/cubits/board_cubit.dart';
import 'package:grpc_tutorial/models/models.dart';
import 'package:grpc_tutorial/widgets/kanban_card.dart';

// ---------------------------------------------------------------------------
// DraggableCard
// ---------------------------------------------------------------------------

/// A card that can be dragged between Kanban columns.
///
/// Uses Flutter's [LongPressDraggable] (requires long press to start dragging)
/// to prevent accidental drags when scrolling. The drag feedback shows an
/// elevated version of the card, and the original position shows a faded
/// placeholder.
class DraggableCard extends StatelessWidget {
  /// The task card data.
  final TaskCard card;

  /// The board ID (needed for delete operations via the cubit).
  final String boardId;

  const DraggableCard({
    super.key,
    required this.card,
    required this.boardId,
  });

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<TaskCard>(
      // The data payload sent to the DragTarget
      data: card,

      // What appears under the user's finger while dragging
      feedback: SizedBox(
        width: 260, // Match column width minus padding
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(8),
          child: KanbanCard(
            card: card,
            isDragging: true,
          ),
        ),
      ),

      // What's left at the original position while dragging
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: KanbanCard(card: card),
      ),

      // Alternative: use maxSimultaneousDrags to prevent multi-touch issues
      // maxSimultaneousDrags: 1,

      // Normal appearance — `child` should be last per lint rules
      child: KanbanCard(
        card: card,
        onDelete: () => _confirmDelete(context),
        // Alternative: navigate to edit screen on tap
        // onTap: () => _navigateToEdit(context),
      ),
    );
  }

  /// Shows a confirmation dialog before deleting the card.
  void _confirmDelete(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.delete),
        content: Text(l10n.deleteConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(l10n.delete),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed == true && context.mounted) {
        context.read<BoardDetailCubit>().deleteCard(card.id);
      }
    });
  }
}
