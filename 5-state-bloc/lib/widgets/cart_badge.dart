// =============================================================================
// CartBadge Widget - Shopping cart icon with item count badge
// =============================================================================
// Demonstrates: BlocSelector for selecting a specific piece of state
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:state_bloc_tutorial/blocs/cart/cart_bloc.dart';
import 'package:state_bloc_tutorial/blocs/cart/cart_state.dart';
import 'package:state_bloc_tutorial/screens/cart_screen.dart';

// ---------------------------------------------------------------------------
// CartBadge
// ---------------------------------------------------------------------------

/// An icon button with a badge showing the number of items in the cart.
///
/// Uses [BlocSelector] to only rebuild when the item count changes,
/// not on every cart state change (more efficient than BlocBuilder).
class CartBadge extends StatelessWidget {
  /// Creates a [CartBadge].
  const CartBadge({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocSelector: Only rebuilds when totalItems changes
    // More efficient than BlocBuilder which rebuilds on any state change
    return BlocSelector<CartBloc, CartState, int>(
      selector: (state) => state.totalItems,
      builder: (context, totalItems) {
        return IconButton(
          icon: Badge(
            // Hide badge when cart is empty
            isLabelVisible: totalItems > 0,
            label: Text(totalItems.toString()),
            child: const Icon(Icons.shopping_cart),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const CartScreen()),
            );
          },
        );
      },
    );

    // Alternative: Using BlocBuilder (rebuilds on ANY cart state change):
    // return BlocBuilder<CartBloc, CartState>(
    //   builder: (context, state) {
    //     return IconButton(
    //       icon: Badge(
    //         isLabelVisible: state.totalItems > 0,
    //         label: Text(state.totalItems.toString()),
    //         child: const Icon(Icons.shopping_cart),
    //       ),
    //       onPressed: () { ... },
    //     );
    //   },
    // );
  }
}
