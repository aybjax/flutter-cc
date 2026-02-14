// =============================================================================
// Todo Detail Screen
// =============================================================================
// Concepts demonstrated:
// - Hero animation — completing the shared-element transition from list/grid
// - SafeArea — respecting system UI insets
// - AlertDialog for delete confirmation
// - Navigator.pop with result — returning data to the previous screen
// - Conditional UI based on loading state
// - Image.network with full-size image
// - Multiple button types in context (Elevated, Text, Outlined)
// - MediaQuery for responsive layout
// =============================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/api_constants.dart';
import '../../config/route_names.dart';
import '../../providers/auth_provider.dart';
import '../../providers/todo_provider.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/error_dialog.dart';

/// Displays the full detail of a single todo item.
///
/// Receives the todo id via [Navigator.pushNamed] arguments.
/// Fetches the full detail from the API and displays it with a
/// Hero image transition.
class TodoDetailScreen extends StatefulWidget {
  /// The ID of the todo to display.
  final int todoId;

  /// Creates the todo detail screen.
  const TodoDetailScreen({super.key, required this.todoId});

  @override
  State<TodoDetailScreen> createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch the todo detail when the screen opens.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchDetail();
    });
  }

  /// Fetches the full todo detail from the API.
  void _fetchDetail() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    if (authProvider.token != null) {
      todoProvider.fetchTodoDetail(authProvider.token!, widget.todoId);
    }
  }

  /// Shows a confirmation dialog and deletes the todo if confirmed.
  Future<void> _confirmDelete() async {
    final confirmed = await ErrorDialog.showConfirmation(
      context,
      title: 'Delete Todo',
      message: 'Are you sure you want to delete this todo? This cannot be undone.',
      confirmLabel: 'Delete',
      cancelLabel: 'Cancel',
    );

    if (!confirmed || !mounted) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);

    if (authProvider.token != null) {
      final success = await todoProvider.deleteTodo(
        authProvider.token!,
        widget.todoId,
      );

      if (!mounted) return;

      if (success) {
        CustomSnackBar.showSuccess(context, message: 'Todo deleted');
        // Pop with a result of true to indicate the todo was deleted.
        // The previous screen can use this to refresh its list.
        Navigator.pop(context, true);
      } else {
        CustomSnackBar.showError(
          context,
          message: todoProvider.errorMessage ?? 'Failed to delete',
        );
      }
    }
  }

  /// Navigates to the edit form screen.
  void _navigateToEdit() {
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    Navigator.pushNamed(
      context,
      RouteNames.todoForm,
      arguments: todoProvider.selectedTodo,
    ).then((result) {
      // If the form returned true (saved), refresh the detail.
      if (result == true) {
        _fetchDetail();
      }
    });
  }

  /// Toggles the checked state.
  Future<void> _toggleChecked() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    final todo = todoProvider.selectedTodo;

    if (authProvider.token != null && todo != null) {
      await todoProvider.updateTodo(
        authProvider.token!,
        todo.id,
        checked: !todo.checked,
      );
      if (mounted) {
        _fetchDetail(); // Refresh to show updated state
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        final todo = todoProvider.selectedTodo;

        return Scaffold(
          appBar: AppBar(
            title: Text(todo?.title ?? 'Todo Detail'),
            actions: [
              // Edit button
              IconButton(
                icon: const Icon(Icons.edit),
                tooltip: 'Edit',
                onPressed: todo != null ? _navigateToEdit : null,
              ),
              // Delete button
              IconButton(
                icon: const Icon(Icons.delete),
                tooltip: 'Delete',
                onPressed: todo != null ? _confirmDelete : null,
              ),
            ],
          ),
          body: todoProvider.isLoadingDetail
              ? const Center(child: CircularProgressIndicator())
              : todo == null
                  ? Center(
                      child: Text(
                        todoProvider.errorMessage ?? 'Todo not found',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                  : SafeArea(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // -- Hero image --
                            if (todo.hasImage)
                              Center(
                                child: Hero(
                                  tag: 'todo_image_${todo.id}',
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      '${ApiConstants.baseUrl}${todo.image}',
                                      height: 250,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          height: 250,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surfaceContainerHighest,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              Icons.broken_image,
                                              size: 64,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),

                            const SizedBox(height: 24),

                            // -- Title --
                            Text(
                              todo.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    decoration: todo.checked
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                            ),
                            const SizedBox(height: 8),

                            // -- Status chip --
                            Chip(
                              avatar: Icon(
                                todo.checked
                                    ? Icons.check_circle
                                    : Icons.circle_outlined,
                                size: 18,
                                color: todo.checked
                                    ? Colors.green
                                    : Theme.of(context).colorScheme.outline,
                              ),
                              label: Text(
                                todo.checked ? 'Completed' : 'Pending',
                              ),
                              // backgroundColor: ...,
                              // side: ...,
                              // shape: ...,
                              // padding: ...,
                              // labelPadding: ...,
                              // labelStyle: ...,
                              // deleteIcon: ...,
                              // onDeleted: ...,
                            ),
                            const SizedBox(height: 16),

                            // -- Description --
                            if (todo.description.isNotEmpty) ...[
                              Text(
                                'Description',
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
                                // Toggle checked button
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: _toggleChecked,
                                    icon: Icon(
                                      todo.checked
                                          ? Icons.undo
                                          : Icons.check,
                                    ),
                                    label: Text(
                                      todo.checked
                                          ? 'Mark Pending'
                                          : 'Mark Done',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Edit button
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: _navigateToEdit,
                                    icon: const Icon(Icons.edit),
                                    label: const Text('Edit'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
        );
      },
    );
  }
}
