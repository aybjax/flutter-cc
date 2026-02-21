// =============================================================================
// Forecast List Widget — horizontal scrollable 5-day forecast
// =============================================================================
//
// Watches a FutureProvider.family for the forecast data and renders each day
// as a column in a horizontally scrolling list.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:state_riverpod_tutorial/models/models.dart';
import 'package:state_riverpod_tutorial/providers/weather_providers.dart';
import 'package:state_riverpod_tutorial/widgets/temperature_display.dart';

// ---------------------------------------------------------------------------
// ForecastList
// ---------------------------------------------------------------------------

/// A horizontal list of 5-day forecast cards for [cityId].
///
/// Uses [ConsumerWidget] to watch the [forecastProvider] and handle all three
/// async states (loading, data, error) via `AsyncValue.when`.
class ForecastList extends ConsumerWidget {
  /// Creates a [ForecastList].
  const ForecastList({super.key, required this.cityId});

  /// The city whose forecast to display.
  final String cityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncForecast = ref.watch(forecastProvider(cityId));

    return asyncForecast.when(
      // -------------------------------------------------------------------
      // Data state
      // -------------------------------------------------------------------
      data: (forecast) => SizedBox(
        height: 160,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: forecast.length,
          separatorBuilder: (_, _) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final day = forecast[index];
            return _ForecastDayCard(day: day);
          },
        ),
      ),

      // -------------------------------------------------------------------
      // Loading state
      // -------------------------------------------------------------------
      loading: () => const SizedBox(
        height: 160,
        child: Center(child: CircularProgressIndicator()),
      ),

      // -------------------------------------------------------------------
      // Error state
      // -------------------------------------------------------------------
      error: (error, stack) => SizedBox(
        height: 160,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.red),
              const SizedBox(height: 8),
              Text(error.toString()),
              TextButton(
                // ref.invalidate re-triggers the FutureProvider
                onPressed: () => ref.invalidate(forecastProvider(cityId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Single forecast day card (private)
// ---------------------------------------------------------------------------

/// A single day column inside the horizontal forecast list.
class _ForecastDayCard extends ConsumerWidget {
  const _ForecastDayCard({required this.day});

  final DailyForecast day;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Format the date as abbreviated weekday (Mon, Tue, ...)
    final dayLabel = DateFormat.E().format(day.date);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Day name
            Text(
              dayLabel,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),

            // Condition icon
            Icon(
              _forecastIconFor(day.condition),
              size: 32,
            ),
            const SizedBox(height: 8),

            // High temperature
            TemperatureDisplay(
              celsius: day.highCelsius,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            // Low temperature (dimmed)
            TemperatureDisplay(
              celsius: day.lowCelsius,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
            ),

            const SizedBox(height: 4),

            // Precipitation chance
            Text(
              '${day.precipitationChance}%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.blue,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Icon mapping for forecast conditions
// ---------------------------------------------------------------------------

IconData _forecastIconFor(WeatherCondition condition) {
  switch (condition) {
    case WeatherCondition.sunny:
      return Icons.wb_sunny;
    case WeatherCondition.partlyCloudy:
      return Icons.cloud_queue;
    case WeatherCondition.cloudy:
      return Icons.cloud;
    case WeatherCondition.rainy:
      return Icons.umbrella;
    case WeatherCondition.stormy:
      return Icons.thunderstorm;
    case WeatherCondition.snowy:
      return Icons.ac_unit;
    case WeatherCondition.foggy:
      return Icons.foggy;
  }
}
