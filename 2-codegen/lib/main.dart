// =============================================================================
// Main Entry Point — 2-codegen: Code Generation & Functional Types
// =============================================================================
// Concepts demonstrated:
// - MaterialApp with localization delegates (l10n)
// - supportedLocales and localizationsDelegates from generated code
// - Locale switching at runtime (stored in State)
// - Providing a shared ContactRepository to child screens
// - How generated l10n code (AppLocalizations) integrates with MaterialApp
//
// This app is a "Contact Book" that teaches:
// 1. build_runner — the code generation engine
// 2. freezed — immutable data classes and union types
// 3. json_serializable — automatic JSON serialization
// 4. dartz — functional error handling with Either and Option
// 5. l10n/intl — internationalization with .arb files
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/generated/app_localizations.dart';
import 'repositories/contact_repository.dart';
import 'screens/contact_list_screen.dart';

// =============================================================================
// App Entry Point
// =============================================================================

/// The app's entry point.
///
/// We create a single [ContactRepository] instance here and pass it down.
/// In later tutorials (7-architecture), we'll use proper DI with get_it.
void main() {
  runApp(const CodegenTutorialApp());
}

// =============================================================================
// Root Widget with Locale State
// =============================================================================

/// Root widget that manages the current locale.
///
/// This is a StatefulWidget so we can change the locale at runtime
/// when the user selects a different language in settings.
///
/// In a production app, you'd persist the locale choice to SharedPreferences
/// and use a state management solution. Here we keep it simple.
class CodegenTutorialApp extends StatefulWidget {
  const CodegenTutorialApp({super.key});

  @override
  State<CodegenTutorialApp> createState() => _CodegenTutorialAppState();
}

class _CodegenTutorialAppState extends State<CodegenTutorialApp>
    with AppLocaleStateMixin {
  /// Current locale. Defaults to English.
  Locale _locale = const Locale('en');

  /// The shared contact repository (in-memory, no backend needed).
  final _repository = ContactRepository();

  /// Called by the language switcher to change the locale.
  @override
  void setLocale(Locale locale) {
    setState(() => _locale = locale);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // -- App identity --
      title: 'Contact Book',
      debugShowCheckedModeBanner: false,

      // -- Theme --
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),

      // =====================================================================
      // Localization (l10n) Setup
      // =====================================================================
      // Flutter's localization system works in three parts:
      //
      // 1. localizationsDelegates — factories that load translations
      //    - AppLocalizations.delegate: OUR translations (from .arb files)
      //    - GlobalMaterialLocalizations.delegate: Material widget translations
      //    - GlobalWidgetsLocalizations.delegate: text direction (LTR/RTL)
      //    - GlobalCupertinoLocalizations.delegate: iOS-style widget translations
      //
      // 2. supportedLocales — which locales the app supports
      //    - AppLocalizations.supportedLocales is generated from .arb files
      //
      // 3. locale — the currently active locale (for runtime switching)

      localizationsDelegates: const [
        // Our app-specific translations (generated from .arb files)
        AppLocalizations.delegate,
        // Material widget translations (buttons, dialogs, etc.)
        GlobalMaterialLocalizations.delegate,
        // Basic widget translations (text direction)
        GlobalWidgetsLocalizations.delegate,
        // Cupertino widget translations (iOS-style)
        GlobalCupertinoLocalizations.delegate,
      ],

      // Which locales we support — generated from our .arb file names
      // (app_en.arb → Locale('en'), app_es.arb → Locale('es'))
      supportedLocales: AppLocalizations.supportedLocales,

      // Current locale (changed by the language switcher)
      locale: _locale,

      // -- Home screen --
      home: ContactListScreen(repository: _repository),
    );
  }
}

// =============================================================================
// How l10n Works End-to-End
// =============================================================================
//
// 1. You write .arb files (Application Resource Bundle) in lib/l10n/:
//    - app_en.arb (English — the template)
//    - app_es.arb (Spanish — translations)
//
// 2. l10n.yaml configures the code generator:
//    - arb-dir: where to find .arb files
//    - template-arb-file: the "source of truth" locale
//    - output-localization-file: what to name the generated file
//
// 3. `flutter gen-l10n` (or `flutter pub get`) generates:
//    - app_localizations.dart — the AppLocalizations class
//    - app_localizations_en.dart — English implementation
//    - app_localizations_es.dart — Spanish implementation
//
// 4. In your widgets, access translations via:
//    final l10n = AppLocalizations.of(context)!;
//    Text(l10n.appTitle)  // "Contact Book" or "Agenda de Contactos"
//
// 5. For interpolation (variables in strings):
//    "confirmDelete": "Are you sure you want to delete {name}?"
//    l10n.confirmDelete('Alice')  // generates a method with parameter
//
// 6. For plurals (ICU message format):
//    "contactsCount": "{count, plural, =0{No contacts} =1{1 contact} other{{count} contacts}}"
//    l10n.contactsCount(5)  // "5 contacts"
//
// =============================================================================
// build_runner Pipeline
// =============================================================================
//
// To generate all code (freezed + json_serializable):
//
//   dart run build_runner build --delete-conflicting-outputs
//
// Or watch for changes and regenerate automatically:
//
//   dart run build_runner watch --delete-conflicting-outputs
//
// What happens:
// 1. build_runner scans all .dart files for annotations
// 2. Files with @freezed → freezed generator creates *.freezed.dart
// 3. Files with @JsonSerializable → json_serializable creates *.g.dart
// 4. The `part` directives connect generated files to source files
//
// Common issues:
// - "Could not generate..." → check your part directives match file names
// - "conflicting outputs" → use --delete-conflicting-outputs flag
// - Red squiggles before generation → normal! Run build_runner first
// =============================================================================
