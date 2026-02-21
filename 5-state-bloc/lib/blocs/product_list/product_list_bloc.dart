// =============================================================================
// ProductList BLoC - Business logic for browsing, searching, filtering
// =============================================================================
// Demonstrates:
// - Bloc<Event, State> pattern with on<Event> handlers
// - EventTransformer for debouncing search (bloc_concurrency)
// - Restartable transformer for category filtering
// - Repository injection for testability
// =============================================================================

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:state_bloc_tutorial/repositories/product_repository.dart';
import 'product_list_event.dart';
import 'product_list_state.dart';

// ---------------------------------------------------------------------------
// Debounce EventTransformer
// ---------------------------------------------------------------------------

/// Creates a debounced [EventTransformer] that waits [duration] before
/// processing the latest event, dropping intermediate events.
///
/// This prevents excessive repository calls while the user types
/// in the search field. Only the last event within the duration window
/// is processed.
EventTransformer<E> debounce<E>(Duration duration) {
  return (events, mapper) {
    return events.debounce(duration).switchMap(mapper);
  };
}

// Alternative: You could use restartable() from bloc_concurrency directly,
// which cancels the previous handler when a new event arrives:
// transformer: restartable()

// ---------------------------------------------------------------------------
// ProductListBloc
// ---------------------------------------------------------------------------

/// BLoC that manages the product list, search, and category filtering.
///
/// Event handlers:
/// - [LoadProducts] -> fetches all products from repository
/// - [SearchProducts] -> debounced search with 300ms delay
/// - [FilterByCategory] -> restartable category filter
/// - [ClearFilters] -> resets to full product list
class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  /// The repository used to fetch product data.
  final ProductRepository _repository;

  /// Creates a [ProductListBloc] with the given [repository].
  ProductListBloc({required ProductRepository repository})
      : _repository = repository,
        super(const ProductListState.initial()) {
    // Register event handlers with their transformers
    on<LoadProducts>(_onLoadProducts);

    // Debounce search events by 300ms to avoid excessive calls
    on<SearchProducts>(
      _onSearchProducts,
      transformer: debounce(const Duration(milliseconds: 300)),
    );

    // Use restartable() for category filter - cancels previous if new arrives
    on<FilterByCategory>(
      _onFilterByCategory,
      transformer: restartable(),
    );

    on<ClearFilters>(_onClearFilters);
  }

  // ---------------------------------------------------------------------------
  // Event handlers
  // ---------------------------------------------------------------------------

  /// Handles [LoadProducts] by fetching all products from the repository.
  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductListState> emit,
  ) async {
    emit(const ProductListState.loading());

    final result = await _repository.getProducts();

    // Use dartz Either.fold to handle success/failure
    result.fold(
      (failure) => emit(
        ProductListState.error(
          failure.when(
            networkError: (msg) => 'Network error: $msg',
            serverError: (code, msg) => 'Server error ($code): $msg',
            parseError: (msg) => 'Parse error: $msg',
            notFound: (id) => 'Not found: $id',
            unexpected: (msg) => 'Unexpected error: $msg',
          ),
        ),
      ),
      (products) => emit(
        ProductListState.loaded(
          products: products,
          allProducts: products,
        ),
      ),
    );
  }

  /// Handles [SearchProducts] with debouncing.
  ///
  /// Filters the cached [allProducts] list by the search query.
  /// If the query is empty, restores the full list (respecting category filter).
  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<ProductListState> emit,
  ) async {
    final currentState = state;

    // Only search if products are already loaded
    if (currentState is! ProductListLoaded) {
      return;
    }

    final query = event.query.toLowerCase();
    final category = currentState.selectedCategory;

    // Filter from the complete list
    final filtered = currentState.allProducts.where((product) {
      // Match name or description
      final matchesQuery = query.isEmpty ||
          product.name.toLowerCase().contains(query) ||
          product.description.toLowerCase().contains(query);

      // Respect active category filter
      final matchesCategory =
          category == null || product.category == category;

      return matchesQuery && matchesCategory;
    }).toList();

    emit(currentState.copyWith(
      products: filtered,
      searchQuery: event.query,
    ));
  }

  /// Handles [FilterByCategory] using restartable transformer.
  ///
  /// If category is null, clears the filter. Otherwise filters
  /// by the selected category (also respecting search query).
  Future<void> _onFilterByCategory(
    FilterByCategory event,
    Emitter<ProductListState> emit,
  ) async {
    final currentState = state;

    if (currentState is! ProductListLoaded) {
      return;
    }

    final query = currentState.searchQuery.toLowerCase();
    final category = event.category;

    // Re-filter from the complete list
    final filtered = currentState.allProducts.where((product) {
      final matchesQuery = query.isEmpty ||
          product.name.toLowerCase().contains(query) ||
          product.description.toLowerCase().contains(query);

      final matchesCategory =
          category == null || product.category == category;

      return matchesQuery && matchesCategory;
    }).toList();

    emit(currentState.copyWith(
      products: filtered,
      selectedCategory: category,
    ));
  }

  /// Handles [ClearFilters] by resetting search and category.
  Future<void> _onClearFilters(
    ClearFilters event,
    Emitter<ProductListState> emit,
  ) async {
    final currentState = state;

    if (currentState is! ProductListLoaded) {
      return;
    }

    emit(ProductListState.loaded(
      products: currentState.allProducts,
      allProducts: currentState.allProducts,
    ));
  }
}

// Alternative: For simpler state management without events, use Cubit:
// class ProductListCubit extends Cubit<ProductListState> {
//   ProductListCubit(this._repository) : super(const ProductListState.initial());
//   final ProductRepository _repository;
//   Future<void> loadProducts() async { ... emit(...); }
//   void search(String query) { ... emit(...); }
// }
