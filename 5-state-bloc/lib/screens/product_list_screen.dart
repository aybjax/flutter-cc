// =============================================================================
// ProductListScreen - Main product browsing screen
// =============================================================================
// Demonstrates:
// - BlocBuilder with pattern matching on state variants
// - Category filter dropdown
// - Navigation to search, favorites, cart
// - Grid layout for products
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_bloc_tutorial/l10n/app_localizations.dart';

import 'package:state_bloc_tutorial/models/models.dart';
import 'package:state_bloc_tutorial/blocs/product_list/product_list_bloc.dart';
import 'package:state_bloc_tutorial/blocs/product_list/product_list_event.dart';
import 'package:state_bloc_tutorial/blocs/product_list/product_list_state.dart';
import 'package:state_bloc_tutorial/screens/favorites_screen.dart';
import 'package:state_bloc_tutorial/screens/search_screen.dart';
import 'package:state_bloc_tutorial/widgets/product_card.dart';
import 'package:state_bloc_tutorial/widgets/cart_badge.dart';

// ---------------------------------------------------------------------------
// ProductListScreen
// ---------------------------------------------------------------------------

/// The main screen showing the product catalog in a grid layout.
///
/// Provides:
/// - Category filter dropdown in the app bar
/// - Navigation to search, favorites, and cart screens
/// - Pull-to-refresh to reload products
/// - Responsive grid (2 columns portrait, 3 landscape)
class ProductListScreen extends StatelessWidget {
  /// Creates a [ProductListScreen].
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          // Search button
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              );
            },
          ),

          // Favorites button
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const FavoritesScreen()),
              );
            },
          ),

          // Cart badge with item count
          const CartBadge(),
        ],
      ),
      body: Column(
        children: [
          // --- Category filter ---
          _buildCategoryFilter(context, l10n),

          // --- Product grid ---
          Expanded(
            child: _buildProductGrid(context, l10n),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Category filter
  // ---------------------------------------------------------------------------

  /// Builds the category filter dropdown.
  Widget _buildCategoryFilter(BuildContext context, AppLocalizations l10n) {
    return BlocBuilder<ProductListBloc, ProductListState>(
      // Only rebuild when the selected category changes
      buildWhen: (previous, current) {
        final prevCategory = previous is ProductListLoaded
            ? previous.selectedCategory
            : null;
        final currCategory = current is ProductListLoaded
            ? current.selectedCategory
            : null;
        return prevCategory != currCategory;
      },
      builder: (context, state) {
        final selectedCategory =
            state is ProductListLoaded ? state.selectedCategory : null;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: DropdownButtonFormField<ProductCategory?>(
            // Use initialValue instead of deprecated value parameter
            key: ValueKey(selectedCategory),
            initialValue: selectedCategory,
            decoration: InputDecoration(
              labelText: l10n.filterByCategory,
              border: const OutlineInputBorder(),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            items: [
              // "All Categories" option
              DropdownMenuItem<ProductCategory?>(
                value: null,
                child: Text(l10n.allCategories),
              ),
              // One option per category
              ...ProductCategory.values.map((category) {
                return DropdownMenuItem<ProductCategory?>(
                  value: category,
                  child: Text(category.name.toUpperCase()),
                );
              }),
            ],
            onChanged: (category) {
              context
                  .read<ProductListBloc>()
                  .add(ProductListEvent.filterByCategory(category));
            },
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Product grid
  // ---------------------------------------------------------------------------

  /// Builds the main product grid using BlocBuilder with pattern matching.
  Widget _buildProductGrid(BuildContext context, AppLocalizations l10n) {
    return BlocBuilder<ProductListBloc, ProductListState>(
      builder: (context, state) {
        // Pattern match on the state variant to show appropriate UI
        return switch (state) {
          ProductListInitial() => Center(child: Text(l10n.loading)),
          ProductListLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          ProductListLoaded(:final products) when products.isEmpty => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(l10n.noResults,
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ),
          ProductListLoaded(:final products) => RefreshIndicator(
              onRefresh: () async {
                context
                    .read<ProductListBloc>()
                    .add(const ProductListEvent.loadProducts());
              },
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
            ),
          ProductListError(:final message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline,
                      size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(message,
                      textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () {
                      context
                          .read<ProductListBloc>()
                          .add(const ProductListEvent.loadProducts());
                    },
                    icon: const Icon(Icons.refresh),
                    label: Text(l10n.retry),
                  ),
                ],
              ),
            ),
        };
      },
    );
  }
}
