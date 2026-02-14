// =============================================================================
// Todo List Item Widget
// =============================================================================
// Concepts demonstrated:
// - ListTile — the standard Material list row widget (all fields documented)
// - Leading, title, subtitle, trailing slots
// - Hero animation setup on thumbnails
// - Image.network for loading remote images
// - Checkbox for toggling completion
// - Callback pattern (onTap, onToggle) for parent communication
// =============================================================================

import 'package:flutter/material.dart';

import '../config/api_constants.dart';
import '../models/todo_summary.dart';

/// A single row in the todo list, built with [ListTile].
///
/// Displays the todo title, a checkbox, and an optional thumbnail.
/// Tapping the row navigates to the detail screen; tapping the checkbox
/// toggles the checked state.
class TodoListItem extends StatelessWidget {
  /// The todo data to display.
  final TodoSummary todo;

  /// Called when the entire row is tapped (navigate to detail).
  final VoidCallback? onTap;

  /// Called when the checkbox is toggled.
  final ValueChanged<bool>? onToggle;

  /// Creates a [TodoListItem].
  const TodoListItem({
    super.key,
    required this.todo,
    this.onTap,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // -- ListTile fields --

      // leading: widget displayed before the title (left side).
      // Here we show a thumbnail or a placeholder icon.
      leading: _buildLeading(context),

      // title: the primary text content.
      title: Text(
        todo.title,
        style: TextStyle(
          // Strikethrough text when the todo is completed.
          decoration: todo.checked ? TextDecoration.lineThrough : null,
          color: todo.checked
              ? Theme.of(context).colorScheme.onSurfaceVariant
              : null,
        ),
      ),

      // subtitle: secondary text below the title.
      subtitle: Text(
        todo.checked ? 'Completed' : 'Pending',
        style: Theme.of(context).textTheme.bodySmall,
      ),

      // trailing: widget displayed after the title (right side).
      trailing: Checkbox(
        value: todo.checked,
        onChanged: (value) {
          if (value != null) {
            onToggle?.call(value);
          }
        },
      ),

      // onTap: called when the ListTile is tapped.
      onTap: onTap,

      // -- Additional ListTile fields (commented for reference) --
      // onLongPress: () {},           // Long-press callback
      // selected: false,              // Highlights the tile
      // selectedColor: ...,           // Text/icon color when selected
      // selectedTileColor: ...,       // Background when selected
      // tileColor: ...,               // Background color
      // iconColor: ...,               // Default icon color
      // textColor: ...,               // Default text color
      // contentPadding: ...,          // Override theme padding
      // dense: false,                 // Compact mode
      // visualDensity: ...,           // Fine-grained density
      // shape: ...,                   // Tile shape (from theme)
      // enabled: true,                // Whether tappable
      // isThreeLine: false,           // Allow 3 lines of text
      // minLeadingWidth: 40,          // Minimum leading widget width
      // minVerticalPadding: 4,        // Minimum vertical padding
      // enableFeedback: true,         // Haptic/sound on tap
      // horizontalTitleGap: 16,       // Gap between leading and title
      // minTileHeight: ...,           // Minimum height
      // leadingAndTrailingTextStyle: ..., // Style for leading/trailing text
      // titleTextStyle: ...,          // Override title text style
      // subtitleTextStyle: ...,       // Override subtitle text style
    );
  }

  /// Builds the leading widget (thumbnail or placeholder).
  Widget _buildLeading(BuildContext context) {
    if (todo.hasThumbnail) {
      // Hero wraps the thumbnail for shared-element transition.
      // The same tag must be used on the detail screen.
      return Hero(
        tag: 'todo_image_${todo.id}',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            // Prepend base URL since the backend returns relative paths.
            '${ApiConstants.baseUrl}${todo.thumbnail}',
            width: 48,
            height: 48,
            fit: BoxFit.cover,
            // Show a placeholder while loading.
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const SizedBox(
                width: 48,
                height: 48,
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              );
            },
            // Show an error icon if the image fails to load.
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 48,
                height: 48,
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: const Icon(Icons.broken_image, size: 24),
              );
            },
          ),
        ),
      );
    }

    // No thumbnail — show a colored circle with the first letter.
    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: Text(
        todo.title.isNotEmpty ? todo.title[0].toUpperCase() : '?',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
