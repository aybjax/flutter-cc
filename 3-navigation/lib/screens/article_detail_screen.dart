// =============================================================================
// Article Detail Screen
// =============================================================================
// Concepts demonstrated:
// - Deep link target — this screen can be reached via URL
// - @RoutePage() annotation for auto_route
// - @pathParam for extracting article ID from URL path
// - PopScope for intercepting back navigation (replaces deprecated WillPopScope)
// - Looking up data by ID from mock data
// - Handling "not found" gracefully when deep-linked to a deleted article
//
// Deep linking flow:
//   URL: /article/tech-1
//   → Router extracts "tech-1" as articleId
//   → Screen looks up Article from MockData
//   → Displays full article or "not found" message
// =============================================================================

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../data/mock_data.dart';

// -----------------------------------------------------------------------------
// Article Detail Screen Widget
// -----------------------------------------------------------------------------

/// Displays the full content of a single news article.
///
/// Can be reached via:
/// - Navigator.push with an Article object
/// - GoRouter path: /go/article/:articleId
/// - auto_route path: /auto/article/:articleId
/// - Deep link: news-reader://article/tech-1
@RoutePage()
class ArticleDetailScreen extends StatelessWidget {
  /// The article ID extracted from the URL path.
  ///
  /// When navigating with Navigator.push, the Article can be passed directly.
  /// When deep linking, only the ID is available from the URL, so we look
  /// up the full Article from MockData.
  final String articleId;

  /// Optional pre-loaded article (when navigating from a list).
  ///
  /// If null, the article is looked up by [articleId] from MockData.
  /// This avoids redundant lookups when navigating from a list that
  /// already has the Article object.
  final Article? article;

  /// Creates an [ArticleDetailScreen].
  ///
  /// The [@pathParam] annotation on [articleId] tells auto_route to
  /// extract this value from the URL path segment (e.g., /article/:articleId).
  const ArticleDetailScreen({
    super.key,
    @pathParam required this.articleId,
    this.article,
  });

  @override
  Widget build(BuildContext context) {
    // Use the pre-loaded article if available, otherwise look up by ID.
    // This pattern is common in apps with deep linking support:
    // - From list: article is already loaded, no lookup needed
    // - From deep link: only ID is available, must look up
    final displayArticle = article ?? MockData.findById(articleId);

    // -- Handle "not found" case --
    // This can happen when a deep link points to a deleted article
    if (displayArticle == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Article Not Found')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Article "$articleId" not found',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    // ---------------------------------------------------------------------------
    // Article detail layout
    // ---------------------------------------------------------------------------

    return PopScope(
      // PopScope replaces the deprecated WillPopScope widget.
      //
      // canPop: true  — allows the system back gesture/button
      // canPop: false — blocks it (useful for unsaved form data)
      //
      // onPopInvokedWithResult is called when a pop is attempted.
      // Use it to show a "discard changes?" dialog.
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        // This fires whether pop was allowed or blocked.
        // didPop == true means the pop actually happened.
        // didPop == false means canPop was false and pop was blocked.
        if (didPop) {
          debugPrint('Popped from article: ${displayArticle.title}');
        }

        // Alternative: show a confirmation dialog when canPop is false
        // if (!didPop) {
        //   showDialog(
        //     context: context,
        //     builder: (_) => AlertDialog(
        //       title: Text('Leave article?'),
        //       actions: [
        //         TextButton(onPressed: () => Navigator.pop(context), child: Text('Stay')),
        //         TextButton(onPressed: () { Navigator.pop(context); Navigator.pop(context); }, child: Text('Leave')),
        //       ],
        //     ),
        //   );
        // }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(displayArticle.category.label),
          actions: [
            // Bookmark toggle
            IconButton(
              icon: Icon(
                displayArticle.isBookmarked
                    ? Icons.bookmark
                    : Icons.bookmark_border,
              ),
              onPressed: () {
                // In a real app, this would update state via a provider
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      displayArticle.isBookmarked
                          ? 'Removed bookmark'
                          : 'Article bookmarked',
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
            // Share button
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                // In a real app, this would use the share_plus package
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Share: news-reader://article/${displayArticle.id}',
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -- Title --
              Text(
                displayArticle.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // -- Metadata row --
              Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 16,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    displayArticle.author,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.schedule,
                    size: 16,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${displayArticle.readTimeMinutes} min read',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // -- Category chip --
              Chip(
                avatar: Icon(displayArticle.category.icon, size: 18),
                label: Text(displayArticle.category.label),
              ),

              const Divider(height: 32),

              // -- Summary (bold intro) --
              Text(
                displayArticle.summary,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 16),

              // -- Full body text --
              Text(
                displayArticle.body,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 32),

              // -- Article ID for debugging deep links --
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.link,
                      size: 16,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Deep link: news-reader://article/${displayArticle.id}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontFamily: 'monospace',
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
