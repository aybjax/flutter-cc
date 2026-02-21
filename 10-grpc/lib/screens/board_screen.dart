// =============================================================================
// screens/board_screen.dart — Kanban board view with columns and cards
// =============================================================================
//
// Displays a single Kanban board with horizontally scrollable columns.
// Each column shows its cards vertically. Cards can be dragged between
// columns using DragTarget/Draggable widgets.
//
// Features:
//   - Horizontal scrolling through columns
//   - Drag-and-drop card movement
//   - Real-time updates via WatchBoard streaming RPC
//   - FAB to create new cards
//   - Live indicator when watching is active
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_tutorial/l10n/app_localizations.dart';
import 'package:grpc_tutorial/cubits/board_cubit.dart';
import 'package:grpc_tutorial/cubits/board_state.dart';
import 'package:grpc_tutorial/repositories/board_repository.dart';
import 'package:grpc_tutorial/screens/card_form_screen.dart';
import 'package:grpc_tutorial/widgets/kanban_column.dart';

// ---------------------------------------------------------------------------
// BoardScreen
// ---------------------------------------------------------------------------

/// Screen that displays a Kanban board with columns and cards.
///
/// Creates its own [BoardDetailCubit] scoped to this screen's lifecycle.
/// The cubit loads the board on init and optionally starts watching for
/// real-time updates.
class BoardScreen extends StatelessWidget {
  /// The ID of the board to display.
  final String boardId;

  /// The name of the board (used in the app bar title).
  final String boardName;

  const BoardScreen({
    super.key,
    required this.boardId,
    required this.boardName,
  });

  @override
  Widget build(BuildContext context) {
    // Create a scoped BoardDetailCubit for this screen
    return BlocProvider(
      create: (context) => BoardDetailCubit(
        context.read<BoardRepository>(),
        boardId: boardId,
      )..loadBoard(),
      child: _BoardScreenContent(boardName: boardName),
    );
  }
}

// ---------------------------------------------------------------------------
// _BoardScreenContent — the actual board UI
// ---------------------------------------------------------------------------

class _BoardScreenContent extends StatelessWidget {
  final String boardName;

  const _BoardScreenContent({required this.boardName});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(boardName),
        actions: [
          // Live/watching indicator toggle
          BlocBuilder<BoardDetailCubit, BoardDetailState>(
            builder: (context, state) {
              final isWatching =
                  state is BoardDetailLoaded && state.isWatching;

              return IconButton(
                // Toggle watching on/off
                onPressed: () {
                  final cubit = context.read<BoardDetailCubit>();
                  if (isWatching) {
                    cubit.stopWatching();
                  } else {
                    cubit.startWatching();
                  }
                },
                icon: Icon(
                  isWatching ? Icons.wifi : Icons.wifi_off,
                  color: isWatching ? Colors.green : null,
                ),
                tooltip: isWatching ? l10n.watching : 'Start watching',
              );
            },
          ),

          // Refresh button
          IconButton(
            onPressed: () => context.read<BoardDetailCubit>().loadBoard(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),

      // -----------------------------------------------------------------------
      // Body — board content based on state
      // -----------------------------------------------------------------------
      body: BlocConsumer<BoardDetailCubit, BoardDetailState>(
        // Show snackbar on state changes (for card operations feedback)
        listener: (context, state) {
          // Could show snackbar for specific transitions here
          // For example, when a card operation completes:
          // if (state is BoardDetailLoaded && previousState is BoardDetailLoading) {
          //   ScaffoldMessenger.of(context).showSnackBar(...);
          // }
        },
        builder: (context, state) {
          return switch (state) {
            // -----------------------------------------------------------------
            // Initial / Loading
            // -----------------------------------------------------------------
            BoardDetailInitial() ||
            BoardDetailLoading() =>
              const Center(child: CircularProgressIndicator()),

            // -----------------------------------------------------------------
            // Loaded — show the Kanban board
            // -----------------------------------------------------------------
            BoardDetailLoaded(:final board, :final isWatching) =>
              Column(
                children: [
                  // Live indicator bar
                  if (isWatching)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      color: Colors.green.withValues(alpha: 0.1),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.circle,
                            size: 8,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.watching,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.green,
                                    ),
                          ),
                        ],
                      ),
                    ),

                  // Kanban columns — horizontally scrollable
                  Expanded(
                    child: board.columns.isEmpty
                        ? Center(child: Text(l10n.noCards))
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(12),
                            itemCount: board.columns.length,
                            itemBuilder: (context, index) {
                              final column = board.columns[index];
                              return KanbanColumn(
                                column: column,
                                boardId: board.id,
                              );
                            },
                          ),
                  ),
                ],
              ),

            // -----------------------------------------------------------------
            // Error
            // -----------------------------------------------------------------
            BoardDetailError(:final failure) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.errorLoading,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        failure.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      FilledButton.icon(
                        onPressed: () =>
                            context.read<BoardDetailCubit>().loadBoard(),
                        icon: const Icon(Icons.refresh),
                        label: Text(l10n.retry),
                      ),
                    ],
                  ),
                ),
              ),
          };
        },
      ),

      // -----------------------------------------------------------------------
      // FAB — create new card
      // -----------------------------------------------------------------------
      floatingActionButton: BlocBuilder<BoardDetailCubit, BoardDetailState>(
        builder: (context, state) {
          if (state is! BoardDetailLoaded) return const SizedBox.shrink();

          return FloatingActionButton.extended(
            onPressed: () => _showCreateCardDialog(context, state),
            icon: const Icon(Icons.add),
            label: Text(l10n.createCard),
          );
        },
      ),
    );
  }

  /// Opens the card creation form as a modal bottom sheet.
  void _showCreateCardDialog(
    BuildContext context,
    BoardDetailLoaded state,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CardFormScreen(
          boardId: state.board.id,
          columns: state.board.columns,
          onSave: (columnId, title, description) {
            context.read<BoardDetailCubit>().createCard(
                  columnId: columnId,
                  title: title,
                  description: description,
                );
          },
        ),
      ),
    );
  }
}
