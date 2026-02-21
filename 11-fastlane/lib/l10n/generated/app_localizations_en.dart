// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Fastlane Tutorial';

  @override
  String get environmentLabel => 'Environment';

  @override
  String get flavorLabel => 'Flavor';

  @override
  String get apiUrlLabel => 'API URL';

  @override
  String get versionLabel => 'Version';

  @override
  String get appNameLabel => 'App Name';

  @override
  String get buildModeLabel => 'Build Mode';

  @override
  String get configurationTitle => 'Configuration Details';
}
