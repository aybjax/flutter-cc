// =============================================================================
// ProductCard Widget - Reusable product display card
// =============================================================================
// Shows product info with favorite toggle and add-to-cart button.
// Demonstrates: BlocBuilder, context.read, context.select
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:state_bloc_tutorial/models/models.dart';
import 'package:state_bloc_tutorial/blocs/favorites/favorites_bloc.dart';
import 'package:state_bloc_tutorial/blocs/favorites/favorites_event.dart';
import 'package:state_bloc_tutorial/blocs/favorites/favorites_state.dart';
import 'package:state_bloc_tutorial/blocs/cart/cart_bloc.dart';
import 'package:state_bloc_tutorial/blocs/cart/cart_event.dart';
import 'package:state_bloc_tutorial/screens/product_detail_screen.dart';

// ---------------------------------------------------------------------------
// ProductCard
// ---------------------------------------------------------------------------

/// A card widget that displays a product's info with action buttons.
///
/// Shows:
/// - Product image placeholder (colored box with icon)
/// - Product name and price
/// - Category chip
/// - Favorite toggle button (heart icon)
/// - Add to cart button
class ProductCard extends StatelessWidget {
  /// The product to display.
  final Product product;

  /// Creates a [ProductCard] for the given [product].
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: InkWell(
        onTap: () {
          // Navigate to product detail screen
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ProductDetailScreen(product: product),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Product image placeholder ---
            _buildImagePlaceholder(theme),

            // --- Product info ---
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product name
                    Text(
                      product.name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Price
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),

                    // --- Action buttons row ---
                    _buildActionRow(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Image placeholder
  // ---------------------------------------------------------------------------

  /// Builds a colored placeholder box with a category icon.
  Widget _buildImagePlaceholder(ThemeData theme) {
    // Map category to color and icon
    final (color, icon) = switch (product.category) {
      ProductCategory.electronics => (Colors.blue.shade100, Icons.devices),
      ProductCategory.clothing => (Colors.pink.shade100, Icons.checkroom),
      ProductCategory.books => (Colors.amber.shade100, Icons.menu_book),
      ProductCategory.home => (Colors.green.shade100, Icons.home),
      ProductCategory.sports => (Colors.orange.shade100, Icons.sports_tennis),
    };

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: color,
        child: Center(
          child: Icon(icon, size: 40, color: Colors.grey.shade700),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Action buttons
  // ---------------------------------------------------------------------------

  /// Builds the row with favorite toggle and add-to-cart button.
  Widget _buildActionRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Favorite button - uses BlocBuilder to react to favorites state
        BlocBuilder<FavoritesBloc, FavoritesState>(
          // Only rebuild when this product's favorite status changes
          buildWhen: (previous, current) =>
              previous.isFavorite(product.id) !=
              current.isFavorite(product.id),
          builder: (context, state) {
            final isFav = state.isFavorite(product.id);
            return IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.red : null,
              ),
              iconSize: 20,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                // Use context.read (not watch) for event dispatching
                context
                    .read<FavoritesBloc>()
                    .add(FavoritesEvent.toggleFavorite(product));
              },
            );
          },
        ),

        // Add to cart button
        IconButton(
          icon: const Icon(Icons.add_shopping_cart),
          iconSize: 20,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () {
            context.read<CartBloc>().add(CartEvent.addToCart(product));

            // Show snackbar confirmation
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
      ],
    );
  }
}
