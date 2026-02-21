// =============================================================================
// Cart State - State for the shopping cart BLoC
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_bloc_tutorial/models/models.dart';

part 'cart_state.freezed.dart';

// ---------------------------------------------------------------------------
// CartState
// ---------------------------------------------------------------------------

/// State for the cart BLoC.
///
/// Contains the list of [CartItem]s and provides computed properties
/// for total price and item count.
@freezed
abstract class CartState with _$CartState {
  /// Creates a cart state with the given items.
  const factory CartState({
    @Default([]) List<CartItem> items,
  }) = _CartState;

  // Private constructor for custom getters
  const CartState._();

  // ---------------------------------------------------------------------------
  // Computed properties
  // ---------------------------------------------------------------------------

  /// Total price of all items in the cart.
  double get totalPrice =>
      items.fold(0.0, (sum, item) => sum + item.totalPrice);

  /// Total number of individual items (sum of all quantities).
  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  /// Number of distinct products in the cart.
  int get distinctItems => items.length;

  /// Whether the cart is empty.
  bool get isEmpty => items.isEmpty;

  /// Whether the cart contains a product with the given [productId].
  bool containsProduct(String productId) {
    return items.any((item) => item.product.id == productId);
  }

  /// Gets the quantity of a product in the cart (0 if not present).
  int quantityOf(String productId) {
    final item = items.where((i) => i.product.id == productId).firstOrNull;
    return item?.quantity ?? 0;
  }
}
