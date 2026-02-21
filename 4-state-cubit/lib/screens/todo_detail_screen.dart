// =============================================================================
// Todo Detail Screen — BlocBuilder for Single Item
// =============================================================================
// Concepts demonstrated:
// - BlocProvider.value vs BlocProvider(create:) — when to use each
// - BlocBuilder for rendering a single item's state
// - BlocListener for reacting to save/error events
// - Navigating with cubit data (pass todoId, cubit loads the data)
//
// Flow:
// 1. Screen receives todoId from navigation
// 2. Creates TodoDetailCubit and calls loadTodo(todoId)
// 3. BlocBuilder renders: Loading → Loaded (show detail) / Error
// 4. User can toggle checked, edit, or delete
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/todo/todo_detail_cubit.dart';
import '../cubits/todo/todo_detail_state.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/models.dart';
import '../repositories/todo_repository.dart';
import 'todo_form_screen.dart';

// =============================================================================
// Todo Detail Screen
// =============================================================================

/// Displays a single todo's full details.
///
/// Creates its own [TodoDetailCubit] to manage the loading state.
/// The cubit is created in [BlocProvider] with `..loadTodo(todoId)`
/// to immediately start loading.
class TodoDetailScreen extends StatelessWidget {
  /// The ID of the todo to display.
  final int todoId;

  /// The todo repository (passed from parent for cubit creation).
  final TodoRepository todoRepository;

  const TodoDetailScreen({
    super.key,
    required this.todoId,
    required this.todoRepository,
  });

  @override
  Widget build(BuildContext context) {
    // =========================================================================
    // BlocProvider — creates and provides the Cubit
    // =========================================================================
    // BlocProvider(create: ...) creates a NEW cubit and provides it to children.
    // The `..loadTodo(todoId)` cascade immediately triggers data loading.
    //
    // BlocProvider automatically calls close() when this widget is disposed,
    // so the cubit is cleaned up when navigating away.
    //
    // Alternative: BlocProvider.value(value: existingCubit)
    // Use this when the cubit already exists and you want to share it.
    // DON'T use BlocProvider.value for creating — it won't auto-close.
    return BlocProvider(
      create: (_) => TodoDetailCubit(
        todoRepository: todoRepository,
      )..loadTodo(todoId),
      child: _TodoDetailView(todoRepository: todoRepository),
    );
  }
}

/// The inner view widget that has access to the TodoDetailCubit.
///
/// We split this into a separate widget so BlocBuilder can find the
/// cubit that was just provided above.
class _TodoDetailView extends StatelessWidget {
  final TodoRepository todoRepository;

  const _TodoDetailView({required this.todoRepository});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.todoDetail)),
      body: BlocBuilder<TodoDetailCubit, TodoDetailState>(
        builder: (context, state) {
          return state.when(
            // -- Initial: shouldn't happen (we call loadTodo immediately) --
            initial: () => const SizedBox.shrink(),

            // -- Loading: spinner --
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),

            // -- Loaded: show todo details --
            loaded: (todo) => _buildDetail(context, todo, l10n),

            // -- Saved: show spinner (transient state) --
            saved: (todo) => _buildDetail(context, todo, l10n),

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
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () =>
                        context.read<TodoDetailCubit>().loadTodo(
                              // Re-read todoId from the parent widget
                              context
                                  .findAncestorWidgetOfExactType<
                                      TodoDetailScreen>()!
                                  .todoId,
                            ),
                    icon: const Icon(Icons.refresh),
                    label: Text(l10n.retry),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Detail View
  // ---------------------------------------------------------------------------

  Widget _buildDetail(
    BuildContext context,
    TodoDetail todo,
    AppLocalizations l10n,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -- Title --
          Text(
            todo.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  decoration:
                      todo.checked ? TextDecoration.lineThrough : null,
                ),
          ),
          const SizedBox(height: 16),

          // -- Status chip --
          Chip(
            avatar: Icon(
              todo.checked ? Icons.check_circle : Icons.radio_button_unchecked,
              color: todo.checked ? Colors.green : Colors.orange,
            ),
            label: Text(todo.checked ? l10n.checked : l10n.unchecked),
          ),
          const SizedBox(height: 24),

          // -- Description --
          if (todo.description.isNotEmpty) ...[
            Text(
              l10n.description,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              todo.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
          ],

          // -- Action buttons --
          Row(
            children: [
              // Toggle checked
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () =>
                      context.read<TodoDetailCubit>().toggleChecked(),
                  icon: Icon(
                    todo.checked ? Icons.undo : Icons.check,
                  ),
                  label: Text(
                    todo.checked ? 'Mark Pending' : 'Mark Done',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Edit
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _navigateToEdit(context, todo),
                  icon: const Icon(Icons.edit),
                  label: Text(l10n.editTodo),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Delete button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _confirmDelete(context, todo, l10n),
              icon: Icon(Icons.delete, color: colorScheme.error),
              label: Text(
                l10n.deleteTodo,
                style: TextStyle(color: colorScheme.error),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Actions
  // ---------------------------------------------------------------------------

  void _navigateToEdit(BuildContext context, TodoDetail todo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TodoFormScreen(
          todoRepository: todoRepository,
          existingTodo: todo,
        ),
      ),
    ).then((_) {
      if (context.mounted) {
        // Reload the detail after editing
        context.read<TodoDetailCubit>().loadTodo(todo.id);
      }
    });
  }

  void _confirmDelete(
    BuildContext context,
    TodoDetail todo,
    AppLocalizations l10n,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteTodo),
        content: Text(l10n.confirmDelete(todo.title)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final todoRepo = context.read<TodoRepository>();
              await todoRepo.deleteTodo(todo.id);
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            child: Text(l10n.deleteTodo),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

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
