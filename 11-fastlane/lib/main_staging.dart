// =============================================================================
// File: main_staging.dart
// Purpose: Entry point for the STAGING build flavor.
// Run with: flutter run --flavor staging -t lib/main_staging.dart
// =============================================================================

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'config/environment.dart';
import 'config/flavor_config.dart';
import 'main.dart';
import 'models/models.dart';

// ---------------------------------------------------------------------------
// Staging entry point
// ---------------------------------------------------------------------------

/// Bootstraps the app in STAGING mode.
///
/// Loads `.env.staging` and configures the app for QA/stakeholder testing.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize flavor configuration from .env.staging
  await FlavorConfig.initialize(Environment.staging);

  final flavorConfig = FlavorConfig.instance;

  // Determine current build mode for display purposes
  final buildMode = kReleaseMode
      ? 'Release'
      : kProfileMode
          ? 'Profile'
          : 'Debug';

  // Build the immutable config snapshot for the UI
  final appConfig = AppConfig(
    appName: 'Fastlane Staging',
    environment: flavorConfig.environment.displayName,
    apiUrl: flavorConfig.baseUrl,
    version: '1.0.0+1',
    buildMode: buildMode,
  );

  runApp(FlavorApp(config: appConfig));
}
