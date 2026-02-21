// =============================================================================
// Forecast Model — daily forecast entry for a city
// =============================================================================
//
// Represents a single day's forecast within a multi-day outlook. The app
// fetches a list of these for the "5-Day Forecast" widget.
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_riverpod_tutorial/models/weather.dart';

part 'forecast.freezed.dart';
part 'forecast.g.dart';

// ---------------------------------------------------------------------------
// Daily forecast data class
// ---------------------------------------------------------------------------

/// A single day's weather forecast.
///
/// Contains high/low temperatures (always Celsius) and the dominant condition.
@freezed
abstract class DailyForecast with _$DailyForecast {
  /// Creates a [DailyForecast] instance.
  const factory DailyForecast({
    /// The date this forecast is for.
    required DateTime date,

    /// High temperature in Celsius.
    required double highCelsius,

    /// Low temperature in Celsius.
    required double lowCelsius,

    /// Dominant weather condition for the day.
    required WeatherCondition condition,

    /// Short description (e.g. "Sunny with light breeze").
    required String description,

    /// Probability of precipitation as a percentage (0-100).
    required int precipitationChance,
  }) = _DailyForecast;

  /// Deserializes a [DailyForecast] from a JSON map.
  factory DailyForecast.fromJson(Map<String, dynamic> json) =>
      _$DailyForecastFromJson(json);
}

// Alternative: instead of @freezed you could use Dart 3 records for simple
// data transport:
//
// typedef DailyForecast = ({
//   DateTime date,
//   double highCelsius,
//   double lowCelsius,
//   WeatherCondition condition,
//   String description,
//   int precipitationChance,
// });
//
// Records give structural equality but lack JSON serialization and copyWith.
