// =============================================================================
// Notifier-based Providers — StateNotifier, Notifier, AsyncNotifier
// =============================================================================
//
// When your state is more than a single primitive (e.g. a list of favourites
// with add/remove/reorder operations), you graduate from StateProvider to a
// *Notifier. This file shows all three flavours:
//
//  1. StateNotifierProvider  — the legacy (but still widely used) approach.
//  2. NotifierProvider        — the modern Riverpod 2 replacement.
//  3. AsyncNotifierProvider   — like Notifier but with async initial state.
//
// All three serve the same purpose: encapsulating state + business logic in a
// class, then exposing the state reactively to widgets.
// =============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_riverpod_tutorial/models/models.dart';
import 'package:state_riverpod_tutorial/providers/weather_providers.dart';

// =============================================================================
// 5. StateNotifierProvider — legacy but common
// =============================================================================
//
// `StateNotifier<T>` holds a single `state` of type T. You expose methods that
// replace `state` with a new immutable value — Riverpod diffs and rebuilds.
//
// StateNotifierProvider was the go-to before Riverpod 2 introduced `Notifier`.
// You will still see it in many codebases and packages.
// ---------------------------------------------------------------------------

/// Manages the list of favourite cities.
///
/// State is `List<City>` — each mutation creates a new list (immutable style).
class FavoriteCitiesNotifier extends StateNotifier<List<City>> {
  /// Starts with an empty favourites list.
  FavoriteCitiesNotifier() : super([]);

  /// Adds [city] to favourites if not already present.
  void addCity(City city) {
    // Guard against duplicates using the city ID
    if (state.any((c) => c.id == city.id)) return;

    // Create a NEW list — never mutate state in place
    state = [...state, city];
  }

  /// Removes the city with [cityId] from favourites.
  void removeCity(String cityId) {
    state = state.where((c) => c.id != cityId).toList();
  }

  /// Toggles a city in/out of the favourites list.
  void toggleCity(City city) {
    if (state.any((c) => c.id == city.id)) {
      removeCity(city.id);
    } else {
      addCity(city);
    }
  }

  /// Returns `true` if [cityId] is currently a favourite.
  bool isFavorite(String cityId) {
    return state.any((c) => c.id == cityId);
  }
}

/// Provider for [FavoriteCitiesNotifier].
///
/// Widgets read the list with `ref.watch(favoriteCitiesProvider)` and mutate
/// it through `ref.read(favoriteCitiesProvider.notifier).addCity(...)`.
final favoriteCitiesProvider =
    StateNotifierProvider<FavoriteCitiesNotifier, List<City>>((ref) {
  return FavoriteCitiesNotifier();
});

// Alternative: you could persist favourites to SharedPreferences by reading
// a persistence provider inside the notifier constructor and saving on each
// state change:
//
// class FavoriteCitiesNotifier extends StateNotifier<List<City>> {
//   final SharedPreferences _prefs;
//   FavoriteCitiesNotifier(this._prefs) : super(_loadFromPrefs(_prefs));
//   void addCity(City city) {
//     state = [...state, city];
//     _prefs.setStringList('favs', state.map((c) => c.id).toList());
//   }
//   ...
// }

// =============================================================================
// 6. NotifierProvider — modern Riverpod 2 approach (synchronous state)
// =============================================================================
//
// `Notifier<T>` is the recommended replacement for `StateNotifier<T>`.
// Key differences:
//  - Has access to `ref` (can read other providers).
//  - Uses `build()` instead of a constructor for initial state.
//  - No need for a separate `super(initialState)` call.
//
// Use NotifierProvider when the initial state is synchronous.
// ---------------------------------------------------------------------------

/// Manages the list of recently viewed cities (up to 5).
///
/// Demonstrates `Notifier` with `ref` access — we could read other providers
/// inside `build()` or methods if needed.
class RecentCitiesNotifier extends Notifier<List<City>> {
  /// Initial state: empty list.
  @override
  List<City> build() {
    return [];
  }

  /// Records [city] as recently viewed.
  ///
  /// Moves it to the front if already present; trims to 5 entries.
  void addCity(City city) {
    final filtered = state.where((c) => c.id != city.id).toList();
    state = [city, ...filtered].take(5).toList();
  }

  /// Clears the recent history.
  void clear() {
    state = [];
  }
}

/// Provider for [RecentCitiesNotifier].
final recentCitiesProvider =
    NotifierProvider<RecentCitiesNotifier, List<City>>(
  RecentCitiesNotifier.new,
);

// Alternative: using `Notifier.autoDispose` — the recent list would be wiped
// when nobody watches it:
//
// class RecentCitiesNotifier extends AutoDisposeNotifier<List<City>> { ... }
// final recentCitiesProvider =
//     NotifierProvider.autoDispose<RecentCitiesNotifier, List<City>>(...);

// =============================================================================
// 7. AsyncNotifierProvider — async initial state
// =============================================================================
//
// `AsyncNotifier<T>` is like `Notifier<T>` but `build()` returns a
// `Future<T>`. The state is exposed as `AsyncValue<T>`, giving you
// loading / data / error for free.
//
// Use it when:
//  - The initial state must be fetched asynchronously (API call, database).
//  - You still need methods to mutate state after it loads.
// ---------------------------------------------------------------------------

/// Loads current weather for the selected city and provides mutation methods.
///
/// This is an `AsyncNotifier` parameterised via `family` so each city gets
/// its own independent notifier instance.
class CityWeatherNotifier
    extends AutoDisposeFamilyAsyncNotifier<Weather, String> {
  /// Fetches the initial weather data for [arg] (the city ID).
  @override
  Future<Weather> build(String arg) async {
    final repo = ref.watch(weatherRepositoryProvider);
    final result = await repo.getCurrentWeather(arg);

    return result.fold(
      (failure) => throw Exception(
        failure.when(
          cityNotFound: (city) => 'City "$city" not found',
          networkError: (msg) => 'Network error: $msg',
          serverError: (code) => 'Server error ($code)',
          unknown: (msg) => msg,
        ),
      ),
      (weather) => weather,
    );
  }

  /// Manually refreshes the weather data.
  ///
  /// Sets state to loading, re-fetches, then updates. Widgets watching this
  /// provider will see the loading -> data transition automatically.
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => build(arg));
  }
}

/// Provider for [CityWeatherNotifier].
///
/// Usage:
/// ```dart
/// final asyncWeather = ref.watch(cityWeatherProvider('tokyo'));
/// ```
final cityWeatherProvider = AsyncNotifierProvider.autoDispose
    .family<CityWeatherNotifier, Weather, String>(
  CityWeatherNotifier.new,
);

// =============================================================================
// Derived / Computed Providers
// =============================================================================
//
// You can compose providers by reading other providers inside a Provider body.
// This is one of Riverpod's super-powers — fine-grained, lazy recomputation.
// ---------------------------------------------------------------------------

/// Returns `true` when the selected city is in the favourites list.
///
/// This is a *derived* provider — it reads two other providers and recomputes
/// whenever either changes, without any manual subscription management.
final isCityFavoriteProvider = Provider.autoDispose<bool>((ref) {
  final selectedId = ref.watch(selectedCityIdProvider);
  final favorites = ref.watch(favoriteCitiesProvider);

  if (selectedId == null) return false;
  return favorites.any((c) => c.id == selectedId);
});

/// The number of favourite cities — a trivial derived provider.
final favoritesCountProvider = Provider<int>((ref) {
  return ref.watch(favoriteCitiesProvider).length;
});
