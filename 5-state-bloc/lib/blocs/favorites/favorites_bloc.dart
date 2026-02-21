// =============================================================================
// Favorites BLoC - HydratedBloc for persisting favorites across restarts
// =============================================================================
// Demonstrates:
// - HydratedBloc: Automatically persists and restores state
// - fromJson/toJson: Required overrides for serialization
// - Sequential transformer: Ensures events are processed in order
// =============================================================================

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'favorites_event.dart';
import 'favorites_state.dart';

// ---------------------------------------------------------------------------
// FavoritesBloc
// ---------------------------------------------------------------------------

/// BLoC that manages the user's favorite products.
///
/// Extends [HydratedBloc] instead of regular [Bloc] to automatically
/// persist favorites to local storage. When the app restarts, the
/// previous favorites state is restored from storage.
///
/// How HydratedBloc works:
/// 1. On state change, [toJson] serializes the state to a Map
/// 2. The Map is stored in local storage (via HydratedStorage)
/// 3. On next app launch, [fromJson] deserializes the stored Map
/// 4. The restored state becomes the initial state
class FavoritesBloc extends HydratedBloc<FavoritesEvent, FavoritesState> {
  /// Creates a [FavoritesBloc] with an empty initial state.
  ///
  /// Note: If persisted state exists, HydratedBloc will override this
  /// initial state with the restored state from storage.
  FavoritesBloc() : super(const FavoritesState()) {
    // Use sequential() to process events in order (important for toggle logic)
    on<ToggleFavorite>(
      _onToggleFavorite,
      transformer: sequential(),
    );
    on<RemoveFavorite>(_onRemoveFavorite);
    on<ClearFavorites>(_onClearFavorites);
  }

  // ---------------------------------------------------------------------------
  // Event handlers
  // ---------------------------------------------------------------------------

  /// Toggles a product's favorite status.
  ///
  /// If the product is already in favorites, remove it.
  /// Otherwise, add it to the list.
  void _onToggleFavorite(
    ToggleFavorite event,
    Emitter<FavoritesState> emit,
  ) {
    final product = event.product;

    if (state.isFavorite(product.id)) {
      // Remove from favorites
      emit(FavoritesState(
        favorites:
            state.favorites.where((p) => p.id != product.id).toList(),
      ));
    } else {
      // Add to favorites
      emit(FavoritesState(
        favorites: [...state.favorites, product],
      ));
    }
  }

  /// Removes a product from favorites by its ID.
  void _onRemoveFavorite(
    RemoveFavorite event,
    Emitter<FavoritesState> emit,
  ) {
    emit(FavoritesState(
      favorites:
          state.favorites.where((p) => p.id != event.productId).toList(),
    ));
  }

  /// Clears all favorites.
  void _onClearFavorites(
    ClearFavorites event,
    Emitter<FavoritesState> emit,
  ) {
    emit(const FavoritesState());
  }

  // ---------------------------------------------------------------------------
  // HydratedBloc overrides (required for persistence)
  // ---------------------------------------------------------------------------

  /// Deserializes the persisted JSON map into a [FavoritesState].
  ///
  /// Called automatically by HydratedBloc when the app starts.
  /// Returns null if deserialization fails (falls back to initial state).
  @override
  FavoritesState? fromJson(Map<String, dynamic> json) {
    try {
      return FavoritesState.fromJson(json);
    } catch (_) {
      // If stored data is corrupted, start fresh
      return null;
    }
  }

  /// Serializes the current [FavoritesState] to a JSON map.
  ///
  /// Called automatically by HydratedBloc on every state change.
  @override
  Map<String, dynamic>? toJson(FavoritesState state) {
    try {
      return state.toJson();
    } catch (_) {
      // If serialization fails, don't persist
      return null;
    }
  }
}

// Alternative: Using a regular Bloc with manual SharedPreferences:
// class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
//   final SharedPreferences _prefs;
//   FavoritesBloc(this._prefs) : super(FavoritesState.initial()) {
//     on<ToggleFavorite>((event, emit) {
//       // ... update state ...
//       _prefs.setString('favorites', jsonEncode(state.toJson()));
//     });
//   }
// }
