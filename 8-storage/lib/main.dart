// =============================================================================
// Personal Finance Tracker - Main Entry Point
// =============================================================================
//
// This app teaches three Flutter storage solutions:
//
// 1. SQLite (sqflite) - For expenses
//    - Relational data with JOINs and indexes
//    - Complex queries (SUM, GROUP BY, date ranges)
//    - ACID transactions and batch operations
//    - Schema migrations (v1 -> v2)
//
// 2. Hive - For app settings
//    - Key-value storage with type adapters
//    - Reactive streams via box.watch()
//    - Encrypted boxes for sensitive data
//    - Lightning-fast reads (data in memory)
//
// 3. Isar - For categories and budgets
//    - Type-safe query builder (no raw SQL)
//    - Collection links (Category -> Budget)
//    - Composite indexes
//    - watchLazy() for reactive UI
//
// Storage Selection Guide:
// ┌─────────────┬───────────────────────────────────────┐
// │ Use SQLite   │ Relational data, complex queries,     │
// │              │ large datasets, migrations needed      │
// ├─────────────┼───────────────────────────────────────┤
// │ Use Hive     │ Key-value data, settings, cache,      │
// │              │ simple types, fast reads               │
// ├─────────────┼───────────────────────────────────────┤
// │ Use Isar     │ NoSQL with type safety, reactive UI,  │
// │              │ object relationships, full-text search │
// └─────────────┴───────────────────────────────────────┘
// =============================================================================

import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'storage/hive/hive_helper.dart';
import 'storage/hive/settings_box.dart';
import 'storage/isar/isar_helper.dart';
import 'screens/dashboard_screen.dart';

// ---------------------------------------------------------------------------
// Main Entry Point
// ---------------------------------------------------------------------------

/// App entry point. Initializes all three storage backends.
///
/// Initialization order matters:
/// 1. Flutter bindings (needed for path_provider)
/// 2. Hive (settings needed for theme)
/// 3. Isar (categories/budgets)
/// 4. SQLite (initialized lazily on first query)
Future<void> main() async {
  // Ensure Flutter bindings are initialized before platform calls
  WidgetsFlutterBinding.ensureInitialized();

  // ---------------------------------------------------------------------------
  // Initialize Hive (settings storage)
  // ---------------------------------------------------------------------------
  await HiveHelper.instance.initialize();

  // Open the settings box and load initial settings
  final settingsBox = SettingsBox();
  await settingsBox.initialize();

  // ---------------------------------------------------------------------------
  // Initialize Isar (category/budget storage)
  // ---------------------------------------------------------------------------
  // Isar may fail if native libraries aren't available -- that's OK.
  // The app will show fallback data.
  await IsarHelper.instance.initialize();

  // ---------------------------------------------------------------------------
  // SQLite is initialized lazily
  // ---------------------------------------------------------------------------
  // DatabaseHelper.instance.database creates the database on first access.
  // No explicit initialization needed here.

  // Alternative: Pre-initialize SQLite for faster first query
  // await DatabaseHelper.instance.database;

  runApp(FinanceTrackerApp(settingsBox: settingsBox));
}

// ---------------------------------------------------------------------------
// Root App Widget
// ---------------------------------------------------------------------------

/// Root widget that configures theming and localization.
///
/// Listens to Hive settings changes for reactive theme updates.
/// When the user toggles dark mode or changes locale in settings,
/// the entire app rebuilds with the new configuration.
class FinanceTrackerApp extends StatefulWidget {
  /// Settings box for reactive theme and locale
  final SettingsBox settingsBox;

  const FinanceTrackerApp({
    super.key,
    required this.settingsBox,
  });

  @override
  State<FinanceTrackerApp> createState() => _FinanceTrackerAppState();
}

class _FinanceTrackerAppState extends State<FinanceTrackerApp> {
  @override
  void initState() {
    super.initState();

    // Watch for settings changes and rebuild the app
    // This demonstrates Hive's reactive capabilities
    widget.settingsBox.watchSettings().listen((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = widget.settingsBox.getSettings();

    return MaterialApp(
      title: 'Finance Tracker',
      debugShowCheckedModeBanner: false,

      // ---------------------------------------------------------------------------
      // Theme Configuration
      // ---------------------------------------------------------------------------
      // Using colorSchemeSeed instead of ColorScheme.fromSeed
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.teal,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      // Theme mode from Hive settings
      themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,

      // Alternative: Use a custom ColorScheme
      // theme: ThemeData(
      //   colorScheme: ColorScheme.light(
      //     primary: Colors.teal,
      //     secondary: Colors.amber,
      //   ),
      // ),

      // ---------------------------------------------------------------------------
      // Localization Configuration
      // ---------------------------------------------------------------------------
      locale: Locale(settings.localeCode),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],

      // ---------------------------------------------------------------------------
      // Home Screen
      // ---------------------------------------------------------------------------
      home: DashboardScreen(settingsBox: widget.settingsBox),
    );
  }

  @override
  void dispose() {
    // Clean up storage resources
    // In a real app, you might want to do this more carefully
    // HiveHelper.instance.close();
    // IsarHelper.instance.close();
    // DatabaseHelper.instance.close();
    super.dispose();
  }
}
