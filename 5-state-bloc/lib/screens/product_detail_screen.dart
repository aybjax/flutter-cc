// =============================================================================
// ProductDetailScreen - Full product details with actions
// =============================================================================
// Demonstrates:
// - Reading from multiple BLoCs in a single screen
// - BlocBuilder with buildWhen for optimization
// - Dispatching events to different BLoCs from the same screen
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_bloc_tutorial/l10n/app_localizations.dart';

import 'package:state_bloc_tutorial/models/models.dart';
import 'package:state_bloc_tutorial/blocs/favorites/favorites_bloc.dart';
import 'package:state_bloc_tutorial/blocs/favorites/favorites_event.dart';
import 'package:state_bloc_tutorial/blocs/favorites/favorites_state.dart';
import 'package:state_bloc_tutorial/blocs/cart/cart_bloc.dart';
import 'package:state_bloc_tutorial/blocs/cart/cart_event.dart';
import 'package:state_bloc_tutorial/blocs/cart/cart_state.dart';
import 'package:state_bloc_tutorial/widgets/cart_badge.dart';

// ---------------------------------------------------------------------------
// ProductDetailScreen
// ---------------------------------------------------------------------------

/// Screen showing full details for a single product.
///
/// Allows the user to:
/// - View product description, price, and category
/// - Toggle favorite status
/// - Add the product to the cart
/// - See how many are already in the cart
class ProductDetailScreen extends StatelessWidget {
  /// The product to display.
  final Product product;

  /// Creates a [ProductDetailScreen] for the given [product].
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: const [CartBadge()],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Product image placeholder ---
            _buildHeroImage(theme),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Name and price row ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // --- Category chip ---
                  Chip(
                    label: Text(product.category.name.toUpperCase()),
                    avatar: Icon(_categoryIcon(product.category), size: 18),
                  ),
                  const SizedBox(height: 16),

                  // --- Description ---
                  Text(
                    l10n.description,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),

                  // --- Favorite button ---
                  _buildFavoriteButton(context, l10n),
                  const SizedBox(height: 12),

                  // --- Add to cart button ---
                  _buildCartButton(context, l10n),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Hero image
  // ---------------------------------------------------------------------------

  /// Builds a large image placeholder for the product.
  Widget _buildHeroImage(ThemeData theme) {
    final (color, icon) = switch (product.category) {
      ProductCategory.electronics => (Colors.blue.shade100, Icons.devices),
      ProductCategory.clothing => (Colors.pink.shade100, Icons.checkroom),
      ProductCategory.books => (Colors.amber.shade100, Icons.menu_book),
      ProductCategory.home => (Colors.green.shade100, Icons.home),
      ProductCategory.sports => (Colors.orange.shade100, Icons.sports_tennis),
    };

    return Container(
      height: 250,
      color: color,
      child: Center(
        child: Icon(icon, size: 80, color: Colors.grey.shade700),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Favorite button
  // ---------------------------------------------------------------------------

  /// Builds a toggle button for adding/removing the product from favorites.
  Widget _buildFavoriteButton(BuildContext context, AppLocalizations l10n) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      buildWhen: (previous, current) =>
          previous.isFavorite(product.id) != current.isFavorite(product.id),
      builder: (context, state) {
        final isFav = state.isFavorite(product.id);

        return SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              context
                  .read<FavoritesBloc>()
                  .add(FavoritesEvent.toggleFavorite(product));
            },
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : null,
            ),
            label: Text(
              isFav ? l10n.removeFromFavorites : l10n.addToFavorites,
            ),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Cart button
  // ---------------------------------------------------------------------------

  /// Builds the add-to-cart button with quantity indicator.
  Widget _buildCartButton(BuildContext context, AppLocalizations l10n) {
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) =>
          previous.quantityOf(product.id) != current.quantityOf(product.id),
      builder: (context, state) {
        final quantity = state.quantityOf(product.id);

        return SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
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
            icon: const Icon(Icons.add_shopping_cart),
            label: Text(
              quantity > 0
                  ? '${l10n.addToCart} ($quantity in cart)'
                  : l10n.addToCart,
            ),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Maps a [ProductCategory] to its corresponding icon.
  IconData _categoryIcon(ProductCategory category) {
    return switch (category) {
      ProductCategory.electronics => Icons.devices,
      ProductCategory.clothing => Icons.checkroom,
      ProductCategory.books => Icons.menu_book,
      ProductCategory.home => Icons.home,
      ProductCategory.sports => Icons.sports_tennis,
    };
  }
}
