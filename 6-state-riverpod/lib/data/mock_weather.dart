// =============================================================================
// Mock Weather Data — static fake data used instead of a real API
// =============================================================================
//
// All temperatures are in Celsius. The repository layer adds simulated delays
// and random failures on top of this data to mimic real network behaviour.
// =============================================================================

import 'package:state_riverpod_tutorial/models/models.dart';

// ---------------------------------------------------------------------------
// Predefined cities
// ---------------------------------------------------------------------------

/// All cities available in the mock data set.
///
/// The keys match [City.id] for O(1) lookups.
final Map<String, City> mockCities = {
  'new-york': const City(
    id: 'new-york',
    name: 'New York',
    country: 'US',
    latitude: 40.7128,
    longitude: -74.0060,
  ),
  'london': const City(
    id: 'london',
    name: 'London',
    country: 'GB',
    latitude: 51.5074,
    longitude: -0.1278,
  ),
  'tokyo': const City(
    id: 'tokyo',
    name: 'Tokyo',
    country: 'JP',
    latitude: 35.6762,
    longitude: 139.6503,
  ),
  'paris': const City(
    id: 'paris',
    name: 'Paris',
    country: 'FR',
    latitude: 48.8566,
    longitude: 2.3522,
  ),
  'sydney': const City(
    id: 'sydney',
    name: 'Sydney',
    country: 'AU',
    latitude: -33.8688,
    longitude: 151.2093,
  ),
  'mexico-city': const City(
    id: 'mexico-city',
    name: 'Mexico City',
    country: 'MX',
    latitude: 19.4326,
    longitude: -99.1332,
  ),
  'berlin': const City(
    id: 'berlin',
    name: 'Berlin',
    country: 'DE',
    latitude: 52.5200,
    longitude: 13.4050,
  ),
  'mumbai': const City(
    id: 'mumbai',
    name: 'Mumbai',
    country: 'IN',
    latitude: 19.0760,
    longitude: 72.8777,
  ),
};

// ---------------------------------------------------------------------------
// Current weather for each city
// ---------------------------------------------------------------------------

/// Returns mock current weather for a given [cityId].
///
/// Returns `null` if the city is not in the data set.
Weather? mockWeatherForCity(String cityId) {
  final data = <String, Weather>{
    'new-york': Weather(
      cityId: 'new-york',
      temperatureCelsius: 22.0,
      feelsLikeCelsius: 24.0,
      humidity: 65,
      windSpeedKmh: 15.0,
      condition: WeatherCondition.partlyCloudy,
      description: 'Partly cloudy with mild temperatures',
      timestamp: DateTime.now(),
    ),
    'london': Weather(
      cityId: 'london',
      temperatureCelsius: 14.0,
      feelsLikeCelsius: 12.0,
      humidity: 80,
      windSpeedKmh: 20.0,
      condition: WeatherCondition.rainy,
      description: 'Light rain expected throughout the day',
      timestamp: DateTime.now(),
    ),
    'tokyo': Weather(
      cityId: 'tokyo',
      temperatureCelsius: 28.0,
      feelsLikeCelsius: 31.0,
      humidity: 70,
      windSpeedKmh: 10.0,
      condition: WeatherCondition.sunny,
      description: 'Clear skies and warm',
      timestamp: DateTime.now(),
    ),
    'paris': Weather(
      cityId: 'paris',
      temperatureCelsius: 18.0,
      feelsLikeCelsius: 17.0,
      humidity: 55,
      windSpeedKmh: 12.0,
      condition: WeatherCondition.cloudy,
      description: 'Overcast but dry',
      timestamp: DateTime.now(),
    ),
    'sydney': Weather(
      cityId: 'sydney',
      temperatureCelsius: 25.0,
      feelsLikeCelsius: 27.0,
      humidity: 60,
      windSpeedKmh: 18.0,
      condition: WeatherCondition.sunny,
      description: 'Bright sunshine and warm breezes',
      timestamp: DateTime.now(),
    ),
    'mexico-city': Weather(
      cityId: 'mexico-city',
      temperatureCelsius: 20.0,
      feelsLikeCelsius: 19.0,
      humidity: 45,
      windSpeedKmh: 8.0,
      condition: WeatherCondition.partlyCloudy,
      description: 'Pleasant with scattered clouds',
      timestamp: DateTime.now(),
    ),
    'berlin': Weather(
      cityId: 'berlin',
      temperatureCelsius: 10.0,
      feelsLikeCelsius: 7.0,
      humidity: 75,
      windSpeedKmh: 25.0,
      condition: WeatherCondition.foggy,
      description: 'Foggy morning, clearing by afternoon',
      timestamp: DateTime.now(),
    ),
    'mumbai': Weather(
      cityId: 'mumbai',
      temperatureCelsius: 33.0,
      feelsLikeCelsius: 38.0,
      humidity: 85,
      windSpeedKmh: 5.0,
      condition: WeatherCondition.stormy,
      description: 'Hot and humid, thunderstorms likely',
      timestamp: DateTime.now(),
    ),
  };

  return data[cityId];
}

// ---------------------------------------------------------------------------
// 5-day forecast for each city
// ---------------------------------------------------------------------------

/// Generates a mock 5-day forecast for [cityId].
///
/// Forecasts are deterministic — the same city always returns the same data.
List<DailyForecast>? mockForecastForCity(String cityId) {
  // Base conditions per city; we shift temperatures day by day
  final baseConditions = <String, List<_ForecastSeed>>{
    'new-york': [
      _ForecastSeed(22, 15, WeatherCondition.partlyCloudy, 20),
      _ForecastSeed(24, 17, WeatherCondition.sunny, 10),
      _ForecastSeed(20, 14, WeatherCondition.rainy, 60),
      _ForecastSeed(18, 12, WeatherCondition.cloudy, 40),
      _ForecastSeed(21, 14, WeatherCondition.partlyCloudy, 25),
    ],
    'london': [
      _ForecastSeed(14, 9, WeatherCondition.rainy, 70),
      _ForecastSeed(13, 8, WeatherCondition.rainy, 80),
      _ForecastSeed(15, 10, WeatherCondition.cloudy, 50),
      _ForecastSeed(16, 11, WeatherCondition.partlyCloudy, 30),
      _ForecastSeed(14, 10, WeatherCondition.rainy, 65),
    ],
    'tokyo': [
      _ForecastSeed(28, 22, WeatherCondition.sunny, 5),
      _ForecastSeed(30, 24, WeatherCondition.sunny, 0),
      _ForecastSeed(27, 21, WeatherCondition.partlyCloudy, 15),
      _ForecastSeed(25, 20, WeatherCondition.rainy, 55),
      _ForecastSeed(26, 21, WeatherCondition.partlyCloudy, 20),
    ],
    'paris': [
      _ForecastSeed(18, 12, WeatherCondition.cloudy, 35),
      _ForecastSeed(20, 13, WeatherCondition.partlyCloudy, 20),
      _ForecastSeed(22, 15, WeatherCondition.sunny, 5),
      _ForecastSeed(19, 13, WeatherCondition.cloudy, 40),
      _ForecastSeed(17, 11, WeatherCondition.rainy, 60),
    ],
    'sydney': [
      _ForecastSeed(25, 19, WeatherCondition.sunny, 5),
      _ForecastSeed(27, 20, WeatherCondition.sunny, 0),
      _ForecastSeed(24, 18, WeatherCondition.partlyCloudy, 15),
      _ForecastSeed(23, 17, WeatherCondition.cloudy, 30),
      _ForecastSeed(26, 19, WeatherCondition.sunny, 10),
    ],
    'mexico-city': [
      _ForecastSeed(20, 12, WeatherCondition.partlyCloudy, 25),
      _ForecastSeed(22, 13, WeatherCondition.sunny, 10),
      _ForecastSeed(21, 13, WeatherCondition.cloudy, 35),
      _ForecastSeed(19, 11, WeatherCondition.rainy, 55),
      _ForecastSeed(20, 12, WeatherCondition.partlyCloudy, 30),
    ],
    'berlin': [
      _ForecastSeed(10, 4, WeatherCondition.foggy, 40),
      _ForecastSeed(12, 5, WeatherCondition.cloudy, 35),
      _ForecastSeed(11, 3, WeatherCondition.rainy, 60),
      _ForecastSeed(9, 2, WeatherCondition.snowy, 70),
      _ForecastSeed(8, 1, WeatherCondition.cloudy, 45),
    ],
    'mumbai': [
      _ForecastSeed(33, 27, WeatherCondition.stormy, 75),
      _ForecastSeed(34, 28, WeatherCondition.rainy, 65),
      _ForecastSeed(32, 26, WeatherCondition.cloudy, 50),
      _ForecastSeed(31, 26, WeatherCondition.partlyCloudy, 35),
      _ForecastSeed(33, 27, WeatherCondition.sunny, 20),
    ],
  };

  final seeds = baseConditions[cityId];
  if (seeds == null) return null;

  final today = DateTime.now();
  return List.generate(5, (i) {
    final seed = seeds[i];
    return DailyForecast(
      date: today.add(Duration(days: i + 1)),
      highCelsius: seed.high.toDouble(),
      lowCelsius: seed.low.toDouble(),
      condition: seed.condition,
      description: _descriptionFor(seed.condition),
      precipitationChance: seed.precipChance,
    );
  });
}

// ---------------------------------------------------------------------------
// Internal helpers
// ---------------------------------------------------------------------------

/// Seed data for a single forecast day.
class _ForecastSeed {
  final int high;
  final int low;
  final WeatherCondition condition;
  final int precipChance;

  const _ForecastSeed(this.high, this.low, this.condition, this.precipChance);
}

/// Maps a [WeatherCondition] to a short text description.
String _descriptionFor(WeatherCondition condition) {
  switch (condition) {
    case WeatherCondition.sunny:
      return 'Clear and sunny';
    case WeatherCondition.partlyCloudy:
      return 'Partly cloudy';
    case WeatherCondition.cloudy:
      return 'Overcast skies';
    case WeatherCondition.rainy:
      return 'Rain expected';
    case WeatherCondition.stormy:
      return 'Thunderstorms likely';
    case WeatherCondition.snowy:
      return 'Snow showers';
    case WeatherCondition.foggy:
      return 'Foggy conditions';
  }
}
