// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Catálogo de Productos';

  @override
  String get searchHint => 'Buscar productos...';

  @override
  String get filterByCategory => 'Filtrar por categoría';

  @override
  String get allCategories => 'Todas las Categorías';

  @override
  String get favorites => 'Favoritos';

  @override
  String get cart => 'Carrito';

  @override
  String get addToCart => 'Añadir al Carrito';

  @override
  String get removeFromCart => 'Quitar del Carrito';

  @override
  String get addToFavorites => 'Añadir a Favoritos';

  @override
  String get removeFromFavorites => 'Quitar de Favoritos';

  @override
  String get emptyFavorites => 'No hay favoritos aún';

  @override
  String get emptyCart => 'Tu carrito está vacío';

  @override
  String get total => 'Total';

  @override
  String get checkout => 'Comprar';

  @override
  String get products => 'Productos';

  @override
  String get price => 'Precio';

  @override
  String get category => 'Categoría';

  @override
  String get description => 'Descripción';

  @override
  String get quantity => 'Cantidad';

  @override
  String get noResults => 'No se encontraron productos';

  @override
  String get loading => 'Cargando...';

  @override
  String get errorOccurred => 'Ocurrió un error';

  @override
  String get retry => 'Reintentar';

  @override
  String itemCount(int count) {
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
  String cartTotal(String total) {
    return 'Total del Carrito: $total';
  }
}
