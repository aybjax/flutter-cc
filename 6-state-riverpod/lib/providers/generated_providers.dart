// =============================================================================
// Generated Providers — using @riverpod annotation (riverpod_generator)
// =============================================================================
//
// `riverpod_generator` lets you write plain Dart functions / classes and
// annotate them with `@riverpod`. The generator then creates the appropriate
// provider type automatically (Provider, FutureProvider, NotifierProvider,
// etc.) based on the function signature.
//
// Benefits:
//  - Less boilerplate — no manual `Provider<X>((ref) => ...)`.
//  - Automatically chooses `autoDispose` (the default).
//  - Family modifiers are derived from function parameters.
//  - Strong typing — the generator catches mismatches at build time.
//
// To regenerate after changes:
//   dart run build_runner build --delete-conflicting-outputs
// =============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:state_riverpod_tutorial/models/models.dart';
import 'package:state_riverpod_tutorial/providers/weather_providers.dart';

part 'generated_providers.g.dart';

// =============================================================================
// Generated plain Provider (synchronous, read-only)
// =============================================================================
//
// A function annotated with @riverpod becomes an auto-dispose Provider.
// Because it returns a value synchronously, the generator picks `Provider`.
// ---------------------------------------------------------------------------

/// Returns a greeting string that includes the currently selected city.
///
/// Demonstrates a simple generated provider that reads other providers.
@riverpod
String weatherGreeting(Ref ref) {
  final cityId = ref.watch(selectedCityIdProvider);
  if (cityId == null) return 'Select a city to see the weather!';
  // Capitalise city name for display
  final displayName = cityId.replaceAll('-', ' ').split(' ').map((word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1);
  }).join(' ');
  return 'Weather in $displayName';
}

// Alternative (non-generated equivalent):
//
// final weatherGreetingProvider = Provider.autoDispose<String>((ref) {
//   final cityId = ref.watch(selectedCityIdProvider);
//   if (cityId == null) return 'Select a city to see the weather!';
//   return 'Weather in $cityId';
// });

// =============================================================================
// Generated FutureProvider with family parameter
// =============================================================================
//
// When the function is `async` / returns `Future<T>`, the generator creates
// a `FutureProvider`. Parameters beyond `ref` become `family` arguments.
// ---------------------------------------------------------------------------

/// Fetches weather for [cityId] — generated equivalent of
/// [currentWeatherProvider] from weather_providers.dart.
///
/// The `cityId` parameter automatically makes this a `.family` provider.
@riverpod
Future<Weather> generatedWeather(Ref ref, String cityId) async {
  final repo = ref.watch(weatherRepositoryProvider);
  final result = await repo.getCurrentWeather(cityId);

  return result.fold(
    (failure) => throw Exception(
      failure.when(
        cityNotFound: (city) => 'City "$city" not found',
        networkError: (msg) => 'Network: $msg',
        serverError: (code) => 'Server: $code',
        unknown: (msg) => msg,
      ),
    ),
    (weather) => weather,
  );
}

// =============================================================================
// Generated StreamProvider
// =============================================================================
//
// When the function returns `Stream<T>`, the generator creates a
// `StreamProvider`. Combined with a parameter, it becomes
// `StreamProvider.autoDispose.family`.
// ---------------------------------------------------------------------------

/// Live weather stream for [cityId] — generated version.
@riverpod
Stream<Weather> generatedLiveWeather(
  Ref ref,
  String cityId,
) {
  final repo = ref.watch(weatherRepositoryProvider);
  return repo.weatherStream(cityId);
}

// =============================================================================
// Generated Notifier (class-based)
// =============================================================================
//
// Annotating a *class* that extends `_$ClassName` with `@riverpod` generates
// a NotifierProvider (or AsyncNotifierProvider if build() is async).
//
// The class must:
//  1. Extend the generated `_$ClassName` base class.
//  2. Implement a `build()` method returning the initial state.
// ---------------------------------------------------------------------------

/// Manages a simple counter for demonstration purposes.
///
/// Shows that @riverpod class-based providers are equivalent to
/// `NotifierProvider.autoDispose`.
@riverpod
class DemoCounter extends _$DemoCounter {
  /// Initial value.
  @override
  int build() => 0;

  /// Increments the counter.
  void increment() => state++;

  /// Decrements the counter.
  void decrement() => state--;

  /// Resets to zero.
  void reset() => state = 0;
}

// Alternative (non-generated equivalent):
//
// class DemoCounterNotifier extends AutoDisposeNotifier<int> {
//   @override
//   int build() => 0;
//   void increment() => state++;
// }
// final demoCounterProvider =
//     NotifierProvider.autoDispose<DemoCounterNotifier, int>(
//         DemoCounterNotifier.new);

// =============================================================================
// Generated AsyncNotifier (class-based)
// =============================================================================
//
// When the class's `build()` method returns a `Future<T>`, the generator
// creates an `AsyncNotifierProvider`. The state is `AsyncValue<T>`.
// ---------------------------------------------------------------------------

/// Manages a forecast that is loaded asynchronously.
///
/// Demonstrates a generated `AsyncNotifierProvider.autoDispose.family`.
@riverpod
class GeneratedForecast extends _$GeneratedForecast {
  /// Loads the 5-day forecast for the given [cityId].
  @override
  Future<List<DailyForecast>> build(String cityId) async {
    final repo = ref.watch(weatherRepositoryProvider);
    final result = await repo.getForecast(cityId);

    return result.fold(
      (failure) => throw Exception(
        failure.when(
          cityNotFound: (city) => 'City "$city" not found',
          networkError: (msg) => 'Network: $msg',
          serverError: (code) => 'Server: $code',
          unknown: (msg) => msg,
        ),
      ),
      (forecast) => forecast,
    );
  }

  /// Triggers a refresh — sets state to loading then re-builds.
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => build(cityId));
  }
}

// Alternative (non-generated equivalent):
//
// class GeneratedForecastNotifier
//     extends AutoDisposeFamilyAsyncNotifier<List<DailyForecast>, String> {
//   @override
//   Future<List<DailyForecast>> build(String arg) async { ... }
// }
// final generatedForecastProvider = AsyncNotifierProvider.autoDispose
//     .family<GeneratedForecastNotifier, List<DailyForecast>, String>(
//         GeneratedForecastNotifier.new);
