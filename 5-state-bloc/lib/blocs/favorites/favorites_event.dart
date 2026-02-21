// =============================================================================
// Favorites Events - Events for managing favorite products
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_bloc_tutorial/models/models.dart';

part 'favorites_event.freezed.dart';

// ---------------------------------------------------------------------------
// FavoritesEvent union
// ---------------------------------------------------------------------------

/// Events for the favorites BLoC.
///
/// Simple toggle-based API: adding a product that's already a favorite
/// removes it, and vice versa.
@freezed
sealed class FavoritesEvent with _$FavoritesEvent {
  /// Toggle a product's favorite status.
  ///
  /// If the product is already in favorites, it will be removed.
  /// If it is not in favorites, it will be added.
  const factory FavoritesEvent.toggleFavorite(Product product) =
      ToggleFavorite;

  /// Remove a product from favorites by its ID.
  const factory FavoritesEvent.removeFavorite(String productId) =
      RemoveFavorite;

  /// Clear all favorites.
  const factory FavoritesEvent.clearFavorites() = ClearFavorites;
}
