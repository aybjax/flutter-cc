// =============================================================================
// widgets/kanban_column.dart — A single column in the Kanban board
// =============================================================================
//
// Renders a vertical column with a header and a list of cards. The column
// acts as a DragTarget for receiving cards dragged from other columns.
//
// Layout:
//   ┌──────────────┐
//   │ Column Name  │  <- Header with card count
//   ├──────────────┤
//   │ Card 1       │
//   │ Card 2       │  <- Scrollable list of KanbanCard widgets
//   │ Card 3       │
//   │              │  <- DragTarget zone for dropping cards
//   └──────────────┘
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_tutorial/l10n/app_localizations.dart';
import 'package:grpc_tutorial/cubits/board_cubit.dart';
import 'package:grpc_tutorial/models/models.dart';
import 'package:grpc_tutorial/widgets/draggable_card.dart';

// ---------------------------------------------------------------------------
// KanbanColumn
// ---------------------------------------------------------------------------

/// A single column in the Kanban board view.
///
/// Displays a header with the column name and card count, followed by
/// a scrollable list of [DraggableCard] widgets. The entire column is
/// a [DragTarget] that accepts cards from other columns.
class KanbanColumn extends StatelessWidget {
  /// The column data to display.
  final BoardColumn column;

  /// The board ID (needed for card operations via the cubit).
  final String boardId;

  const KanbanColumn({
    super.key,
    required this.column,
    required this.boardId,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    // Column width — fixed for consistent horizontal scrolling
    const columnWidth = 280.0;

    return Container(
      width: columnWidth,
      margin: const EdgeInsets.only(right: 12),
      child: DragTarget<TaskCard>(
        // Accept any card that's not already in this column
        onWillAcceptWithDetails: (details) {
          return details.data.columnId != column.id;
        },

        // Handle the drop — move the card to this column
        onAcceptWithDetails: (details) {
          final card = details.data;
          // Move the card to the end of this column
          context.read<BoardDetailCubit>().moveCard(
                cardId: card.id,
                targetColumnId: column.id,
                targetPosition: column.cards.length,
              );
        },

        builder: (context, candidateData, rejectedData) {
          // Highlight the column when a card is being dragged over it
          final isAccepting = candidateData.isNotEmpty;

          return Card(
            color: isAccepting
                ? theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
                : theme.colorScheme.surfaceContainerLow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: isAccepting
                  ? BorderSide(
                      color: theme.colorScheme.primary,
                      width: 2,
                    )
                  : BorderSide.none,
            ),
            child: Column(
              children: [
                // -------------------------------------------------------------
                // Column header
                // -------------------------------------------------------------
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest
                        .withValues(alpha: 0.5),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          column.name,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Card count badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${column.cards.length}',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // -------------------------------------------------------------
                // Card list (scrollable)
                // -------------------------------------------------------------
                Expanded(
                  child: column.cards.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              l10n.noCards,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.outline,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: column.cards.length,
                          itemBuilder: (context, index) {
                            final card = column.cards[index];
                            return DraggableCard(
                              card: card,
                              boardId: boardId,
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
