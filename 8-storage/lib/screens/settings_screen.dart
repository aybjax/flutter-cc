// =============================================================================
// Settings Screen
// =============================================================================
//
// Manages app settings stored in Hive. Demonstrates:
// - Reading/writing from Hive box via SettingsBox wrapper
// - Reactive settings updates with box.watch()
// - Currency, theme, date format, and locale selection
// - Hive's key-value storage pattern
// =============================================================================

import 'dart:async';

import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/app_settings.dart';
import '../storage/hive/settings_box.dart';

// ---------------------------------------------------------------------------
// Settings Screen
// ---------------------------------------------------------------------------

/// Settings screen with controls for app preferences stored in Hive.
///
/// Uses [SettingsBox] wrapper for type-safe Hive access.
/// Changes are applied immediately via Hive's synchronous writes
/// and propagated to the rest of the app via box.watch().
class SettingsScreen extends StatefulWidget {
  /// Settings box for reading and writing preferences
  final SettingsBox settingsBox;

  const SettingsScreen({
    super.key,
    required this.settingsBox,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late AppSettings _settings;
  StreamSubscription<AppSettings>? _watchSubscription;

  // Available currency options
  static const List<MapEntry<String, String>> _currencies = [
    MapEntry('\$', 'USD - US Dollar'),
    MapEntry('\u20AC', 'EUR - Euro'),
    MapEntry('\u00A3', 'GBP - British Pound'),
    MapEntry('\u00A5', 'JPY - Japanese Yen'),
    MapEntry('\u20B9', 'INR - Indian Rupee'),
    MapEntry('R\$', 'BRL - Brazilian Real'),
  ];

  // Available date format options
  static const List<MapEntry<String, String>> _dateFormats = [
    MapEntry('yyyy-MM-dd', '2024-01-15'),
    MapEntry('MM/dd/yyyy', '01/15/2024'),
    MapEntry('dd.MM.yyyy', '15.01.2024'),
    MapEntry('dd MMM yyyy', '15 Jan 2024'),
    MapEntry('MMMM dd, yyyy', 'January 15, 2024'),
  ];

  @override
  void initState() {
    super.initState();
    _settings = widget.settingsBox.getSettings();

    // Watch for external settings changes (e.g., from another screen)
    _watchSubscription = widget.settingsBox.watchSettings().listen((settings) {
      if (mounted) {
        setState(() => _settings = settings);
      }
    });
  }

  @override
  void dispose() {
    _watchSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return ListView(
      children: [
        // ---------------------------------------------------------------------------
        // Appearance Section
        // ---------------------------------------------------------------------------
        _buildSectionHeader(l10n.theme),

        // Dark mode toggle
        SwitchListTile(
          title: Text(l10n.darkMode),
          subtitle: const Text('Switch between light and dark themes'),
          value: _settings.isDarkMode,
          secondary: Icon(
            _settings.isDarkMode ? Icons.dark_mode : Icons.light_mode,
          ),
          onChanged: (value) async {
            // Write to Hive -- immediate and synchronous
            await widget.settingsBox.setDarkMode(value);
            setState(() {
              _settings = widget.settingsBox.getSettings();
            });
          },
        ),

        const Divider(),

        // ---------------------------------------------------------------------------
        // Currency Section
        // ---------------------------------------------------------------------------
        _buildSectionHeader(l10n.currency),

        // Use ListTile with trailing check mark instead of deprecated RadioListTile
        ...List.generate(_currencies.length, (index) {
          final entry = _currencies[index];
          final isSelected = entry.key == _settings.currencySymbol;
          return ListTile(
            leading: Text(
              entry.key,
              style: theme.textTheme.titleLarge,
            ),
            title: Text(entry.value),
            trailing: isSelected
                ? Icon(Icons.check, color: theme.colorScheme.primary)
                : null,
            selected: isSelected,
            onTap: () async {
              await widget.settingsBox.setCurrency(entry.key);
              setState(() {
                _settings = widget.settingsBox.getSettings();
              });
            },
          );
        }),

        const Divider(),

        // ---------------------------------------------------------------------------
        // Date Format Section
        // ---------------------------------------------------------------------------
        _buildSectionHeader(l10n.dateFormat),

        ...List.generate(_dateFormats.length, (index) {
          final entry = _dateFormats[index];
          final isSelected = entry.key == _settings.dateFormat;
          return ListTile(
            title: Text(entry.value),
            subtitle: Text(entry.key),
            trailing: isSelected
                ? Icon(Icons.check, color: theme.colorScheme.primary)
                : null,
            selected: isSelected,
            onTap: () async {
              await widget.settingsBox.setDateFormat(entry.key);
              setState(() {
                _settings = widget.settingsBox.getSettings();
              });
            },
          );

          // Alternative: Use RadioListTile with RadioGroup widget (Flutter 3.38+)
          // RadioGroup<String>(
          //   groupValue: _settings.dateFormat,
          //   onChanged: (value) async { ... },
          //   child: RadioListTile<String>(
          //     title: Text(entry.value),
          //     value: entry.key,
          //   ),
          // );
        }),

        const Divider(),

        // ---------------------------------------------------------------------------
        // Language Section
        // ---------------------------------------------------------------------------
        _buildSectionHeader(l10n.language),

        ListTile(
          title: const Text('English'),
          trailing: _settings.localeCode == 'en'
              ? Icon(Icons.check, color: theme.colorScheme.primary)
              : null,
          selected: _settings.localeCode == 'en',
          onTap: () async {
            await widget.settingsBox.setLocale('en');
            setState(() {
              _settings = widget.settingsBox.getSettings();
            });
          },
        ),

        ListTile(
          title: const Text('Espanol'),
          trailing: _settings.localeCode == 'es'
              ? Icon(Icons.check, color: theme.colorScheme.primary)
              : null,
          selected: _settings.localeCode == 'es',
          onTap: () async {
            await widget.settingsBox.setLocale('es');
            setState(() {
              _settings = widget.settingsBox.getSettings();
            });
          },
        ),

        const Divider(),

        // ---------------------------------------------------------------------------
        // Advanced Section
        // ---------------------------------------------------------------------------
        _buildSectionHeader('Advanced'),

        // Show decimals toggle
        SwitchListTile(
          title: const Text('Show Decimals'),
          subtitle: const Text('Display decimal places in amounts'),
          value: _settings.showDecimals,
          onChanged: (value) async {
            await widget.settingsBox.updateSettings(
              (current) => current.copyWith(showDecimals: value),
            );
            setState(() {
              _settings = widget.settingsBox.getSettings();
            });
          },
        ),

        // Budget warning threshold
        ListTile(
          title: const Text('Budget Warning'),
          subtitle: Text(
            'Warn at ${(_settings.budgetWarningThreshold * 100).toInt()}% of budget',
          ),
          trailing: SizedBox(
            width: 200,
            child: Slider(
              value: _settings.budgetWarningThreshold,
              min: 0.5,
              max: 1.0,
              divisions: 10,
              label:
                  '${(_settings.budgetWarningThreshold * 100).toInt()}%',
              onChanged: (value) async {
                await widget.settingsBox.updateSettings(
                  (current) =>
                      current.copyWith(budgetWarningThreshold: value),
                );
                setState(() {
                  _settings = widget.settingsBox.getSettings();
                });
              },
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Reset to defaults
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: OutlinedButton.icon(
            onPressed: _resetSettings,
            icon: const Icon(Icons.restore),
            label: const Text('Reset to Defaults'),
            style: OutlinedButton.styleFrom(
              foregroundColor: theme.colorScheme.error,
            ),
          ),
        ),

        const SizedBox(height: 32),
      ],
    );
  }

  /// Builds a section header label.
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
      ),
    );
  }

  /// Resets all settings to defaults after confirmation.
  Future<void> _resetSettings() async {
    final l10n = AppLocalizations.of(context)!;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Settings'),
        content: const Text(
          'This will reset all settings to their default values. '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Reset'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await widget.settingsBox.resetToDefaults();
      setState(() {
        _settings = widget.settingsBox.getSettings();
      });
    }
  }
}
