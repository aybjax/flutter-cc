// =============================================================================
// Article Card Widget
// =============================================================================
// Concepts demonstrated:
// - Reusable card widget for displaying article previews
// - Card with InkWell for Material tap ripple
// - Composition over inheritance — accepts data + callback
// - Theme-aware styling using Theme.of(context)
// =============================================================================

import 'package:flutter/material.dart';

import '../models/models.dart';

// -----------------------------------------------------------------------------
// Article Card Widget
// -----------------------------------------------------------------------------

/// A card displaying an article preview with title, summary, and metadata.
///
/// Used in article list screens and search results across all three
/// navigation approaches. The [onTap] callback lets each approach
/// provide its own navigation logic.
class ArticleCard extends StatelessWidget {
  /// The article to display.
  final Article article;

  /// Called when the card is tapped.
  final VoidCallback? onTap;

  /// Creates an [ArticleCard].
  const ArticleCard({
    super.key,
    required this.article,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      // InkWell provides the Material tap ripple effect.
      // It must be inside the Card for the ripple to clip correctly.
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -- Category + read time row --
              Row(
                children: [
                  Icon(
                    article.category.icon,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    article.category.label,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${article.readTimeMinutes} min',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // -- Title --
              Text(
                article.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),

              // -- Summary --
              Text(
                article.summary,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              // -- Author --
              Text(
                'By ${article.author}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
