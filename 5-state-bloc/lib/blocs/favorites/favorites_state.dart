// =============================================================================
// Favorites State - State for the favorites BLoC
// =============================================================================
// Uses @freezed for immutability. Must support JSON serialization
// because FavoritesBloc extends HydratedBloc (state is persisted).
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_bloc_tutorial/models/models.dart';

part 'favorites_state.freezed.dart';
part 'favorites_state.g.dart';

// ---------------------------------------------------------------------------
// FavoritesState
// ---------------------------------------------------------------------------

/// State for the favorites BLoC.
///
/// Must be JSON-serializable because [FavoritesBloc] extends [HydratedBloc],
/// which persists state to local storage and restores it on app restart.
@freezed
abstract class FavoritesState with _$FavoritesState {
  /// Creates a favorites state with the given list of favorite products.
  const factory FavoritesState({
    @Default([]) List<Product> favorites,
  }) = _FavoritesState;

  // Private constructor for custom getters
  const FavoritesState._();

  // ---------------------------------------------------------------------------
  // Helper methods
  // ---------------------------------------------------------------------------

  /// Whether the product with [productId] is in the favorites list.
  bool isFavorite(String productId) {
    return favorites.any((p) => p.id == productId);
  }

  /// The total number of favorite products.
  int get count => favorites.length;

  /// Creates a [FavoritesState] from a JSON map (required by HydratedBloc).
  factory FavoritesState.fromJson(Map<String, dynamic> json) =>
      _$FavoritesStateFromJson(json);
}
