import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Todo App'**
  String get appTitle;

  /// Shows the number of todos with plural support
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No todos} =1{1 todo} other{{count} todos}}'**
  String todosCount(int count);

  /// Login button and screen title
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Register button and screen title
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// Logout button label
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Label for email field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Label for password field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Link to registration screen
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Register'**
  String get noAccount;

  /// Link to login screen
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Login'**
  String get hasAccount;

  /// Button label to add a new todo
  ///
  /// In en, this message translates to:
  /// **'Add Todo'**
  String get addTodo;

  /// Title for edit todo screen
  ///
  /// In en, this message translates to:
  /// **'Edit Todo'**
  String get editTodo;

  /// Button label to delete a todo
  ///
  /// In en, this message translates to:
  /// **'Delete Todo'**
  String get deleteTodo;

  /// Confirmation dialog message for deleting a todo
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{title}\"?'**
  String confirmDelete(String title);

  /// Label for title field
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// Label for description field
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// Save button label
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Cancel button label
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Empty state message
  ///
  /// In en, this message translates to:
  /// **'No todos yet. Tap + to add one!'**
  String get noTodosYet;

  /// Snackbar message after saving
  ///
  /// In en, this message translates to:
  /// **'Todo saved successfully!'**
  String get todoSaved;

  /// Snackbar message after deleting
  ///
  /// In en, this message translates to:
  /// **'Todo deleted'**
  String get todoDeleted;

  /// Validation error for empty required fields
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get errorRequired;

  /// Validation error for malformed email
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get errorInvalidEmail;

  /// Network error message
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your connection.'**
  String get errorNetwork;

  /// Server error message
  ///
  /// In en, this message translates to:
  /// **'Server error. Please try again later.'**
  String get errorServer;

  /// Unauthorized error message
  ///
  /// In en, this message translates to:
  /// **'Session expired. Please login again.'**
  String get errorUnauthorized;

  /// Settings screen title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Label for language selector
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Retry button label
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Loading indicator text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Title for todo detail screen
  ///
  /// In en, this message translates to:
  /// **'Todo Detail'**
  String get todoDetail;

  /// Label for completed status
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get checked;

  /// Label for pending status
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get unchecked;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
