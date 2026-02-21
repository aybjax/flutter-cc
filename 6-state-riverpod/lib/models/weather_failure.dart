// =============================================================================
// Weather Failure — freezed union type for domain errors
// =============================================================================
//
// Using a sealed union (freezed's `@freezed` with multiple constructors) to
// model all the things that can go wrong when fetching weather data.
// The repository returns Either<WeatherFailure, T> from dartz.
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_failure.freezed.dart';

// ---------------------------------------------------------------------------
// Failure union type
// ---------------------------------------------------------------------------

/// Represents everything that can go wrong during a weather data operation.
///
/// Pattern-match on the variants using `when` / `map` / `maybeWhen`:
/// ```dart
/// failure.when(
///   cityNotFound: (city) => 'City "$city" not found',
///   networkError: (msg)  => 'Network error: $msg',
///   serverError: (code)  => 'Server error ($code)',
///   unknown: (e)         => 'Unknown: $e',
/// );
/// ```
@freezed
sealed class WeatherFailure with _$WeatherFailure {
  /// The searched city does not exist in our data set.
  const factory WeatherFailure.cityNotFound({required String cityName}) =
      CityNotFound;

  /// A simulated network failure.
  const factory WeatherFailure.networkError({required String message}) =
      NetworkError;

  /// A simulated server-side failure.
  const factory WeatherFailure.serverError({required int statusCode}) =
      ServerError;

  /// Catch-all for unexpected failures.
  const factory WeatherFailure.unknown({required String message}) =
      UnknownFailure;
}

// Alternative: plain abstract class hierarchy without freezed:
//
// sealed class WeatherFailure {
//   const WeatherFailure();
// }
// class CityNotFound extends WeatherFailure {
//   final String cityName;
//   const CityNotFound(this.cityName);
// }
// class NetworkError extends WeatherFailure {
//   final String message;
//   const NetworkError(this.message);
// }
// ...
// Then use switch (failure) { case CityNotFound(:final cityName): ... }
