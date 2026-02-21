// =============================================================================
// CartItem Model - @freezed immutable cart item data class
// =============================================================================
// Wraps a Product with a quantity for the shopping cart
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_bloc_tutorial/models/product.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

// ---------------------------------------------------------------------------
// CartItem model
// ---------------------------------------------------------------------------

/// Immutable cart item that wraps a [Product] with a [quantity].
///
/// Used by the CartBloc to track items in the user's shopping cart.
@freezed
abstract class CartItem with _$CartItem {
  /// Creates a new [CartItem] with a product and quantity.
  const factory CartItem({
    required Product product,
    @Default(1) int quantity,
  }) = _CartItem;

  // Private constructor needed for custom getters on freezed classes
  const CartItem._();

  // ---------------------------------------------------------------------------
  // Computed properties
  // ---------------------------------------------------------------------------

  /// Total price for this line item (price * quantity).
  double get totalPrice => product.price * quantity;

  /// Creates a [CartItem] from a JSON map.
  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}
