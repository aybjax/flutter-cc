// =============================================================================
// File: app_config.dart
// Purpose: Immutable data model for app configuration using @freezed.
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_config.freezed.dart';
part 'app_config.g.dart';

// ---------------------------------------------------------------------------
// AppConfig — freezed model representing the full app configuration snapshot
// ---------------------------------------------------------------------------

/// An immutable snapshot of the application's configuration.
///
/// Used to pass configuration data to the UI layer for display.
/// Generated with `dart run build_runner build`.
@freezed
abstract class AppConfig with _$AppConfig {
  /// Creates an [AppConfig] with the given parameters.
  const factory AppConfig({
    /// Display name of the application for this flavor.
    required String appName,

    /// The current environment name (e.g., "Development", "Staging").
    required String environment,

    /// The base URL used for API requests in this environment.
    required String apiUrl,

    /// The app version string (e.g., "1.0.0+1").
    required String version,

    /// The current build mode (debug, profile, or release).
    required String buildMode,
  }) = _AppConfig;

  /// Deserializes an [AppConfig] from a JSON map.
  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);

  // Alternative: could include additional fields like:
  // required DateTime buildTimestamp,
  // required String gitCommitHash,
}
