// =============================================================================
// File: main_dev.dart
// Purpose: Entry point for the DEVELOPMENT build flavor.
// Run with: flutter run --flavor dev -t lib/main_dev.dart
// =============================================================================

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'config/environment.dart';
import 'config/flavor_config.dart';
import 'main.dart';
import 'models/models.dart';

// ---------------------------------------------------------------------------
// Development entry point
// ---------------------------------------------------------------------------

/// Bootstraps the app in DEVELOPMENT mode.
///
/// Loads `.env.dev` and configures the app with development settings.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize flavor configuration from .env.dev
  await FlavorConfig.initialize(Environment.development);

  final flavorConfig = FlavorConfig.instance;

  // Determine current build mode for display purposes
  final buildMode = kReleaseMode
      ? 'Release'
      : kProfileMode
          ? 'Profile'
          : 'Debug';

  // Build the immutable config snapshot for the UI
  final appConfig = AppConfig(
    appName: 'Fastlane Dev',
    environment: flavorConfig.environment.displayName,
    apiUrl: flavorConfig.baseUrl,
    version: '1.0.0+1',
    buildMode: buildMode,
  );

  runApp(FlavorApp(config: appConfig));
}
