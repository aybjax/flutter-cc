// =============================================================================
// FavoritesScreen - Displays the user's favorite products
// =============================================================================
// Demonstrates:
// - BlocBuilder for reactive UI
// - Dispatching events from a different screen
// - Empty state handling
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_bloc_tutorial/l10n/app_localizations.dart';

import 'package:state_bloc_tutorial/blocs/favorites/favorites_bloc.dart';
import 'package:state_bloc_tutorial/blocs/favorites/favorites_event.dart';
import 'package:state_bloc_tutorial/blocs/favorites/favorites_state.dart';
import 'package:state_bloc_tutorial/blocs/cart/cart_bloc.dart';
import 'package:state_bloc_tutorial/blocs/cart/cart_event.dart';
import 'package:state_bloc_tutorial/models/models.dart';
import 'package:state_bloc_tutorial/screens/product_detail_screen.dart';
import 'package:state_bloc_tutorial/widgets/cart_badge.dart';

// ---------------------------------------------------------------------------
// FavoritesScreen
// ---------------------------------------------------------------------------

/// Screen showing the user's favorite products in a list format.
///
/// Favorites are persisted via HydratedBloc, so they survive app restarts.
/// Each item can be removed from favorites or added to the cart.
class FavoritesScreen extends StatelessWidget {
  /// Creates a [FavoritesScreen].
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.favorites),
        actions: [
          // Clear all favorites
          BlocBuilder<FavoritesBloc, FavoritesState>(
            buildWhen: (previous, current) =>
                previous.favorites.isEmpty != current.favorites.isEmpty,
            builder: (context, state) {
              if (state.favorites.isEmpty) {
                return const SizedBox.shrink();
              }
              return IconButton(
                icon: const Icon(Icons.delete_sweep),
                tooltip: 'Clear all favorites',
                onPressed: () {
                  context
                      .read<FavoritesBloc>()
                      .add(const FavoritesEvent.clearFavorites());
                },
              );
            },
          ),
          const CartBadge(),
        ],
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state.favorites.isEmpty) {
            return _buildEmptyState(context, l10n);
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              return _buildFavoriteItem(
                context,
                state.favorites[index],
                l10n,
              );
            },
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Empty state
  // ---------------------------------------------------------------------------

  /// Shows a friendly message when there are no favorites.
  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.emptyFavorites,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Favorite item tile
  // ---------------------------------------------------------------------------

  /// Builds a list tile for a single favorite product.
  Widget _buildFavoriteItem(
    BuildContext context,
    Product product,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);

    // Map category to icon
    final icon = switch (product.category) {
      ProductCategory.electronics => Icons.devices,
      ProductCategory.clothing => Icons.checkroom,
      ProductCategory.books => Icons.menu_book,
      ProductCategory.home => Icons.home,
      ProductCategory.sports => Icons.sports_tennis,
    };

    return Dismissible(
      key: ValueKey(product.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) {
        context
            .read<FavoritesBloc>()
            .add(FavoritesEvent.removeFavorite(product.id));
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(child: Icon(icon)),
          title: Text(
            product.name,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
          trailing: IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: () {
              context
                  .read<CartBloc>()
                  .add(CartEvent.addToCart(product));

              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text('${product.name} added to cart'),
                    duration: const Duration(seconds: 1),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
            },
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ProductDetailScreen(product: product),
              ),
            );
          },
        ),
      ),
    );
  }
}
