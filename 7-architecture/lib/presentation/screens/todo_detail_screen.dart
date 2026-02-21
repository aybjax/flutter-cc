// =============================================================================
// Todo Detail Screen
// =============================================================================
// Shows full details of a single todo with options to edit or delete.
// Uses BlocBuilder to reactively display the todo data.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../l10n/app_localizations.dart';

import '../../core/di/injection_container.dart';
import '../cubits/todo/todo_cubit.dart';
import '../cubits/todo/todo_state.dart';
import 'todo_form_screen.dart';

// ---------------------------------------------------------------------------
// TodoDetailScreen
// ---------------------------------------------------------------------------

/// Displays full details of a single todo.
///
/// Features:
/// - Title, description, checked status
/// - Edit button to navigate to the form
/// - Delete button with confirmation dialog
class TodoDetailScreen extends StatelessWidget {
  /// The ID of the todo to display.
  final int todoId;

  /// Creates a [TodoDetailScreen].
  const TodoDetailScreen({
    super.key,
    required this.todoId,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.todos),
        actions: [
          // Edit button
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: l10n.editTodo,
            onPressed: () => _navigateToEdit(context),
          ),
          // Delete button
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: l10n.delete,
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (_, __, ___, ____) => const SizedBox.shrink(),
            detail: (todo) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ---------------------------------------------------------------------------
                    // Status chip
                    // ---------------------------------------------------------------------------
                    Chip(
                      avatar: Icon(
                        todo.checked
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        size: 18,
                      ),
                      label: Text(todo.checked ? 'Completed' : 'Pending'),
                      backgroundColor: todo.checked
                          ? Colors.green.withValues(alpha: 0.15)
                          : Colors.orange.withValues(alpha: 0.15),
                    ),
                    const SizedBox(height: 16),

                    // ---------------------------------------------------------------------------
                    // Title
                    // ---------------------------------------------------------------------------
                    Text(
                      todo.title,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        decoration:
                            todo.checked ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ---------------------------------------------------------------------------
                    // Description
                    // ---------------------------------------------------------------------------
                    if (todo.description.isNotEmpty) ...[
                      Text(
                        l10n.description,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        todo.description,
                        style: theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 24),
                    ],

                    // ---------------------------------------------------------------------------
                    // Metadata
                    // ---------------------------------------------------------------------------
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _metadataRow('ID', '${todo.id}'),
                            const Divider(),
                            _metadataRow('User ID', '${todo.userId}'),
                            if (todo.image != null) ...[
                              const Divider(),
                              _metadataRow('Image', todo.image!),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            error: (message) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline,
                      size: 64, color: theme.colorScheme.error),
                  const SizedBox(height: 16),
                  Text(message),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () =>
                        context.read<TodoCubit>().loadTodoDetail(todoId),
                    child: const Text('Retry'),
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
  // Helpers
  // ---------------------------------------------------------------------------

  /// Builds a row of label: value metadata.
  Widget _metadataRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        Text(value),
      ],
    );
  }

  /// Navigates to the edit form pre-populated with the current todo data.
  void _navigateToEdit(BuildContext context) {
    final cubit = context.read<TodoCubit>();
    final state = cubit.state;

    // Extract the current todo from the detail state
    state.whenOrNull(
      detail: (todo) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => getIt<TodoCubit>(),
              child: TodoFormScreen(
                todoId: todo.id,
                initialTitle: todo.title,
                initialDescription: todo.description,
              ),
            ),
          ),
        );
      },
    );
  }

  /// Shows a confirmation dialog before deleting.
  void _confirmDelete(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.delete),
        content: Text(l10n.confirmDelete),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext); // Close dialog
              context.read<TodoCubit>().deleteTodo(todoId);
              Navigator.pop(context); // Go back to list
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }
}
