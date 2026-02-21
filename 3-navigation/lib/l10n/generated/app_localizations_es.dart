// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Lector de Noticias';

  @override
  String articlesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count artículos',
      one: '1 artículo',
      zero: 'Sin artículos',
    );
    return '$_temp0';
  }

  @override
  String get categories => 'Categorías';

  @override
  String get articles => 'Artículos';

  @override
  String get search => 'Buscar artículos...';

  @override
  String get profile => 'Perfil';

  @override
  String get settings => 'Configuración';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get defaultNav => 'Navigator';

  @override
  String get goRouterNav => 'GoRouter';

  @override
  String get autoRouteNav => 'AutoRoute';

  @override
  String get readMore => 'Leer más';

  @override
  String get back => 'Volver';

  @override
  String get noResults => 'No se encontraron artículos';

  @override
  String get language => 'Idioma';

  @override
  String get loginRequired => 'Inicie sesión para acceder a esta página';

  @override
  String welcomeBack(String name) {
    return '¡Bienvenido de nuevo, $name!';
  }
}
