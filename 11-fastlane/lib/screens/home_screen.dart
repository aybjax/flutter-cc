// =============================================================================
// File: home_screen.dart
// Purpose: Main screen that displays the current build flavor, environment,
// API URL, and version information.
// =============================================================================

import 'package:flutter/material.dart';
import '../l10n/generated/app_localizations.dart';

import '../models/models.dart';

// ---------------------------------------------------------------------------
// HomeScreen — displays the running flavor/environment configuration
// ---------------------------------------------------------------------------

/// The primary screen of the Fastlane tutorial app.
///
/// Shows a card-based layout with all environment-specific configuration
/// values so the developer can verify which flavor is active.
class HomeScreen extends StatelessWidget {
  /// The configuration snapshot to display.
  final AppConfig config;

  /// Creates a [HomeScreen] that displays the given [config].
  const HomeScreen({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header icon showing the environment visually
            Icon(
              _iconForEnvironment(config.environment),
              size: 80,
              color: _colorForEnvironment(config.environment, theme),
            ),
            const SizedBox(height: 16),

            // Environment badge
            Center(
              child: Chip(
                label: Text(
                  config.environment,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: _colorForEnvironment(
                  config.environment,
                  theme,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Configuration details card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.configurationTitle,
                      style: theme.textTheme.titleLarge,
                    ),
                    const Divider(height: 24),
                    _ConfigRow(
                      label: l10n.appNameLabel,
                      value: config.appName,
                    ),
                    _ConfigRow(
                      label: l10n.environmentLabel,
                      value: config.environment,
                    ),
                    _ConfigRow(
                      label: l10n.apiUrlLabel,
                      value: config.apiUrl,
                    ),
                    _ConfigRow(
                      label: l10n.versionLabel,
                      value: config.version,
                    ),
                    _ConfigRow(
                      label: l10n.buildModeLabel,
                      value: config.buildMode,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers — determine icon and color per environment
  // ---------------------------------------------------------------------------

  /// Returns an icon appropriate for the given environment string.
  IconData _iconForEnvironment(String env) {
    switch (env.toLowerCase()) {
      case 'development':
        return Icons.developer_mode;
      case 'staging':
        return Icons.science;
      case 'production':
        return Icons.rocket_launch;
      default:
        return Icons.info;
    }
  }

  /// Returns a color appropriate for the given environment string.
  Color _colorForEnvironment(String env, ThemeData theme) {
    switch (env.toLowerCase()) {
      case 'development':
        return Colors.green;
      case 'staging':
        return Colors.orange;
      case 'production':
        return Colors.red;
      default:
        return theme.colorScheme.primary;
    }

    // Alternative: use a Map for cleaner lookup
    // final colors = {
    //   'development': Colors.green,
    //   'staging': Colors.orange,
    //   'production': Colors.red,
    // };
    // return colors[env.toLowerCase()] ?? theme.colorScheme.primary;
  }
}

// ---------------------------------------------------------------------------
// _ConfigRow — a single label-value row in the configuration card
// ---------------------------------------------------------------------------

/// A private widget that renders a label-value pair as a table row.
class _ConfigRow extends StatelessWidget {
  final String label;
  final String value;

  const _ConfigRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fixed-width label column
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Flexible value column
          Expanded(
            child: SelectableText(
              value,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
