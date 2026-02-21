// =============================================================================
// Todo List Screen
// =============================================================================
// Displays a paginated list of todos with pull-to-refresh, swipe-to-delete,
// and FAB to create new todos. Uses BlocBuilder for reactive state rendering.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../l10n/app_localizations.dart';

import '../../core/di/injection_container.dart';
import '../cubits/auth/auth_cubit.dart';
import '../cubits/todo/todo_cubit.dart';
import '../cubits/todo/todo_state.dart';
import '../widgets/todo_tile.dart';
import 'login_screen.dart';
import 'todo_detail_screen.dart';
import 'todo_form_screen.dart';

// ---------------------------------------------------------------------------
// TodoListScreen
// ---------------------------------------------------------------------------

/// Displays the paginated list of todos.
///
/// Features:
/// - Pull-to-refresh
/// - Swipe-to-delete with Dismissible
/// - FAB for creating new todos
/// - Logout in app bar
/// - Pagination controls at the bottom
class TodoListScreen extends StatelessWidget {
  /// Creates a [TodoListScreen].
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      // ---------------------------------------------------------------------------
      // App Bar
      // ---------------------------------------------------------------------------
      appBar: AppBar(
        title: Text(l10n.todos),
        actions: [
          // Logout button
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: l10n.logout,
            onPressed: () => _logout(context),
          ),
        ],
      ),

      // ---------------------------------------------------------------------------
      // Body: Reactive todo list
      // ---------------------------------------------------------------------------
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('Loading...')),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (todos, total, page, pageSize) {
              if (todos.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: 64,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.noTodos,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                );
              }

              // Calculate total pages for pagination
              final totalPages = (total / pageSize).ceil();

              return Column(
                children: [
                  // Todo count header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.todoCount(total),
                          style: theme.textTheme.bodySmall,
                        ),
                        Text(
                          'Page $page of $totalPages',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),

                  // Todo list with pull-to-refresh
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => context.read<TodoCubit>().loadTodos(
                            page: page,
                            pageSize: pageSize,
                          ),
                      child: ListView.separated(
                        itemCount: todos.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final todo = todos[index];
                          return TodoTile(
                            todo: todo,
                            onToggle: () => context
                                .read<TodoCubit>()
                                .toggleTodo(todo.id, todo.checked),
                            onTap: () => _navigateToDetail(context, todo.id),
                            onDismissed: () =>
                                context.read<TodoCubit>().deleteTodo(todo.id),
                          );
                        },
                      ),
                    ),
                  ),

                  // ---------------------------------------------------------------------------
                  // Pagination controls
                  // ---------------------------------------------------------------------------
                  if (totalPages > 1)
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left),
                            onPressed: page > 1
                                ? () => context.read<TodoCubit>().loadTodos(
                                      page: page - 1,
                                      pageSize: pageSize,
                                    )
                                : null,
                          ),
                          Text('$page / $totalPages'),
                          IconButton(
                            icon: const Icon(Icons.chevron_right),
                            onPressed: page < totalPages
                                ? () => context.read<TodoCubit>().loadTodos(
                                      page: page + 1,
                                      pageSize: pageSize,
                                    )
                                : null,
                          ),
                        ],
                      ),
                    ),
                ],
              );
            },
            detail: (_) => const SizedBox.shrink(),
            error: (message) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(message, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => context.read<TodoCubit>().loadTodos(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      // ---------------------------------------------------------------------------
      // FAB: Create new todo
      // ---------------------------------------------------------------------------
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(context),
        tooltip: l10n.addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Navigation helpers
  // ---------------------------------------------------------------------------

  /// Navigates to the todo detail screen.
  void _navigateToDetail(BuildContext context, int todoId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => getIt<TodoCubit>()..loadTodoDetail(todoId),
          child: TodoDetailScreen(todoId: todoId),
        ),
      ),
    );
  }

  /// Navigates to the create todo form.
  void _navigateToForm(BuildContext context) {
    // Pass the existing cubit so creating a todo refreshes this list
    final todoCubit = context.read<TodoCubit>();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: todoCubit,
          child: const TodoFormScreen(),
        ),
      ),
    );
  }

  /// Logs out and navigates back to the login screen.
  void _logout(BuildContext context) {
    context.read<AuthCubit>().logout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => getIt<AuthCubit>(),
          child: const LoginScreen(),
        ),
      ),
      (_) => false, // Remove all routes from the stack
    );
  }

  // Alternative: use GoRouter for declarative navigation
  // void _navigateToDetail(BuildContext context, int todoId) {
  //   context.push('/todos/$todoId');
  // }
}
