// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Panel del Clima';

  @override
  String get search => 'Buscar';

  @override
  String get searchCity => 'Buscar una ciudad...';

  @override
  String get favorites => 'Favoritos';

  @override
  String get settings => 'Configuración';

  @override
  String get temperatureUnit => 'Unidad de Temperatura';

  @override
  String get celsius => 'Celsius';

  @override
  String get fahrenheit => 'Fahrenheit';

  @override
  String get currentWeather => 'Clima Actual';

  @override
  String get forecast => 'Pronóstico de 5 Días';

  @override
  String get humidity => 'Humedad';

  @override
  String get windSpeed => 'Velocidad del Viento';

  @override
  String get feelsLike => 'Sensación Térmica';

  @override
  String get noFavorites => 'Aún no hay ciudades favoritas';

  @override
  String get addToFavorites => 'Añadir a Favoritos';

  @override
  String get removeFromFavorites => 'Quitar de Favoritos';

  @override
  String get cityNotFound => 'Ciudad no encontrada';

  @override
  String get networkError => 'Error de red';

  @override
  String get unknownError => 'Ocurrió un error desconocido';

  @override
  String get retry => 'Reintentar';

  @override
  String get loading => 'Cargando...';

  @override
  String get language => 'Idioma';

  @override
  String get english => 'Inglés';

  @override
  String get spanish => 'Español';

  @override
  String get today => 'Hoy';

  @override
  String temperatureWithUnit(String temp, String unit) {
    return '$temp°$unit';
  }

  @override
  String weatherIn(String city) {
    return 'Clima en $city';
  }

  @override
  String lastUpdated(String time) {
    return 'Última actualización: $time';
  }
}
