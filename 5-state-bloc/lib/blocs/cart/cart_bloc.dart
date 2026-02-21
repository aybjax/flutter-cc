// =============================================================================
// Cart BLoC - Business logic for the shopping cart
// =============================================================================
// Demonstrates:
// - Droppable transformer: drops events while one is being processed
// - Composed/nested BLoC interaction patterns
// - Complex state mutations with immutable data
// =============================================================================

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:state_bloc_tutorial/models/models.dart';
import 'cart_event.dart';
import 'cart_state.dart';

// ---------------------------------------------------------------------------
// CartBloc
// ---------------------------------------------------------------------------

/// BLoC that manages the shopping cart state.
///
/// Uses [droppable] transformer for add/remove operations to prevent
/// duplicate processing if events fire rapidly (e.g., rapid button taps).
class CartBloc extends Bloc<CartEvent, CartState> {
  /// Creates a [CartBloc] with an empty cart.
  CartBloc() : super(const CartState()) {
    // droppable() drops new events while the handler is still processing
    on<AddToCart>(
      _onAddToCart,
      transformer: droppable(),
    );
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateQuantity>(_onUpdateQuantity);
    on<ClearCart>(_onClearCart);
  }

  // ---------------------------------------------------------------------------
  // Event handlers
  // ---------------------------------------------------------------------------

  /// Adds a product to the cart or increments quantity if already present.
  void _onAddToCart(
    AddToCart event,
    Emitter<CartState> emit,
  ) {
    final existingIndex = state.items.indexWhere(
      (item) => item.product.id == event.product.id,
    );

    if (existingIndex >= 0) {
      // Product already in cart - increment quantity
      final existingItem = state.items[existingIndex];
      final updatedItems = List<CartItem>.from(state.items);
      updatedItems[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + 1,
      );
      emit(CartState(items: updatedItems));
    } else {
      // New product - add to cart with quantity 1
      emit(CartState(
        items: [...state.items, CartItem(product: event.product)],
      ));
    }
  }

  /// Removes a product from the cart entirely.
  void _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<CartState> emit,
  ) {
    emit(CartState(
      items: state.items
          .where((item) => item.product.id != event.productId)
          .toList(),
    ));
  }

  /// Updates the quantity of a cart item.
  ///
  /// If [quantity] is 0 or less, the item is removed from the cart.
  void _onUpdateQuantity(
    UpdateQuantity event,
    Emitter<CartState> emit,
  ) {
    if (event.quantity <= 0) {
      // Remove the item if quantity drops to 0
      emit(CartState(
        items: state.items
            .where((item) => item.product.id != event.productId)
            .toList(),
      ));
      return;
    }

    final updatedItems = state.items.map((item) {
      if (item.product.id == event.productId) {
        return item.copyWith(quantity: event.quantity);
      }
      return item;
    }).toList();

    emit(CartState(items: updatedItems));
  }

  /// Clears all items from the cart.
  void _onClearCart(
    ClearCart event,
    Emitter<CartState> emit,
  ) {
    emit(const CartState());
  }
}

// Alternative: Using Cubit for simpler cart logic:
// class CartCubit extends Cubit<CartState> {
//   CartCubit() : super(const CartState());
//   void addToCart(Product product) { ... emit(...); }
//   void removeFromCart(String productId) { ... emit(...); }
// }
