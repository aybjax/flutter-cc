// =============================================================================
// ProductList States - All possible states for the product list
// =============================================================================
// Uses @freezed for immutable state with union variants.
// Each variant represents a distinct UI state.
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_bloc_tutorial/models/models.dart';

part 'product_list_state.freezed.dart';

// ---------------------------------------------------------------------------
// ProductListState union
// ---------------------------------------------------------------------------

/// States for the product list BLoC.
///
/// The UI maps each state variant to a different widget tree:
/// - [initial] -> nothing loaded yet
/// - [loading] -> show a spinner
/// - [loaded] -> show the product grid
/// - [error] -> show error message with retry
@freezed
sealed class ProductListState with _$ProductListState {
  /// Initial state before any products are loaded.
  const factory ProductListState.initial() = ProductListInitial;

  /// Products are being fetched from the repository.
  const factory ProductListState.loading() = ProductListLoading;

  /// Products have been successfully loaded.
  ///
  /// [products] is the filtered/searched list currently displayed.
  /// [allProducts] is the complete unfiltered list (kept for re-filtering).
  /// [searchQuery] is the current search string (empty if none).
  /// [selectedCategory] is the current category filter (null if none).
  const factory ProductListState.loaded({
    required List<Product> products,
    required List<Product> allProducts,
    @Default('') String searchQuery,
    ProductCategory? selectedCategory,
  }) = ProductListLoaded;

  /// An error occurred while loading products.
  const factory ProductListState.error(String message) = ProductListError;
}

// Alternative: Single state class with status enum:
// enum ProductListStatus { initial, loading, loaded, error }
// class ProductListState extends Equatable {
//   final ProductListStatus status;
//   final List<Product> products;
//   final String? errorMessage;
//   ...
// }
