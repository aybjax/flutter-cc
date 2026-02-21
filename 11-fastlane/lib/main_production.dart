// =============================================================================
// File: main_production.dart
// Purpose: Entry point for the PRODUCTION build flavor.
// Run with: flutter run --flavor production -t lib/main_production.dart
// =============================================================================

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'config/environment.dart';
import 'config/flavor_config.dart';
import 'main.dart';
import 'models/models.dart';

// ---------------------------------------------------------------------------
// Production entry point
// ---------------------------------------------------------------------------

/// Bootstraps the app in PRODUCTION mode.
///
/// Loads `.env.production` and configures the app for live end-users.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize flavor configuration from .env.production
  await FlavorConfig.initialize(Environment.production);

  final flavorConfig = FlavorConfig.instance;

  // Determine current build mode for display purposes
  final buildMode = kReleaseMode
      ? 'Release'
      : kProfileMode
          ? 'Profile'
          : 'Debug';

  // Build the immutable config snapshot for the UI
  final appConfig = AppConfig(
    appName: 'Fastlane Tutorial',
    environment: flavorConfig.environment.displayName,
    apiUrl: flavorConfig.baseUrl,
    version: '1.0.0+1',
    buildMode: buildMode,
  );

  runApp(FlavorApp(config: appConfig));
}
