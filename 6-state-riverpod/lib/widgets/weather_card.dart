// =============================================================================
// Weather Card Widget — displays current weather summary for a city
// =============================================================================
//
// A self-contained ConsumerWidget that fetches and displays weather data for
// one city. Demonstrates `ref.watch` on a FutureProvider.family, and the
// `AsyncValue.when` pattern for handling loading / data / error states.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_riverpod_tutorial/data/mock_weather.dart';
import 'package:state_riverpod_tutorial/models/models.dart';
import 'package:state_riverpod_tutorial/providers/weather_providers.dart';
import 'package:state_riverpod_tutorial/widgets/temperature_display.dart';

// ---------------------------------------------------------------------------
// WeatherCard
// ---------------------------------------------------------------------------

/// A card showing the current weather for a single city.
///
/// Taps navigate to the detail screen. The card uses a [FutureProvider] with
/// `family` to fetch data for its specific [cityId].
class WeatherCard extends ConsumerWidget {
  /// Creates a [WeatherCard].
  const WeatherCard({
    super.key,
    required this.cityId,
    this.onTap,
  });

  /// The city to display weather for.
  final String cityId;

  /// Callback when the card is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the FutureProvider.family — Riverpod caches by cityId
    final asyncWeather = ref.watch(currentWeatherProvider(cityId));

    // Look up the city object for display name
    final city = mockCities[cityId];
    final cityName = city?.name ?? cityId;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: asyncWeather.when(
            // -----------------------------------------------------------------
            // Data state — weather loaded successfully
            // -----------------------------------------------------------------
            data: (weather) => Row(
              children: [
                // Weather condition icon
                Icon(
                  _iconForCondition(weather.condition),
                  size: 48,
                  color: _colorForCondition(weather.condition),
                ),
                const SizedBox(width: 16),

                // City name and description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cityName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        weather.description,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),

                // Temperature (unit-aware)
                TemperatureDisplay(celsius: weather.temperatureCelsius),
              ],
            ),

            // -----------------------------------------------------------------
            // Loading state
            // -----------------------------------------------------------------
            loading: () => ListTile(
              leading: const SizedBox(
                width: 48,
                height: 48,
                child: Center(child: CircularProgressIndicator()),
              ),
              title: Text(cityName),
              subtitle: const Text('Loading...'),
            ),

            // -----------------------------------------------------------------
            // Error state — show message with a retry button
            // -----------------------------------------------------------------
            error: (error, stack) => ListTile(
              leading: const Icon(Icons.error_outline, size: 48, color: Colors.red),
              title: Text(cityName),
              subtitle: Text(error.toString()),
              trailing: IconButton(
                icon: const Icon(Icons.refresh),
                // ref.invalidate forces the provider to re-execute
                onPressed: () => ref.invalidate(currentWeatherProvider(cityId)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Condition -> icon mapping
// ---------------------------------------------------------------------------

/// Maps a [WeatherCondition] to a Material icon.
IconData _iconForCondition(WeatherCondition condition) {
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

/// Maps a [WeatherCondition] to a colour for the icon.
Color _colorForCondition(WeatherCondition condition) {
  switch (condition) {
    case WeatherCondition.sunny:
      return Colors.orange;
    case WeatherCondition.partlyCloudy:
      return Colors.blueGrey;
    case WeatherCondition.cloudy:
      return Colors.grey;
    case WeatherCondition.rainy:
      return Colors.blue;
    case WeatherCondition.stormy:
      return Colors.deepPurple;
    case WeatherCondition.snowy:
      return Colors.lightBlue;
    case WeatherCondition.foggy:
      return Colors.brown;
  }
}
