// =============================================================================
// Category Tile Widget
// =============================================================================
// Concepts demonstrated:
// - Reusable ListTile wrapper for category display
// - Using enum metadata (icon, label) from NewsCategory
// - Badge-style article count display
// - Composition pattern — accepts category + callback
// =============================================================================

import 'package:flutter/material.dart';

import '../models/models.dart';

// -----------------------------------------------------------------------------
// Category Tile Widget
// -----------------------------------------------------------------------------

/// A list tile displaying a news category with its icon and article count.
///
/// Used in the [CategoryListScreen] across all three navigation approaches.
class CategoryTile extends StatelessWidget {
  /// The category to display.
  final NewsCategory category;

  /// Number of articles in this category.
  final int articleCount;

  /// Called when the tile is tapped.
  final VoidCallback? onTap;

  /// Creates a [CategoryTile].
  const CategoryTile({
    super.key,
    required this.category,
    required this.articleCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // Leading icon from the enum metadata
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Icon(
          category.icon,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
      // Category name from the enum label
      title: Text(category.label),
      // Article count subtitle
      subtitle: Text(
        '$articleCount ${articleCount == 1 ? 'article' : 'articles'}',
      ),
      // Chevron trailing icon
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
