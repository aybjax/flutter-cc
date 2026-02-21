// =============================================================================
// CartScreen - Shopping cart with quantity controls and checkout
// =============================================================================
// Demonstrates:
// - BlocBuilder for the cart item list
// - BlocSelector for the total price display
// - Dispatching quantity update events
// - Composed BLoC interactions
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_bloc_tutorial/l10n/app_localizations.dart';

import 'package:state_bloc_tutorial/models/models.dart';
import 'package:state_bloc_tutorial/blocs/cart/cart_bloc.dart';
import 'package:state_bloc_tutorial/blocs/cart/cart_event.dart';
import 'package:state_bloc_tutorial/blocs/cart/cart_state.dart';

// ---------------------------------------------------------------------------
// CartScreen
// ---------------------------------------------------------------------------

/// Screen displaying the shopping cart contents with quantity controls.
///
/// Features:
/// - List of cart items with +/- quantity buttons
/// - Swipe to dismiss for removing items
/// - Running total at the bottom
/// - Checkout button (shows a dialog in this demo)
/// - Clear cart option
class CartScreen extends StatelessWidget {
  /// Creates a [CartScreen].
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.cart),
        actions: [
          // Clear cart button
          BlocBuilder<CartBloc, CartState>(
            buildWhen: (previous, current) =>
                previous.isEmpty != current.isEmpty,
            builder: (context, state) {
              if (state.isEmpty) return const SizedBox.shrink();
              return IconButton(
                icon: const Icon(Icons.delete_sweep),
                tooltip: 'Clear cart',
                onPressed: () {
                  _showClearCartDialog(context);
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.isEmpty) {
            return _buildEmptyState(context, l10n);
          }

          return Column(
            children: [
              // --- Cart items list ---
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    return _buildCartItem(context, state.items[index], l10n);
                  },
                ),
              ),

              // --- Total and checkout ---
              _buildBottomBar(context, state, l10n),
            ],
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Empty state
  // ---------------------------------------------------------------------------

  /// Shows a friendly message when the cart is empty.
  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.emptyCart,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Cart item tile
  // ---------------------------------------------------------------------------

  /// Builds a card for a single cart item with quantity controls.
  Widget _buildCartItem(
    BuildContext context,
    CartItem item,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);
    final product = item.product;

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
            .read<CartBloc>()
            .add(CartEvent.removeFromCart(product.id));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Product icon
              CircleAvatar(
                radius: 24,
                child: Icon(icon),
              ),
              const SizedBox(width: 12),

              // Product info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${product.price.toStringAsFixed(2)} each',
                      style: theme.textTheme.bodySmall,
                    ),
                    Text(
                      '${l10n.total}: \$${item.totalPrice.toStringAsFixed(2)}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // Quantity controls
              _buildQuantityControls(context, item),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Quantity controls
  // ---------------------------------------------------------------------------

  /// Builds +/- buttons for adjusting item quantity.
  Widget _buildQuantityControls(BuildContext context, CartItem item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Decrease quantity
        IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          iconSize: 20,
          onPressed: () {
            context.read<CartBloc>().add(
                  CartEvent.updateQuantity(
                    item.product.id,
                    item.quantity - 1,
                  ),
                );
          },
        ),

        // Current quantity
        Text(
          '${item.quantity}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),

        // Increase quantity
        IconButton(
          icon: const Icon(Icons.add_circle_outline),
          iconSize: 20,
          onPressed: () {
            context.read<CartBloc>().add(
                  CartEvent.updateQuantity(
                    item.product.id,
                    item.quantity + 1,
                  ),
                );
          },
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Bottom bar with total and checkout
  // ---------------------------------------------------------------------------

  /// Builds the bottom bar showing total price and checkout button.
  Widget _buildBottomBar(
    BuildContext context,
    CartState state,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.total,
                  style: theme.textTheme.bodySmall,
                ),
                Text(
                  '\$${state.totalPrice.toStringAsFixed(2)}',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            FilledButton.icon(
              onPressed: () {
                _showCheckoutDialog(context);
              },
              icon: const Icon(Icons.payment),
              label: Text(l10n.checkout),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Dialogs
  // ---------------------------------------------------------------------------

  /// Shows a confirmation dialog for clearing the cart.
  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text('Remove all items from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              context
                  .read<CartBloc>()
                  .add(const CartEvent.clearCart());
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  /// Shows a demo checkout dialog.
  void _showCheckoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Checkout'),
        content: const Text(
          'This is a demo app. In production, this would navigate to '
          'a payment flow.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
