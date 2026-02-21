// =============================================================================
// Todo Tile Widget — Stateless Display Component
// =============================================================================
// Concepts demonstrated:
// - Displaying freezed model data in a ListTile
// - Callback pattern for parent communication (onTap, onToggle, onDismissed)
// - Dismissible for swipe-to-delete
// - "Dumb" widget pattern — no state management, just rendering
//
// This widget doesn't know about Cubits, repositories, or state management.
// It receives data and callbacks from its parent (TodoListScreen).
// =============================================================================

import 'package:flutter/material.dart';

import '../models/models.dart';

// =============================================================================
// Todo Tile
// =============================================================================

/// A single todo row in the todo list.
///
/// This is a "dumb" widget — it receives data and callbacks from its parent.
/// It doesn't know about the Cubit or repository. This makes it:
/// - Easy to test (just pass in data)
/// - Reusable in different contexts
/// - Simple to reason about
///
/// Compare with a "smart" widget that reads the Cubit directly:
/// ```dart
/// // DON'T DO THIS in a list item
/// class SmartTodoTile extends StatelessWidget {
///   Widget build(BuildContext context) {
///     final cubit = context.read<TodoListCubit>(); // BAD: coupled to Cubit
///     // ...
///   }
/// }
/// ```
class TodoTile extends StatelessWidget {
  /// The todo summary to display.
  final TodoSummary todo;

  /// Called when the tile is tapped (navigate to detail).
  final VoidCallback onTap;

  /// Called when the checkbox is toggled.
  final VoidCallback onToggle;

  /// Called when the tile is swiped to delete.
  final VoidCallback onDismissed;

  const TodoTile({
    super.key,
    required this.todo,
    required this.onTap,
    required this.onToggle,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Dismissible enables swipe-to-delete gesture
    return Dismissible(
      key: ValueKey(todo.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        color: colorScheme.error,
        child: Icon(Icons.delete, color: colorScheme.onError),
      ),
      onDismissed: (_) => onDismissed(),
      child: ListTile(
        // -- Leading: checkbox for completion status --
        leading: Checkbox(
          value: todo.checked,
          onChanged: (_) => onToggle(),
        ),

        // -- Title: todo title with strikethrough if completed --
        title: Text(
          todo.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            // Strikethrough for completed todos
            decoration: todo.checked ? TextDecoration.lineThrough : null,
            color: todo.checked ? Colors.grey : null,
          ),
        ),

        // -- Subtitle: status indicator --
        subtitle: Text(
          todo.checked ? 'Completed' : 'Pending',
          style: TextStyle(
            color: todo.checked ? Colors.green[600] : Colors.orange[600],
            fontSize: 12,
          ),
        ),

        // -- Trailing: chevron for navigation --
        trailing: const Icon(Icons.chevron_right),

        onTap: onTap,
      ),
    );
  }
}

// =============================================================================
// Design Notes
// =============================================================================
//
// Smart vs Dumb Widgets:
// - "Dumb" (presentational) widgets receive data via constructor
// - "Smart" (container) widgets read from Cubits/Blocs via context
// - List items should be dumb — the list screen is the smart parent
// - This separation makes testing and reuse easy
//
// Why Dismissible here?
// - Swipe-to-delete is a presentation concern (gesture → callback)
// - The actual deletion logic lives in the Cubit (called by the callback)
// - The tile doesn't know HOW deletion works, just THAT it was requested
//
// Alternative: confirm before delete
// You could add a confirmDismiss callback to show a dialog:
// ```dart
// confirmDismiss: (direction) async {
//   return showDialog<bool>(
//     context: context,
//     builder: (ctx) => AlertDialog(
//       title: Text('Delete "${todo.title}"?'),
//       actions: [
//         TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text('Cancel')),
//         TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text('Delete')),
//       ],
//     ),
//   );
// },
// ```
// =============================================================================
