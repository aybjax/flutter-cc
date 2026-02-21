// =============================================================================
// Category List Screen
// =============================================================================
// Concepts demonstrated:
// - Displaying all NewsCategory enum values in a list
// - @RoutePage() annotation for auto_route code generation
// - Accepting a navigation callback for flexibility across nav approaches
// - ListTile with leading icon from enum metadata
//
// This screen is used by all three navigation approaches. The only
// difference is HOW navigation to the article list happens — that's
// controlled by the [onCategoryTap] callback.
// =============================================================================

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../data/mock_data.dart';
import '../widgets/category_tile.dart';

// -----------------------------------------------------------------------------
// Category List Screen Widget
// -----------------------------------------------------------------------------

/// Displays all news categories in a scrollable list.
///
/// Each category shows its icon, label, and article count.
/// Tapping a category navigates to the article list for that category.
@RoutePage()
class CategoryListScreen extends StatelessWidget {
  /// Callback invoked when a category is tapped.
  ///
  /// Each navigation approach provides a different implementation:
  /// - Navigator: `Navigator.push(context, ...)`
  /// - GoRouter: `context.go('/go/category/tech')`
  /// - auto_route: `context.pushRoute(ArticleListRoute(...))`
  final void Function(NewsCategory category)? onCategoryTap;

  /// Creates a [CategoryListScreen].
  const CategoryListScreen({super.key, this.onCategoryTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: ListView.builder(
        // NewsCategory.values gives us all enum variants
        itemCount: NewsCategory.values.length,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          final category = NewsCategory.values[index];

          // Count articles in this category from mock data
          final articleCount =
              MockData.articlesByCategory[category]?.length ?? 0;

          return CategoryTile(
            category: category,
            articleCount: articleCount,
            onTap: () => onCategoryTap?.call(category),
          );
        },
      ),
    );
  }
}
