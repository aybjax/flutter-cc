// =============================================================================
// Traditional Riverpod Providers — one of each provider type
// =============================================================================
//
// This file demonstrates every "classic" (non-code-gen) provider type that
// ships with flutter_riverpod. Each section explains WHEN and WHY to pick
// that particular type.
//
// Provider type cheat-sheet:
// ┌──────────────────────────┬──────────────────────────────────────────────┐
// │ Type                     │ Use case                                     │
// ├──────────────────────────┼──────────────────────────────────────────────┤
// │ Provider                 │ Read-only value / dependency injection       │
// │ StateProvider            │ Simple mutable primitive (bool, int, enum)   │
// │ FutureProvider           │ One-shot async fetch                         │
// │ StreamProvider           │ Reactive / push-based data                   │
// │ StateNotifierProvider    │ Complex mutable state with business logic    │
// │ NotifierProvider         │ Modern replacement for StateNotifierProvider │
// │ AsyncNotifierProvider    │ Like NotifierProvider but for async state    │
// └──────────────────────────┴──────────────────────────────────────────────┘
// =============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_riverpod_tutorial/models/models.dart';
import 'package:state_riverpod_tutorial/repositories/weather_repository.dart';

// =============================================================================
// 1. Provider — read-only, computed or injected value
// =============================================================================
//
// `Provider` never changes on its own. It is perfect for:
//  - Injecting a singleton service (repository, logger, analytics).
//  - Deriving / computing a value from other providers.
//
// Think of it as the Riverpod equivalent of `ProxyProvider` in package:provider.
// ---------------------------------------------------------------------------

/// Provides a single [WeatherRepository] instance to the widget tree.
///
/// Override this in tests to inject a fake repository:
/// ```dart
/// ProviderScope(
///   overrides: [
///     weatherRepositoryProvider.overrideWithValue(FakeWeatherRepository()),
///   ],
///   child: MyApp(),
/// )
/// ```
final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  // The repository is stateless so a single instance is fine.
  return WeatherRepository();
});

// Alternative: you could use `Provider.autoDispose` if the repo held resources
// that need cleanup (e.g. an HTTP client):
//
// final weatherRepositoryProvider = Provider.autoDispose<WeatherRepository>((ref) {
//   final repo = WeatherRepository();
//   ref.onDispose(() => repo.dispose());
//   return repo;
// });

// =============================================================================
// 2. StateProvider — simplest mutable state
// =============================================================================
//
// `StateProvider` wraps a single value and exposes it via `ref.watch` /
// `ref.read`. Mutations happen through `ref.read(p.notifier).state = ...`.
//
// Best for: toggles, enums, counters, search queries — anything where the
// "business logic" is just "set the value".
// ---------------------------------------------------------------------------

/// The user's chosen temperature unit (Celsius or Fahrenheit).
///
/// Widgets toggle this with:
/// ```dart
/// ref.read(temperatureUnitProvider.notifier).state = TemperatureUnit.fahrenheit;
/// ```
final temperatureUnitProvider = StateProvider<TemperatureUnit>((ref) {
  return TemperatureUnit.celsius; // default
});

/// The current search query typed into the city search field.
///
/// This is watched by the search-results provider to reactively filter cities.
final searchQueryProvider = StateProvider<String>((ref) {
  return ''; // start empty
});

/// Currently selected city ID (e.g. "new-york").
///
/// `null` means no city is selected yet (show the home screen prompt).
final selectedCityIdProvider = StateProvider<String?>((ref) {
  return null;
});

// Alternative: for more complex state you'd switch to StateNotifierProvider
// (see section 5) or NotifierProvider (see weather_notifiers.dart).

// =============================================================================
// 3. FutureProvider — one-shot async data
// =============================================================================
//
// `FutureProvider` is like `FutureBuilder` but with caching, deduplication,
// and the full power of `ref` for reading other providers.
//
// The provider automatically exposes `AsyncValue<T>`, giving you `.when()`
// for loading / data / error states.
//
// Use `autoDispose` to discard the result when no widget is listening.
// Use `family` to parameterise by an argument (here: the city ID).
// ---------------------------------------------------------------------------

/// Fetches the current weather for a specific city.
///
/// This is a `FutureProvider.autoDispose.family` — the three modifiers mean:
///  - `autoDispose`: the future is cancelled & cache dropped when the last
///    listener goes away (e.g. user navigates back).
///  - `family`: each unique [cityId] gets its own cached provider instance.
///
/// Usage in a widget:
/// ```dart
/// final asyncWeather = ref.watch(currentWeatherProvider('london'));
/// asyncWeather.when(
///   data: (weather) => Text('${weather.temperatureCelsius}°C'),
///   loading: () => CircularProgressIndicator(),
///   error: (e, st) => Text('Error: $e'),
/// );
/// ```
final currentWeatherProvider = FutureProvider.autoDispose
    .family<Weather, String>((ref, cityId) async {
  final repo = ref.watch(weatherRepositoryProvider);
  final result = await repo.getCurrentWeather(cityId);

  // Convert Either<WeatherFailure, Weather> into a thrown exception or value.
  // FutureProvider already catches exceptions and wraps them in AsyncError.
  return result.fold(
    (failure) => throw _failureToException(failure),
    (weather) => weather,
  );
});

/// Fetches a 5-day forecast for [cityId], auto-disposing when unused.
final forecastProvider = FutureProvider.autoDispose
    .family<List<DailyForecast>, String>((ref, cityId) async {
  final repo = ref.watch(weatherRepositoryProvider);
  final result = await repo.getForecast(cityId);

  return result.fold(
    (failure) => throw _failureToException(failure),
    (forecast) => forecast,
  );
});

/// Searches cities based on the current [searchQueryProvider] value.
///
/// Because this provider reads [searchQueryProvider], it automatically
/// re-runs whenever the search query changes — no manual wiring needed.
final searchResultsProvider =
    FutureProvider.autoDispose<List<City>>((ref) async {
  final query = ref.watch(searchQueryProvider);

  // Don't hit the "API" for very short queries
  if (query.length < 2) return [];

  final repo = ref.watch(weatherRepositoryProvider);
  final result = await repo.searchCities(query);

  return result.fold(
    (failure) => throw _failureToException(failure),
    (cities) => cities,
  );
});

// =============================================================================
// 4. StreamProvider — reactive / push-based data
// =============================================================================
//
// `StreamProvider` wraps a `Stream<T>` and exposes `AsyncValue<T>`.
// Perfect for WebSocket feeds, Firestore snapshots, or any push-based source.
//
// Each emission rebuilds only the widgets that `ref.watch` this provider.
// ---------------------------------------------------------------------------

/// A live-updating weather stream for [cityId].
///
/// Emits a new [Weather] object every 5 seconds with slight temperature
/// jitter, simulating a real-time data source.
///
/// `autoDispose` ensures the stream subscription is cancelled when the
/// detail screen is popped.
final liveWeatherProvider = StreamProvider.autoDispose
    .family<Weather, String>((ref, cityId) {
  final repo = ref.watch(weatherRepositoryProvider);
  return repo.weatherStream(cityId);
});

// Alternative: if you need to combine multiple streams, you can use
// `StreamProvider` with `ref.watch` on other StreamProviders:
//
// final combinedProvider = StreamProvider<CombinedData>((ref) async* {
//   await for (final weather in ref.watch(liveWeatherProvider('london').stream)) {
//     final alerts = await fetchAlerts(weather);
//     yield CombinedData(weather: weather, alerts: alerts);
//   }
// });

// =============================================================================
// Helper
// =============================================================================

/// Converts a [WeatherFailure] to an [Exception] so that `FutureProvider` /
/// `StreamProvider` can catch it and surface it as `AsyncError`.
Exception _failureToException(WeatherFailure failure) {
  return failure.when(
    cityNotFound: (city) => Exception('City "$city" not found'),
    networkError: (msg) => Exception('Network error: $msg'),
    serverError: (code) => Exception('Server error ($code)'),
    unknown: (msg) => Exception(msg),
  );
}
