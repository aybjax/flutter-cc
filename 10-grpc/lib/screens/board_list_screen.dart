// =============================================================================
// screens/board_list_screen.dart — List of all Kanban boards
// =============================================================================
//
// Shows all available boards in a list. Tapping a board navigates to the
// Kanban board view. Uses BoardListCubit for state management.
//
// This is typically the first screen the user sees. In a multi-board app,
// users can switch between different project boards here.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_tutorial/l10n/app_localizations.dart';
import 'package:grpc_tutorial/cubits/board_cubit.dart';
import 'package:grpc_tutorial/cubits/board_state.dart';
import 'package:grpc_tutorial/screens/board_screen.dart';

// ---------------------------------------------------------------------------
// BoardListScreen
// ---------------------------------------------------------------------------

/// Screen that displays all available Kanban boards.
///
/// Uses [BoardListCubit] to fetch and display boards. Each board is shown
/// as a [ListTile] that navigates to the [BoardScreen] on tap.
class BoardListScreen extends StatefulWidget {
  const BoardListScreen({super.key});

  @override
  State<BoardListScreen> createState() => _BoardListScreenState();
}

class _BoardListScreenState extends State<BoardListScreen> {
  @override
  void initState() {
    super.initState();
    // Load boards when the screen is first shown
    context.read<BoardListCubit>().loadBoards();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.boardListTitle),
      ),
      body: BlocBuilder<BoardListCubit, BoardListState>(
        builder: (context, state) {
          return switch (state) {
            // -----------------------------------------------------------------
            // Initial / Loading state
            // -----------------------------------------------------------------
            BoardListInitial() ||
            BoardListLoading() =>
              const Center(child: CircularProgressIndicator()),

            // -----------------------------------------------------------------
            // Loaded state — show the board list
            // -----------------------------------------------------------------
            BoardListLoaded(:final boards) => boards.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.dashboard_outlined,
                          size: 64,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.noBoards,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () =>
                        context.read<BoardListCubit>().loadBoards(),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: boards.length,
                      itemBuilder: (context, index) {
                        final board = boards[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: const Icon(Icons.dashboard),
                            title: Text(board.name),
                            subtitle: Text(
                              // Show column count as subtitle
                              '${board.columns.length} columns',
                            ),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              // Navigate to the Kanban board view
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => BoardScreen(
                                    boardId: board.id,
                                    boardName: board.name,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),

            // -----------------------------------------------------------------
            // Error state — show error with retry button
            // -----------------------------------------------------------------
            BoardListError(:final failure) => Center(
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
                        l10n.connectionError,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      // Show the specific failure message for debugging
                      Text(
                        failure.toString(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      FilledButton.icon(
                        onPressed: () =>
                            context.read<BoardListCubit>().loadBoards(),
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
    );
  }
}
