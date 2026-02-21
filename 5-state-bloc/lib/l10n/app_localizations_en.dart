// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Product Catalog';

  @override
  String get searchHint => 'Search products...';

  @override
  String get filterByCategory => 'Filter by category';

  @override
  String get allCategories => 'All Categories';

  @override
  String get favorites => 'Favorites';

  @override
  String get cart => 'Cart';

  @override
  String get addToCart => 'Add to Cart';

  @override
  String get removeFromCart => 'Remove from Cart';

  @override
  String get addToFavorites => 'Add to Favorites';

  @override
  String get removeFromFavorites => 'Remove from Favorites';

  @override
  String get emptyFavorites => 'No favorites yet';

  @override
  String get emptyCart => 'Your cart is empty';

  @override
  String get total => 'Total';

  @override
  String get checkout => 'Checkout';

  @override
  String get products => 'Products';

  @override
  String get price => 'Price';

  @override
  String get category => 'Category';

  @override
  String get description => 'Description';

  @override
  String get quantity => 'Quantity';

  @override
  String get noResults => 'No products found';

  @override
  String get loading => 'Loading...';

  @override
  String get errorOccurred => 'An error occurred';

  @override
  String get retry => 'Retry';

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
      zero: 'No items',
    );
    return '$_temp0';
  }

  @override
  String cartTotal(String total) {
    return 'Cart Total: $total';
  }
}
