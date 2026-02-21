// =============================================================================
// File: flavor_config.dart
// Purpose: Singleton configuration holder for the current build flavor.
// Provides runtime access to environment-specific settings.
// =============================================================================

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'environment.dart';

// ---------------------------------------------------------------------------
// FlavorConfig — singleton pattern for flavor-aware configuration
// ---------------------------------------------------------------------------

/// Holds the runtime configuration for the current build flavor.
///
/// Initialized once at app startup from the appropriate .env file and
/// the [Environment] selected by the entry point (main_dev.dart, etc.).
///
/// Usage:
/// ```dart
/// await FlavorConfig.initialize(Environment.development);
/// final config = FlavorConfig.instance;
/// print(config.baseUrl); // http://localhost:8080
/// ```
class FlavorConfig {
  /// The active environment for this build.
  final Environment environment;

  /// The base URL for API requests, loaded from the .env file.
  final String baseUrl;

  /// The raw environment string from the .env file.
  final String envString;

  // Private constructor — only created via [initialize].
  FlavorConfig._({
    required this.environment,
    required this.baseUrl,
    required this.envString,
  });

  // ---------------------------------------------------------------------------
  // Singleton access
  // ---------------------------------------------------------------------------

  static FlavorConfig? _instance;

  /// Returns the initialized [FlavorConfig] instance.
  ///
  /// Throws [StateError] if [initialize] has not been called yet.
  static FlavorConfig get instance {
    if (_instance == null) {
      throw StateError(
        'FlavorConfig has not been initialized. '
        'Call FlavorConfig.initialize() before accessing the instance.',
      );
    }
    return _instance!;
  }

  /// Loads the .env file for [environment] and creates the singleton.
  ///
  /// Must be called exactly once before [instance] is accessed.
  static Future<void> initialize(Environment environment) async {
    // Load the correct .env file for this flavor
    await dotenv.load(fileName: environment.envFileName);

    _instance = FlavorConfig._(
      environment: environment,
      baseUrl: dotenv.env['BASE_URL'] ?? 'http://localhost:8080',
      envString: dotenv.env['ENV'] ?? 'unknown',
    );
  }

  // Alternative: could accept explicit parameters instead of reading dotenv
  // static void initializeManual({
  //   required Environment environment,
  //   required String baseUrl,
  // }) {
  //   _instance = FlavorConfig._(
  //     environment: environment,
  //     baseUrl: baseUrl,
  //     envString: environment.displayName,
  //   );
  // }

  /// Whether the app is running in development mode.
  bool get isDevelopment => environment == Environment.development;

  /// Whether the app is running in staging mode.
  bool get isStaging => environment == Environment.staging;

  /// Whether the app is running in production mode.
  bool get isProduction => environment == Environment.production;
}
