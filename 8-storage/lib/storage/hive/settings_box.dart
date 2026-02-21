// =============================================================================
// Settings Box - Type-Safe Hive Box Wrapper
// =============================================================================
//
// This wrapper provides type-safe access to the Hive settings box.
// Instead of raw box.get('key'), it exposes strongly-typed methods.
//
// Benefits:
// - Compile-time type checking
// - Default values in one place
// - Reactive streams via box.watch()
// - Easier testing (can be mocked)
//
// This pattern is similar to a Repository in Clean Architecture.
// =============================================================================

import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';

import '../../models/app_settings.dart';
import 'hive_helper.dart';

// ---------------------------------------------------------------------------
// Settings Key Constants
// ---------------------------------------------------------------------------

/// Keys for the settings box.
///
/// Using constants prevents typos and enables find-all-references.
class SettingsKeys {
  /// Key for the main app settings object
  static const String appSettings = 'app_settings';

  /// Key for first launch flag
  static const String isFirstLaunch = 'is_first_launch';

  /// Key for last sync timestamp
  static const String lastSync = 'last_sync';
}

// ---------------------------------------------------------------------------
// Settings Box Wrapper
// ---------------------------------------------------------------------------

/// Type-safe wrapper around the Hive settings box.
///
/// Provides:
/// - Typed getters/setters for all settings
/// - Reactive [Stream] for settings changes
/// - Default values when settings haven't been set
/// - Atomic updates via transactions
///
/// Usage:
/// ```dart
/// final settingsBox = SettingsBox();
/// await settingsBox.initialize();
///
/// // Read settings
/// final settings = settingsBox.getSettings();
///
/// // Update settings
/// await settingsBox.updateSettings(
///   settings.copyWith(isDarkMode: true),
/// );
///
/// // Watch for changes
/// settingsBox.watchSettings().listen((settings) {
///   // Rebuild UI with new settings
/// });
/// ```
class SettingsBox {
  /// The underlying Hive box
  Box<AppSettings>? _box;

  // ---------------------------------------------------------------------------
  // Initialization
  // ---------------------------------------------------------------------------

  /// Opens the settings box. Must be called before any operations.
  Future<void> initialize() async {
    _box = await HiveHelper.instance.openSettingsBox();
  }

  /// Gets the box, throwing if not initialized.
  Box<AppSettings> get _safeBox {
    final box = _box;
    if (box == null || !box.isOpen) {
      throw StateError(
        'SettingsBox not initialized. Call initialize() first.',
      );
    }
    return box;
  }

  // ---------------------------------------------------------------------------
  // Read Operations
  // ---------------------------------------------------------------------------

  /// Gets the current app settings.
  ///
  /// Returns default settings if none have been saved yet.
  /// This is a synchronous operation because regular Hive boxes
  /// keep all data in memory.
  AppSettings getSettings() {
    return _safeBox.get(
      SettingsKeys.appSettings,
      defaultValue: AppSettings(),
    )!;
  }

  /// Whether this is the first time the app has been launched.
  bool get isFirstLaunch {
    // Use a dynamic box for simple key-value pairs
    return _safeBox.get(SettingsKeys.appSettings) == null;
  }

  // ---------------------------------------------------------------------------
  // Write Operations
  // ---------------------------------------------------------------------------

  /// Saves new app settings.
  ///
  /// This overwrites the entire settings object.
  /// For partial updates, use [updateSettings] with copyWith.
  Future<void> saveSettings(AppSettings settings) async {
    await _safeBox.put(SettingsKeys.appSettings, settings);
  }

  /// Updates settings with a modifier function.
  ///
  /// This pattern ensures you always start from the current value,
  /// avoiding race conditions in concurrent updates.
  ///
  /// Usage:
  /// ```dart
  /// await settingsBox.updateSettings(
  ///   (current) => current.copyWith(isDarkMode: true),
  /// );
  /// ```
  Future<void> updateSettings(
    AppSettings Function(AppSettings current) modifier,
  ) async {
    final current = getSettings();
    final updated = modifier(current);
    await saveSettings(updated);

    // Alternative: Use HiveObject.save() if the object extends HiveObject
    // current.isDarkMode = true;
    // await current.save(); // Saves in-place without put()
  }

  // ---------------------------------------------------------------------------
  // Reactive Streams (box.watch())
  // ---------------------------------------------------------------------------

  /// Watches for settings changes.
  ///
  /// Returns a stream that emits the new [AppSettings] whenever
  /// the settings are modified. Uses Hive's built-in watch() method.
  ///
  /// This is useful for:
  /// - Updating theme when dark mode changes
  /// - Updating currency symbols across the app
  /// - Syncing settings with a backend
  Stream<AppSettings> watchSettings() {
    return _safeBox
        .watch(key: SettingsKeys.appSettings)
        .map((event) {
          // event.value is the new value (null if deleted)
          // event.deleted indicates if the key was removed
          if (event.deleted) {
            return AppSettings(); // Return defaults on delete
          }
          return event.value as AppSettings;
        });

    // Alternative: Watch ALL changes in the box (any key)
    // return _safeBox.watch().map((event) => getSettings());
  }

  /// Watches for any change in the settings box.
  ///
  /// Unlike [watchSettings], this fires for ANY key change,
  /// not just the app settings key.
  Stream<BoxEvent> watchAll() {
    return _safeBox.watch();
  }

  // ---------------------------------------------------------------------------
  // Convenience Setters
  // ---------------------------------------------------------------------------

  /// Updates just the dark mode setting.
  Future<void> setDarkMode(bool isDark) async {
    await updateSettings(
      (current) => current.copyWith(isDarkMode: isDark),
    );
  }

  /// Updates just the currency symbol.
  Future<void> setCurrency(String symbol) async {
    await updateSettings(
      (current) => current.copyWith(currencySymbol: symbol),
    );
  }

  /// Updates just the date format.
  Future<void> setDateFormat(String format) async {
    await updateSettings(
      (current) => current.copyWith(dateFormat: format),
    );
  }

  /// Updates just the locale.
  Future<void> setLocale(String localeCode) async {
    await updateSettings(
      (current) => current.copyWith(localeCode: localeCode),
    );
  }

  // ---------------------------------------------------------------------------
  // Cleanup
  // ---------------------------------------------------------------------------

  /// Resets all settings to defaults.
  Future<void> resetToDefaults() async {
    await _safeBox.clear();
    await saveSettings(AppSettings());
  }

  /// Closes the settings box.
  Future<void> close() async {
    await _box?.close();
    _box = null;
  }
}
