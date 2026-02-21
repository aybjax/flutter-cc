// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Weather Dashboard';

  @override
  String get search => 'Search';

  @override
  String get searchCity => 'Search for a city...';

  @override
  String get favorites => 'Favorites';

  @override
  String get settings => 'Settings';

  @override
  String get temperatureUnit => 'Temperature Unit';

  @override
  String get celsius => 'Celsius';

  @override
  String get fahrenheit => 'Fahrenheit';

  @override
  String get currentWeather => 'Current Weather';

  @override
  String get forecast => '5-Day Forecast';

  @override
  String get humidity => 'Humidity';

  @override
  String get windSpeed => 'Wind Speed';

  @override
  String get feelsLike => 'Feels Like';

  @override
  String get noFavorites => 'No favorite cities yet';

  @override
  String get addToFavorites => 'Add to Favorites';

  @override
  String get removeFromFavorites => 'Remove from Favorites';

  @override
  String get cityNotFound => 'City not found';

  @override
  String get networkError => 'Network error occurred';

  @override
  String get unknownError => 'An unknown error occurred';

  @override
  String get retry => 'Retry';

  @override
  String get loading => 'Loading...';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get spanish => 'Spanish';

  @override
  String get today => 'Today';

  @override
  String temperatureWithUnit(String temp, String unit) {
    return '$temp°$unit';
  }

  @override
  String weatherIn(String city) {
    return 'Weather in $city';
  }

  @override
  String lastUpdated(String time) {
    return 'Last updated: $time';
  }
}
