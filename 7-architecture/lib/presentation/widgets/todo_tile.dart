// =============================================================================
// Todo Tile Widget
// =============================================================================
// Reusable list tile for displaying a todo item. Extracted into its own
// widget for reusability and to keep the list screen focused on layout.
// =============================================================================

import 'package:flutter/material.dart';

import '../../domain/entities/todo_entity.dart';

// ---------------------------------------------------------------------------
// TodoTile
// ---------------------------------------------------------------------------

/// A single todo item displayed in a list.
///
/// Supports:
/// - Checkbox toggle via [onToggle]
/// - Tap to view details via [onTap]
/// - Swipe to delete via [onDismissed]
///
/// Example:
/// ```dart
/// TodoTile(
///   todo: myTodo,
///   onToggle: (checked) => cubit.toggleTodo(myTodo.id, checked),
///   onTap: () => navigateToDetail(myTodo.id),
///   onDismissed: () => cubit.deleteTodo(myTodo.id),
/// )
/// ```
class TodoTile extends StatelessWidget {
  /// The todo entity to display.
  final TodoEntity todo;

  /// Called when the checkbox is toggled.
  final VoidCallback? onToggle;

  /// Called when the tile is tapped.
  final VoidCallback? onTap;

  /// Called when the tile is swiped away (dismissed).
  final VoidCallback? onDismissed;

  /// Creates a [TodoTile].
  const TodoTile({
    super.key,
    required this.todo,
    this.onToggle,
    this.onTap,
    this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Wrap in Dismissible for swipe-to-delete
    return Dismissible(
      key: ValueKey(todo.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismissed?.call(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: theme.colorScheme.error,
        child: Icon(
          Icons.delete_outline,
          color: theme.colorScheme.onError,
        ),
      ),
      child: ListTile(
        // ---------------------------------------------------------------------------
        // Leading: Checkbox for toggle
        // ---------------------------------------------------------------------------
        leading: Checkbox(
          value: todo.checked,
          onChanged: (_) => onToggle?.call(),
        ),

        // ---------------------------------------------------------------------------
        // Title and subtitle
        // ---------------------------------------------------------------------------
        title: Text(
          todo.title,
          style: TextStyle(
            // Strike through completed todos
            decoration: todo.checked ? TextDecoration.lineThrough : null,
            color: todo.checked
                ? theme.colorScheme.onSurface.withValues(alpha: 0.5)
                : null,
          ),
        ),
        subtitle: todo.description.isNotEmpty
            ? Text(
                todo.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : null,

        // ---------------------------------------------------------------------------
        // Trailing: chevron for navigation
        // ---------------------------------------------------------------------------
        trailing: const Icon(Icons.chevron_right),

        onTap: onTap,
      ),
    );
  }

  // Alternative: use a Card-based layout instead of ListTile
  // Widget _buildCardVariant(BuildContext context) {
  //   return Card(
  //     child: Padding(
  //       padding: const EdgeInsets.all(12),
  //       child: Row(
  //         children: [
  //           Checkbox(value: todo.checked, onChanged: (_) => onToggle?.call()),
  //           Expanded(child: Text(todo.title)),
  //           IconButton(icon: Icon(Icons.delete), onPressed: onDismissed),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
