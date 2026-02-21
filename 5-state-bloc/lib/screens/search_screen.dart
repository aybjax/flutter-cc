// =============================================================================
// SearchScreen - Product search with debounced input
// =============================================================================
// Demonstrates:
// - EventTransformer with debounce (300ms) for search
// - BlocProvider.value to share existing BLoC instance
// - BlocListener for reacting to state changes without rebuilding
// - Text field -> Event -> Debounce -> Handler -> State -> UI
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_bloc_tutorial/l10n/app_localizations.dart';

import 'package:state_bloc_tutorial/blocs/product_list/product_list_bloc.dart';
import 'package:state_bloc_tutorial/blocs/product_list/product_list_event.dart';
import 'package:state_bloc_tutorial/blocs/product_list/product_list_state.dart';
import 'package:state_bloc_tutorial/widgets/product_card.dart';
import 'package:state_bloc_tutorial/widgets/cart_badge.dart';

// ---------------------------------------------------------------------------
// SearchScreen
// ---------------------------------------------------------------------------

/// Screen with a search text field that uses debounced BLoC events.
///
/// How the debounce flow works:
/// 1. User types in the search field
/// 2. Each keystroke dispatches a [SearchProducts] event
/// 3. The debounce EventTransformer waits 300ms of inactivity
/// 4. Only the last event is processed by the handler
/// 5. The handler filters products and emits new state
/// 6. BlocBuilder rebuilds the grid with filtered results
class SearchScreen extends StatefulWidget {
  /// Creates a [SearchScreen].
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    // Restore existing search query if navigating back to this screen
    final state = context.read<ProductListBloc>().state;
    if (state is ProductListLoaded && state.searchQuery.isNotEmpty) {
      _searchController.text = state.searchQuery;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: _buildSearchField(l10n),
        actions: const [CartBadge()],
      ),
      body: BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
          return switch (state) {
            ProductListInitial() => const Center(
                child: Text('Start searching...'),
              ),
            ProductListLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            ProductListLoaded(:final products) when products.isEmpty =>
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.search_off,
                        size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      l10n.noResults,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ProductListLoaded(:final products) => GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: products[index]);
                },
              ),
            ProductListError(:final message) => Center(
                child: Text(message),
              ),
          };
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Search field
  // ---------------------------------------------------------------------------

  /// Builds the search text field in the app bar.
  ///
  /// Each keystroke dispatches a [SearchProducts] event to the BLoC.
  /// The BLoC's debounce transformer ensures only the final query
  /// (after 300ms of inactivity) triggers the actual search.
  Widget _buildSearchField(AppLocalizations l10n) {
    return TextField(
      controller: _searchController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: l10n.searchHint,
        border: InputBorder.none,
        // Clear button
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            _searchController.clear();
            // Dispatch empty search to restore full list
            context
                .read<ProductListBloc>()
                .add(const ProductListEvent.searchProducts(''));
          },
        ),
      ),
      onChanged: (query) {
        // Every keystroke dispatches a SearchProducts event
        // The debounce transformer in the BLoC handles rate limiting
        context
            .read<ProductListBloc>()
            .add(ProductListEvent.searchProducts(query));
      },
    );
  }
}

// Alternative: You could use a separate SearchBloc instead of reusing
// ProductListBloc:
// class SearchBloc extends Bloc<SearchEvent, SearchState> {
//   SearchBloc(this._repository) : super(const SearchState.initial()) {
//     on<SearchQueryChanged>(
//       _onQueryChanged,
//       transformer: debounce(const Duration(milliseconds: 300)),
//     );
//   }
// }
