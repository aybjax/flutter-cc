// =============================================================================
// File: environment.dart
// Purpose: Environment enum and helper utilities for build flavor management.
// =============================================================================

/// Represents the possible application environments.
///
/// Each environment maps to a build flavor and determines the runtime
/// configuration such as API endpoints, logging levels, and feature flags.
enum Environment {
  /// Local development environment with debug tooling enabled.
  development,

  /// Pre-production environment for QA and stakeholder testing.
  staging,

  /// Live production environment serving real users.
  production,
}

// ---------------------------------------------------------------------------
// Extension methods on Environment
// ---------------------------------------------------------------------------

/// Adds display and configuration helpers to [Environment].
extension EnvironmentExtension on Environment {
  /// Human-readable display name for the environment.
  String get displayName {
    switch (this) {
      case Environment.development:
        return 'Development';
      case Environment.staging:
        return 'Staging';
      case Environment.production:
        return 'Production';
    }
  }

  /// The .env file name that corresponds to this environment.
  ///
  /// Used by flutter_dotenv to load the correct configuration at startup.
  String get envFileName {
    switch (this) {
      case Environment.development:
        return '.env.dev';
      case Environment.staging:
        return '.env.staging';
      case Environment.production:
        return '.env.production';
    }
  }

  // Alternative: could use a Map instead of switch
  // static const _envFileNames = {
  //   Environment.development: '.env.dev',
  //   Environment.staging: '.env.staging',
  //   Environment.production: '.env.production',
  // };
}
