// =============================================================================
// Todo Grid Item Widget
// =============================================================================
// Concepts demonstrated:
// - Card — a Material surface with elevation and rounded corners
// - GridTile — a tile designed for GridView with header/footer overlays
// - Card fields: elevation, shape, margin, clipBehavior, color, shadowColor
// - Image.network with loading/error builders
// - Hero animation on grid images
// - InkWell for tap feedback on cards
// =============================================================================

import 'package:flutter/material.dart';

import '../config/api_constants.dart';
import '../models/todo_summary.dart';

/// A single cell in the todo grid, built with [Card] and [GridTile].
///
/// Shows a thumbnail image (or placeholder), title overlay, and
/// a checked indicator.
class TodoGridItem extends StatelessWidget {
  /// The todo data to display.
  final TodoSummary todo;

  /// Called when the card is tapped.
  final VoidCallback? onTap;

  /// Called when the checkbox is toggled.
  final ValueChanged<bool>? onToggle;

  /// Creates a [TodoGridItem].
  const TodoGridItem({
    super.key,
    required this.todo,
    this.onTap,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // -- Card fields --
      elevation: 2, // Shadow depth (how "raised" the card looks)
      shadowColor: Colors.black38, // Color of the shadow
      // surfaceTintColor: Colors.transparent, // Remove M3 tint overlay
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
        // side: BorderSide(color: ..., width: 1), // Optional border
      ),
      margin: const EdgeInsets.all(4), // Space around the card
      clipBehavior: Clip.antiAlias, // Clip children to card shape
      // color: Theme.of(context).colorScheme.surface, // Background color
      // borderOnForeground: true,    // Draw border in front of children
      // semanticContainer: true,     // Treat as single semantic node

      child: InkWell(
        onTap: onTap,
        child: GridTile(
          // -- GridTile fields --
          // header: widget overlaid at the top of the tile.
          // footer: widget overlaid at the bottom of the tile.
          // child: the main content (fills the tile).

          // Footer overlay with the todo title.
          footer: GridTileBar(
            // backgroundColor creates a semi-transparent overlay
            // so the text is readable over the image.
            backgroundColor: Colors.black54,
            title: Text(
              todo.title,
              overflow: TextOverflow.ellipsis, // Truncate long titles
            ),
            // trailing: widget on the right side of the bar.
            trailing: GestureDetector(
              onTap: () => onToggle?.call(!todo.checked),
              child: Icon(
                todo.checked
                    ? Icons.check_circle
                    : Icons.check_circle_outline,
                color: todo.checked ? Colors.greenAccent : Colors.white70,
              ),
            ),
            // leading: ...,               // Widget on the left side
            // subtitle: ...,              // Second line of text
          ),

          // Main content — image or placeholder.
          child: _buildImage(context),
        ),
      ),
    );
  }

  /// Builds the main image for the grid tile.
  Widget _buildImage(BuildContext context) {
    if (todo.hasThumbnail) {
      return Hero(
        tag: 'todo_image_${todo.id}',
        child: Image.network(
          '${ApiConstants.baseUrl}${todo.thumbnail}',
          fit: BoxFit.cover, // Cover the entire tile
          // Image.network fields:
          // width: ...,                // Explicit width
          // height: ...,               // Explicit height
          // scale: 1.0,                // Image scale factor
          // color: ...,                // Color to blend with image
          // colorBlendMode: ...,       // How to blend color
          // fit: BoxFit.cover,         // How to fit within bounds
          // alignment: Alignment.center, // Alignment within bounds
          // repeat: ImageRepeat.noRepeat, // Tile the image
          // filterQuality: FilterQuality.low, // Rendering quality
          // headers: {},               // HTTP headers for the request
          // cacheWidth: ...,           // Resize cache width
          // cacheHeight: ...,          // Resize cache height

          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: const Center(child: Icon(Icons.broken_image, size: 48)),
            );
          },
        ),
      );
    }

    // No image — show a colored placeholder.
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Center(
        child: Text(
          todo.title.isNotEmpty ? todo.title[0].toUpperCase() : '?',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
      ),
    );
  }
}
