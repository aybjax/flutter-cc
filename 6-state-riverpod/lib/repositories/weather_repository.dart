// =============================================================================
// Weather Repository — data access layer returning Either results
// =============================================================================
//
// Wraps mock data with simulated network latency and occasional failures.
// Every public method returns `Either<WeatherFailure, T>` from the dartz
// package, enforcing explicit error handling at the call site.
//
// The repository is injected into providers via a plain `Provider`, making it
// easy to override in tests.
// =============================================================================

import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:state_riverpod_tutorial/data/mock_weather.dart';
import 'package:state_riverpod_tutorial/models/models.dart';

// ---------------------------------------------------------------------------
// WeatherRepository
// ---------------------------------------------------------------------------

/// Provides weather data with simulated delays and failures.
///
/// All temperatures are returned in Celsius; conversion to the user's
/// preferred unit happens in the provider / presentation layer.
class WeatherRepository {
  /// Random number generator for simulating failures.
  final _random = Random();

  // -------------------------------------------------------------------------
  // Search cities
  // -------------------------------------------------------------------------

  /// Searches the mock city list by name (case-insensitive substring match).
  ///
  /// Returns a [Right] containing matching [City] objects, or a [Left]
  /// containing a [WeatherFailure] if a simulated error occurs.
  Future<Either<WeatherFailure, List<City>>> searchCities(String query) async {
    // Simulate network latency (300-800 ms)
    await _simulateLatency();

    // ~5 % chance of a simulated network error
    if (_shouldFail(5)) {
      return const Left(
        WeatherFailure.networkError(message: 'Simulated network timeout'),
      );
    }

    final lowerQuery = query.toLowerCase();
    final results = mockCities.values
        .where((city) => city.name.toLowerCase().contains(lowerQuery))
        .toList();

    return Right(results);
  }

  // -------------------------------------------------------------------------
  // Current weather
  // -------------------------------------------------------------------------

  /// Fetches the current weather for [cityId].
  ///
  /// Returns [Left] with [CityNotFound] if the city ID is unknown, or
  /// [Left] with [NetworkError] on simulated failures.
  Future<Either<WeatherFailure, Weather>> getCurrentWeather(
    String cityId,
  ) async {
    await _simulateLatency();

    if (_shouldFail(5)) {
      return const Left(
        WeatherFailure.networkError(message: 'Simulated connection refused'),
      );
    }

    final weather = mockWeatherForCity(cityId);
    if (weather == null) {
      return Left(WeatherFailure.cityNotFound(cityName: cityId));
    }

    return Right(weather);
  }

  // -------------------------------------------------------------------------
  // 5-day forecast
  // -------------------------------------------------------------------------

  /// Fetches a 5-day forecast for [cityId].
  ///
  /// Works the same as [getCurrentWeather] but returns a list of
  /// [DailyForecast] objects.
  Future<Either<WeatherFailure, List<DailyForecast>>> getForecast(
    String cityId,
  ) async {
    await _simulateLatency();

    if (_shouldFail(5)) {
      return const Left(
        WeatherFailure.serverError(statusCode: 503),
      );
    }

    final forecast = mockForecastForCity(cityId);
    if (forecast == null) {
      return Left(WeatherFailure.cityNotFound(cityName: cityId));
    }

    return Right(forecast);
  }

  // -------------------------------------------------------------------------
  // Weather stream (for StreamProvider demo)
  // -------------------------------------------------------------------------

  /// Emits a new [Weather] snapshot every [interval] for [cityId].
  ///
  /// This simulates a push-based data source (e.g. WebSocket). Each emission
  /// slightly randomises the temperature to mimic real-time updates.
  Stream<Weather> weatherStream(
    String cityId, {
    Duration interval = const Duration(seconds: 5),
  }) async* {
    final base = mockWeatherForCity(cityId);
    if (base == null) return;

    // Emit an initial value immediately
    yield base;

    // Then emit updates at the given interval
    while (true) {
      await Future.delayed(interval);

      // Jitter the temperature by +/- 2 degrees to simulate live data
      final jitter = (_random.nextDouble() * 4) - 2; // range: -2..+2
      yield base.copyWith(
        temperatureCelsius: base.temperatureCelsius + jitter,
        timestamp: DateTime.now(),
      );
    }
  }

  // -------------------------------------------------------------------------
  // Private helpers
  // -------------------------------------------------------------------------

  /// Simulates 300-800 ms of network latency.
  Future<void> _simulateLatency() async {
    final delay = 300 + _random.nextInt(500);
    await Future.delayed(Duration(milliseconds: delay));
  }

  /// Returns `true` with [percentChance]% probability.
  bool _shouldFail(int percentChance) {
    return _random.nextInt(100) < percentChance;
  }
}

// Alternative: you could define the repository as an abstract interface and
// provide a concrete implementation, making it easier to swap for tests:
//
// abstract class WeatherRepositoryBase {
//   Future<Either<WeatherFailure, Weather>> getCurrentWeather(String cityId);
//   ...
// }
//
// class MockWeatherRepository extends WeatherRepositoryBase { ... }
// class RealWeatherRepository extends WeatherRepositoryBase { ... }
