// =============================================================================
// Search Screen
// =============================================================================
// Concepts demonstrated:
// - @RoutePage() annotation for auto_route code generation
// - @queryParam for extracting search terms from URL query strings
// - Debounced search input (simplified — no timer for demo)
// - Filtering mock data with a search query
// - Navigating to article detail from search results
//
// Query parameter example:
//   GoRouter URL: /go/search?q=flutter
//   auto_route:   /auto/search?q=flutter
//   The "q" parameter is extracted and used to pre-fill the search field.
// =============================================================================

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../data/mock_data.dart';
import '../widgets/article_card.dart';

// -----------------------------------------------------------------------------
// Search Screen Widget
// -----------------------------------------------------------------------------

/// A search screen that filters articles by title and summary.
///
/// Supports query parameters for deep linking:
/// - `/search?q=flutter` will pre-fill "flutter" in the search field
@RoutePage()
class SearchScreen extends StatefulWidget {
  /// Initial search query from URL query parameter.
  ///
  /// In GoRouter: extracted from `state.uri.queryParameters['q']`
  /// In auto_route: extracted via @queryParam annotation
  final String? initialQuery;

  /// Callback when an article is tapped in search results.
  final void Function(Article article)? onArticleTap;

  /// Creates a [SearchScreen].
  ///
  /// The [@queryParam] annotation on [initialQuery] tells auto_route to
  /// extract this value from the URL query string (e.g., /search?initialQuery=flutter).
  const SearchScreen({
    super.key,
    @queryParam this.initialQuery,
    this.onArticleTap,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;
  List<Article> _results = [];

  @override
  void initState() {
    super.initState();
    // Pre-fill search field with query parameter if provided (deep link)
    _searchController = TextEditingController(text: widget.initialQuery ?? '');

    // Run initial search if query was provided
    if (widget.initialQuery != null && widget.initialQuery!.isNotEmpty) {
      _performSearch(widget.initialQuery!);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Search logic
  // ---------------------------------------------------------------------------

  /// Filters articles matching the query in title or summary.
  void _performSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _results = [];
      } else {
        _results = MockData.search(query);
      }
    });
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          // -- Search input --
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search articles...',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                // Clear button
                suffixIcon:
                    _searchController.text.isNotEmpty
                        ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            _performSearch('');
                          },
                        )
                        : null,
              ),
              onChanged: _performSearch,

              // Alternative: debounced search with Timer
              // onChanged: (query) {
              //   _debounceTimer?.cancel();
              //   _debounceTimer = Timer(
              //     const Duration(milliseconds: 300),
              //     () => _performSearch(query),
              //   );
              // },
            ),
          ),

          // -- Results --
          Expanded(
            child:
                _searchController.text.isEmpty
                    ? _buildEmptyState(context)
                    : _results.isEmpty
                    ? _buildNoResults(context)
                    : _buildResults(),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Sub-builders
  // ---------------------------------------------------------------------------

  /// Shows a prompt when no search has been entered.
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'Type to search articles',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  /// Shows a "no results" message.
  Widget _buildNoResults(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'No articles found for "${_searchController.text}"',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  /// Builds the list of search results.
  Widget _buildResults() {
    return ListView.builder(
      itemCount: _results.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        final article = _results[index];
        return ArticleCard(
          article: article,
          onTap: () => widget.onArticleTap?.call(article),
        );
      },
    );
  }
}
