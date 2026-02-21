// =============================================================================
// Weather Model — current weather snapshot for a city
// =============================================================================
//
// Immutable via @freezed. Temperature is always stored in Celsius internally;
// conversion to Fahrenheit happens in the presentation layer (providers or
// widgets), keeping the data layer unit-agnostic.
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather.freezed.dart';
part 'weather.g.dart';

// ---------------------------------------------------------------------------
// Temperature unit enum
// ---------------------------------------------------------------------------

/// The user's preferred temperature unit.
///
/// Stored in a [StateProvider] so any widget can toggle it.
enum TemperatureUnit {
  /// Degrees Celsius.
  celsius,

  /// Degrees Fahrenheit.
  fahrenheit,
}

// ---------------------------------------------------------------------------
// Weather condition enum
// ---------------------------------------------------------------------------

/// High-level weather condition used for display icons.
enum WeatherCondition {
  sunny,
  partlyCloudy,
  cloudy,
  rainy,
  stormy,
  snowy,
  foggy,
}

// ---------------------------------------------------------------------------
// Weather data class
// ---------------------------------------------------------------------------

/// Current weather information for a single city.
///
/// All temperatures are in Celsius. Use [convertTemp] for unit conversion.
@freezed
abstract class Weather with _$Weather {
  /// Creates a [Weather] instance.
  const factory Weather({
    /// The city ID this weather belongs to.
    required String cityId,

    /// Temperature in Celsius.
    required double temperatureCelsius,

    /// "Feels like" temperature in Celsius.
    required double feelsLikeCelsius,

    /// Relative humidity as a percentage (0-100).
    required int humidity,

    /// Wind speed in km/h.
    required double windSpeedKmh,

    /// General weather condition.
    required WeatherCondition condition,

    /// Short human-readable description (e.g. "Partly cloudy").
    required String description,

    /// Timestamp when this data was "fetched".
    required DateTime timestamp,
  }) = _Weather;

  /// Deserializes a [Weather] from a JSON map.
  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}

// ---------------------------------------------------------------------------
// Temperature conversion helper
// ---------------------------------------------------------------------------

/// Converts a temperature from Celsius to the given [unit].
///
/// Formula: F = C * 9/5 + 32
double convertTemp(double celsius, TemperatureUnit unit) {
  switch (unit) {
    case TemperatureUnit.celsius:
      return celsius;
    case TemperatureUnit.fahrenheit:
      // Standard Celsius-to-Fahrenheit conversion
      return celsius * 9.0 / 5.0 + 32.0;
  }
}

/// Returns the short label for a [TemperatureUnit] ("C" or "F").
String unitLabel(TemperatureUnit unit) {
  switch (unit) {
    case TemperatureUnit.celsius:
      return 'C';
    case TemperatureUnit.fahrenheit:
      return 'F';
  }
}
