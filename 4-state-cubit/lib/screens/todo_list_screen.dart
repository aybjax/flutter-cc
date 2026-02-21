// =============================================================================
// Todo List Screen — BlocBuilder for State Rendering
// =============================================================================
// Concepts demonstrated:
// - BlocBuilder for rendering the 4-state pattern (initial, loading, loaded, error)
// - context.read<Cubit>() for calling cubit methods from event handlers
// - MultiBlocProvider — providing multiple cubits to the widget tree
// - Swipe-to-delete with confirmation
// - Pull-to-refresh integration with Cubit
// - BlocListener for reacting to auth state changes (logout → login screen)
//
// This screen is the "smart" parent widget that:
// 1. Uses BlocBuilder to render based on TodoListState
// 2. Creates TodoTile "dumb" widgets with callbacks
// 3. Navigates to detail/form screens
// 4. Coordinates cubit calls (delete → refresh)
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/auth/auth_cubit.dart';
import '../cubits/todo/todo_list_cubit.dart';
import '../cubits/todo/todo_list_state.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/models.dart';
import '../repositories/todo_repository.dart';
import '../widgets/todo_tile.dart';
import 'todo_detail_screen.dart';
import 'todo_form_screen.dart';

// =============================================================================
// Todo List Screen
// =============================================================================

/// The main screen showing a paginated list of todos.
///
/// Uses [BlocBuilder<TodoListCubit, TodoListState>] to render one of:
/// - Initial: "Pull to refresh" message
/// - Loading: centered spinner
/// - Loaded: list of TodoTile widgets
/// - Error: error message with retry button
///
/// This screen demonstrates the full Cubit lifecycle:
/// 1. TodoListCubit is created with `..loadTodos()` (loads on creation)
/// 2. BlocBuilder rebuilds when the cubit emits new states
/// 3. User interactions call cubit methods (delete, refresh)
/// 4. Navigation creates new cubits for detail/form screens
class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          // -- Settings (language switcher) --
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: l10n.settings,
            onPressed: () => _showSettingsDialog(context, l10n),
          ),
          // -- Logout button --
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: l10n.logout,
            onPressed: () => context.read<AuthCubit>().logout(),
          ),
        ],
      ),

      // =====================================================================
      // BlocBuilder — renders UI based on state
      // =====================================================================
      // BlocBuilder<CubitType, StateType> subscribes to the cubit's stream
      // and calls builder() whenever a new state is emitted.
      //
      // The builder receives the current BuildContext and the current state.
      // Use state.when() for exhaustive pattern matching.
      body: BlocBuilder<TodoListCubit, TodoListState>(
        builder: (context, state) {
          return state.when(
            // -- Initial: no data loaded yet --
            initial: () => Center(
              child: Text(
                l10n.noTodosYet,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ),

            // -- Loading: show spinner --
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),

            // -- Loaded: show the todo list --
            loaded: (todos, total, page, pageSize) {
              if (todos.isEmpty) {
                return Center(
                  child: Text(
                    l10n.noTodosYet,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () =>
                    context.read<TodoListCubit>().refreshTodos(),
                child: Column(
                  children: [
                    // -- Todo count --
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          l10n.todosCount(total),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),

                    // -- Todo list --
                    Expanded(
                      child: ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (context, index) {
                          final todo = todos[index];
                          return TodoTile(
                            todo: todo,
                            onTap: () => _navigateToDetail(context, todo.id),
                            onToggle: () => _toggleTodo(context, todo),
                            onDismissed: () => _deleteTodo(context, todo),
                          );
                        },
                      ),
                    ),

                    // -- Pagination controls --
                    if (total > pageSize)
                      _buildPaginationControls(
                          context, page, pageSize, total),
                  ],
                ),
              );
            },

            // -- Error: show error with retry --
            error: (failure) => Center(
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
                    _failureMessage(failure, l10n),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () =>
                        context.read<TodoListCubit>().refreshTodos(),
                    icon: const Icon(Icons.refresh),
                    label: Text(l10n.retry),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      // -- FAB to add new todo --
      floatingActionButton: FloatingActionButton(
        tooltip: l10n.addTodo,
        onPressed: () => _navigateToForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Pagination Controls
  // ---------------------------------------------------------------------------

  Widget _buildPaginationControls(
    BuildContext context,
    int page,
    int pageSize,
    int total,
  ) {
    final totalPages = (total / pageSize).ceil();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: page > 1
                ? () => context.read<TodoListCubit>().loadPage(page - 1)
                : null,
          ),
          Text('$page / $totalPages'),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: page < totalPages
                ? () => context.read<TodoListCubit>().loadPage(page + 1)
                : null,
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Actions
  // ---------------------------------------------------------------------------

  /// Toggles a todo's checked status via a quick PATCH call.
  void _toggleTodo(BuildContext context, TodoSummary todo) async {
    final todoRepo = context.read<TodoRepository>();
    await todoRepo.updateTodo(id: todo.id, checked: !todo.checked);
    if (context.mounted) {
      context.read<TodoListCubit>().refreshTodos();
    }
  }

  /// Deletes a todo and refreshes the list.
  void _deleteTodo(BuildContext context, TodoSummary todo) {
    context.read<TodoListCubit>().deleteTodo(todo.id);

    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.todoDeleted)),
    );
  }

  /// Navigates to the todo detail screen.
  void _navigateToDetail(BuildContext context, int todoId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TodoDetailScreen(
          todoId: todoId,
          todoRepository: context.read<TodoRepository>(),
        ),
      ),
    ).then((_) {
      // Refresh the list when returning from detail screen
      if (context.mounted) {
        context.read<TodoListCubit>().refreshTodos();
      }
    });
  }

  /// Navigates to the todo form screen for creating a new todo.
  void _navigateToForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TodoFormScreen(
          todoRepository: context.read<TodoRepository>(),
        ),
      ),
    ).then((_) {
      // Refresh the list when returning from form screen
      if (context.mounted) {
        context.read<TodoListCubit>().refreshTodos();
      }
    });
  }

  // ---------------------------------------------------------------------------
  // Settings Dialog (Language Switcher)
  // ---------------------------------------------------------------------------

  void _showSettingsDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.settings),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(l10n.language),
              subtitle: const Text('Change app language'),
            ),
            ListTile(
              leading: const Text('EN'),
              title: const Text('English'),
              onTap: () {
                _changeLocale(context, const Locale('en'));
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              leading: const Text('ES'),
              title: const Text('Espanol'),
              onTap: () {
                _changeLocale(context, const Locale('es'));
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _changeLocale(BuildContext context, Locale locale) {
    final state = context.findAncestorStateOfType<AppLocaleStateMixin>();
    state?.setLocale(locale);
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Converts a [TodoFailure] to a user-friendly message.
  String _failureMessage(TodoFailure failure, AppLocalizations l10n) {
    return failure.when(
      network: (msg) => l10n.errorNetwork,
      server: (msg, _) => msg,
      unauthorized: () => l10n.errorUnauthorized,
      notFound: (id) => 'Todo #$id not found',
      validation: (field, msg) => msg,
      unexpected: (error) => l10n.errorServer,
    );
  }
}

// =============================================================================
// App Locale State (referenced from main.dart)
// =============================================================================

/// Mixin that main.dart's state implements to allow locale changes.
mixin AppLocaleStateMixin<T extends StatefulWidget> on State<T> {
  void setLocale(Locale locale);
}
