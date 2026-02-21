// =============================================================================
// Article List Screen
// =============================================================================
// Concepts demonstrated:
// - Receiving navigation arguments (category name) from different approaches
// - @RoutePage() annotation for auto_route
// - @pathParam / @queryParam annotations for auto_route argument extraction
// - Filtering articles by category
// - Passing data forward to the detail screen via callback
//
// This screen works with all three navigation approaches:
// - Navigator: category passed as constructor argument
// - GoRouter: category extracted from path parameter
// - auto_route: category extracted via @pathParam annotation
// =============================================================================

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../data/mock_data.dart';
import '../widgets/article_card.dart';

// -----------------------------------------------------------------------------
// Article List Screen Widget
// -----------------------------------------------------------------------------

/// Displays articles filtered by a specific [NewsCategory].
///
/// The category can be provided directly (Navigator approach) or
/// extracted from the URL path (GoRouter / auto_route approaches).
@RoutePage()
class ArticleListScreen extends StatelessWidget {
  /// The category name to filter articles by.
  ///
  /// This is a String (not an enum) because URL path parameters are strings.
  /// We parse it back to [NewsCategory] using [NewsCategory.fromName].
  final String categoryName;

  /// Callback when an article is tapped.
  ///
  /// Each navigation approach provides different routing logic here.
  final void Function(Article article)? onArticleTap;

  /// Creates an [ArticleListScreen] for the given [categoryName].
  ///
  /// The [@pathParam] annotation on [categoryName] tells auto_route to
  /// extract this value from the URL path segment (e.g., /category/:categoryName).
  const ArticleListScreen({
    super.key,
    @pathParam required this.categoryName,
    this.onArticleTap,
  });

  @override
  Widget build(BuildContext context) {
    // Parse the category name string back to the enum
    final category = NewsCategory.fromName(categoryName);

    // Get articles for this category, or empty list if invalid
    final articles =
        category != null
            ? (MockData.articlesByCategory[category] ?? [])
            : <Article>[];

    return Scaffold(
      appBar: AppBar(
        title: Text(category?.label ?? 'Unknown Category'),
      ),
      body:
          articles.isEmpty
              ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.article_outlined,
                      size: 64,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No articles in this category',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              )
              : ListView.builder(
                itemCount: articles.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return ArticleCard(
                    article: article,
                    onTap: () => onArticleTap?.call(article),
                  );
                },
              ),
    );
  }
}
