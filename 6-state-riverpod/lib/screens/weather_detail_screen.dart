// =============================================================================
// Weather Detail Screen — full weather view for a single city
// =============================================================================
//
// Demonstrates:
//  - FutureProvider.family (one-shot fetch with city ID parameter)
//  - StreamProvider.family (live-updating weather stream)
//  - ref.refresh to force a new fetch
//  - ConsumerWidget vs Consumer (inline) usage
//  - Combining multiple providers in one screen
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_riverpod_tutorial/l10n/app_localizations.dart';
import 'package:state_riverpod_tutorial/data/mock_weather.dart';
import 'package:state_riverpod_tutorial/models/models.dart';
import 'package:state_riverpod_tutorial/providers/weather_notifiers.dart';
import 'package:state_riverpod_tutorial/providers/weather_providers.dart';
import 'package:state_riverpod_tutorial/widgets/forecast_list.dart';
import 'package:state_riverpod_tutorial/widgets/temperature_display.dart';

// ---------------------------------------------------------------------------
// WeatherDetailScreen
// ---------------------------------------------------------------------------

/// Shows detailed weather for a city, including current conditions,
/// a live-updating temperature, and a 5-day forecast.
class WeatherDetailScreen extends ConsumerWidget {
  /// Creates a [WeatherDetailScreen].
  const WeatherDetailScreen({super.key, required this.cityId});

  /// The city to show weather for.
  final String cityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final city = mockCities[cityId];
    final cityName = city?.name ?? cityId;

    // Watch the one-shot current weather provider
    final asyncWeather = ref.watch(currentWeatherProvider(cityId));

    // Watch the live stream for real-time temperature updates
    final asyncLive = ref.watch(liveWeatherProvider(cityId));

    // Check if this city is a favourite
    final isFavorite = ref.watch(isCityFavoriteProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.weatherIn(cityName)),
        actions: [
          // Favourite toggle button
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            tooltip: isFavorite
                ? l10n.removeFromFavorites
                : l10n.addToFavorites,
            onPressed: () {
              if (city != null) {
                ref.read(favoriteCitiesProvider.notifier).toggleCity(city);
              }
            },
          ),

          // Refresh button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // ref.refresh returns the new value; ref.invalidate just
              // discards the cache. Both cause a re-fetch.
              ref.invalidate(currentWeatherProvider(cityId));
              ref.invalidate(forecastProvider(cityId));
            },
          ),
        ],
      ),

      body: asyncWeather.when(
        // -------------------------------------------------------------------
        // Data state
        // -------------------------------------------------------------------
        data: (weather) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =============================================================
              // Current weather hero section
              // =============================================================
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Condition icon (large)
                      Icon(
                        _iconForCondition(weather.condition),
                        size: 80,
                        color: _colorForCondition(weather.condition),
                      ),
                      const SizedBox(height: 16),

                      // Main temperature
                      TemperatureDisplay(
                        celsius: weather.temperatureCelsius,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 8),

                      // Description
                      Text(
                        weather.description,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),

                      // -------------------------------------------------------
                      // Detail row: feels like, humidity, wind
                      // -------------------------------------------------------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _DetailChip(
                            icon: Icons.thermostat,
                            label: l10n.feelsLike,
                            child: TemperatureDisplay(
                              celsius: weather.feelsLikeCelsius,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          _DetailChip(
                            icon: Icons.water_drop,
                            label: l10n.humidity,
                            child: Text('${weather.humidity}%'),
                          ),
                          _DetailChip(
                            icon: Icons.air,
                            label: l10n.windSpeed,
                            child: Text(
                                '${weather.windSpeedKmh.toStringAsFixed(0)} km/h'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // =============================================================
              // Live weather stream section
              // =============================================================
              // This section uses the StreamProvider to show real-time updates.
              // The inline Consumer widget limits rebuilds to just this part.
              Text(
                'Live Temperature',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),

              // Using an inline Consumer instead of making the whole screen
              // a ConsumerWidget — this way only this card rebuilds on
              // stream emissions, not the entire page.
              //
              // Alternative: you could make this a separate ConsumerWidget
              // class for the same effect.
              Card(
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: asyncLive.when(
                    data: (liveWeather) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Streaming every 5s'),
                            const SizedBox(height: 4),
                            Text(
                              l10n.lastUpdated(
                                '${liveWeather.timestamp.hour}:${liveWeather.timestamp.minute.toString().padLeft(2, '0')}:${liveWeather.timestamp.second.toString().padLeft(2, '0')}',
                              ),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        TemperatureDisplay(
                          celsius: liveWeather.temperatureCelsius,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                              ),
                        ),
                      ],
                    ),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (e, st) => Text('Stream error: $e'),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // =============================================================
              // 5-day forecast section
              // =============================================================
              Text(
                l10n.forecast,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              ForecastList(cityId: cityId),

              const SizedBox(height: 32),
            ],
          ),
        ),

        // -------------------------------------------------------------------
        // Loading state
        // -------------------------------------------------------------------
        loading: () => const Center(child: CircularProgressIndicator()),

        // -------------------------------------------------------------------
        // Error state
        // -------------------------------------------------------------------
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 80, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    ref.invalidate(currentWeatherProvider(cityId));
                  },
                  icon: const Icon(Icons.refresh),
                  label: Text(l10n.retry),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Detail chip (private helper widget)
// ---------------------------------------------------------------------------

/// A small column showing an icon, a label, and a value.
class _DetailChip extends StatelessWidget {
  const _DetailChip({
    required this.icon,
    required this.label,
    required this.child,
  });

  final IconData icon;
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 24, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 2),
        child,
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Condition -> icon / colour helpers (duplicated from weather_card for
// encapsulation; in production you'd extract to a shared utility)
// ---------------------------------------------------------------------------

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
