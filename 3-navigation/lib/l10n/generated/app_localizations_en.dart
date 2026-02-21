// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'News Reader';

  @override
  String articlesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count articles',
      one: '1 article',
      zero: 'No articles',
    );
    return '$_temp0';
  }

  @override
  String get categories => 'Categories';

  @override
  String get articles => 'Articles';

  @override
  String get search => 'Search articles...';

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get defaultNav => 'Navigator';

  @override
  String get goRouterNav => 'GoRouter';

  @override
  String get autoRouteNav => 'AutoRoute';

  @override
  String get readMore => 'Read More';

  @override
  String get back => 'Back';

  @override
  String get noResults => 'No articles found';

  @override
  String get language => 'Language';

  @override
  String get loginRequired => 'Please log in to access this page';

  @override
  String welcomeBack(String name) {
    return 'Welcome back, $name!';
  }
}
