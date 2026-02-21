// =============================================================================
// File: main.dart
// Purpose: Shared app widget used by all flavor entry points.
// Contains the MaterialApp configuration with theming and l10n.
// =============================================================================

import 'package:flutter/material.dart';
import 'l10n/generated/app_localizations.dart';

import 'models/models.dart';
import 'screens/home_screen.dart';

// ---------------------------------------------------------------------------
// FlavorApp — the shared MaterialApp widget
// ---------------------------------------------------------------------------

/// The root application widget shared across all build flavors.
///
/// Each flavor entry point (main_dev.dart, main_staging.dart,
/// main_production.dart) initializes [FlavorConfig], builds an [AppConfig],
/// and passes it here.
class FlavorApp extends StatelessWidget {
  /// The configuration snapshot for the current flavor.
  final AppConfig config;

  /// Creates the app with the given [config].
  const FlavorApp({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: config.appName,
      debugShowCheckedModeBanner: false,

      // -----------------------------------------------------------------------
      // Theming — uses colorSchemeSeed instead of ColorScheme.fromSeed
      // -----------------------------------------------------------------------
      theme: ThemeData(
        colorSchemeSeed: _seedColorForEnvironment(config.environment),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: _seedColorForEnvironment(config.environment),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),

      // -----------------------------------------------------------------------
      // Localization — English and Spanish
      // -----------------------------------------------------------------------
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      home: HomeScreen(config: config),
    );
  }

  /// Returns a seed color based on the environment for visual differentiation.
  ///
  /// This makes it immediately obvious which flavor is running:
  /// - Dev = green
  /// - Staging = orange
  /// - Production = blue (the "real" app color)
  Color _seedColorForEnvironment(String env) {
    switch (env.toLowerCase()) {
      case 'development':
        return Colors.green;
      case 'staging':
        return Colors.orange;
      case 'production':
        return Colors.blue;
      default:
        return Colors.deepPurple;
    }

    // Alternative: derive from a config-provided hex value
    // return Color(int.parse(config.themeColorHex, radix: 16));
  }
}
