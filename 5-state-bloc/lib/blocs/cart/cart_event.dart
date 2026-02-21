// =============================================================================
// Cart Events - Events for managing the shopping cart
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_bloc_tutorial/models/models.dart';

part 'cart_event.freezed.dart';

// ---------------------------------------------------------------------------
// CartEvent union
// ---------------------------------------------------------------------------

/// Events for the cart BLoC.
///
/// Supports adding, removing, updating quantity, and clearing the cart.
@freezed
sealed class CartEvent with _$CartEvent {
  /// Add a product to the cart.
  ///
  /// If the product is already in the cart, increments its quantity by 1.
  const factory CartEvent.addToCart(Product product) = AddToCart;

  /// Remove a product from the cart entirely.
  const factory CartEvent.removeFromCart(String productId) = RemoveFromCart;

  /// Update the quantity of a cart item.
  ///
  /// If [quantity] is 0, the item is removed from the cart.
  const factory CartEvent.updateQuantity(String productId, int quantity) =
      UpdateQuantity;

  /// Clear all items from the cart.
  const factory CartEvent.clearCart() = ClearCart;
}
