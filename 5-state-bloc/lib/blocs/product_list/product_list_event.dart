// =============================================================================
// ProductList Events - All events the ProductListBloc can handle
// =============================================================================
// Uses @freezed for immutable, equatable event classes with union types.
// Each event represents a user action or system trigger.
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_bloc_tutorial/models/models.dart';

part 'product_list_event.freezed.dart';

// ---------------------------------------------------------------------------
// ProductListEvent union
// ---------------------------------------------------------------------------

/// Events for the product list BLoC.
///
/// Using freezed unions allows exhaustive handling in the BLoC's
/// event handlers and provides built-in equality/hashCode.
@freezed
sealed class ProductListEvent with _$ProductListEvent {
  /// Load all products from the repository.
  const factory ProductListEvent.loadProducts() = LoadProducts;

  /// Search products with a query string.
  ///
  /// This event uses a debounced EventTransformer to avoid
  /// excessive API calls while the user is typing.
  const factory ProductListEvent.searchProducts(String query) = SearchProducts;

  /// Filter products by category.
  ///
  /// Pass `null` to clear the category filter.
  const factory ProductListEvent.filterByCategory(ProductCategory? category) =
      FilterByCategory;

  /// Clear all filters and search, resetting to the full product list.
  const factory ProductListEvent.clearFilters() = ClearFilters;
}

// Alternative: You could define events as individual classes:
// abstract class ProductListEvent extends Equatable { ... }
// class LoadProducts extends ProductListEvent { ... }
// class SearchProducts extends ProductListEvent {
//   final String query;
//   SearchProducts(this.query);
//   @override List<Object?> get props => [query];
// }
