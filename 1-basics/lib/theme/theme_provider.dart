// =============================================================================
// Theme Provider
// =============================================================================
// Concepts demonstrated:
// - ChangeNotifier — the foundation of Provider-based state management
// - notifyListeners() — triggers UI rebuilds in Consumer/Provider.of
// - SharedPreferences — persisting simple values across app restarts
// - Async initialization pattern (loadThemePreference in constructor)
// - ThemeMode enum (system, light, dark)
// =============================================================================

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages the app's theme mode (light / dark) and persists the choice.
///
/// Extends [ChangeNotifier] so widgets listening via [Consumer] or
/// [Provider.of] will rebuild when [notifyListeners] is called.
///
/// Usage in widget tree:
/// ```dart
/// Consumer<ThemeProvider>(
///   builder: (context, themeProvider, child) {
///     return Switch(
///       value: themeProvider.isDarkMode,
///       onChanged: (_) => themeProvider.toggleTheme(),
///     );
///   },
/// )
/// ```
class ThemeProvider extends ChangeNotifier {
  // ---------------------------------------------------------------------------
  // Constants
  // ---------------------------------------------------------------------------

  /// The key used to store the theme preference in SharedPreferences.
  static const String _themeKey = 'is_dark_mode';

  // ---------------------------------------------------------------------------
  // State
  // ---------------------------------------------------------------------------

  /// Whether dark mode is currently active.
  ///
  /// Prefixed with underscore to make it private — external code uses
  /// the [isDarkMode] getter instead.
  bool _isDarkMode = false;

  // ---------------------------------------------------------------------------
  // Constructor
  // ---------------------------------------------------------------------------

  /// Creates the provider and loads the saved theme preference.
  ///
  /// The constructor body calls an async method. Dart constructors cannot
  /// be async, so we fire-and-forget the [_loadThemePreference] call.
  /// The UI will show the default (light) theme briefly until the
  /// preference loads, then [notifyListeners] triggers a rebuild.
  ThemeProvider() {
    _loadThemePreference();
  }

  // ---------------------------------------------------------------------------
  // Getters
  // ---------------------------------------------------------------------------

  /// Whether dark mode is active.
  bool get isDarkMode => _isDarkMode;

  /// Returns the appropriate [ThemeMode] for [MaterialApp.themeMode].
  ///
  /// [ThemeMode.light] forces the light theme.
  /// [ThemeMode.dark] forces the dark theme.
  /// [ThemeMode.system] would follow the OS setting — not used here
  /// because we want the user's explicit choice to take priority.
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  // ---------------------------------------------------------------------------
  // Methods
  // ---------------------------------------------------------------------------

  /// Toggles between light and dark mode and persists the choice.
  ///
  /// Steps:
  /// 1. Flip the boolean
  /// 2. Notify listeners → widgets rebuild with new theme
  /// 3. Save to SharedPreferences (fire-and-forget)
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // <-- This triggers Consumer/Provider.of rebuilds
    _saveThemePreference();
  }

  /// Sets dark mode to a specific value.
  ///
  /// Useful when you want to set the mode directly rather than toggle.
  void setDarkMode(bool value) {
    if (_isDarkMode == value) return; // No change — skip unnecessary rebuild
    _isDarkMode = value;
    notifyListeners();
    _saveThemePreference();
  }

  // ---------------------------------------------------------------------------
  // Persistence
  // ---------------------------------------------------------------------------

  /// Loads the saved theme preference from disk.
  ///
  /// [SharedPreferences.getInstance()] returns a Future because it reads
  /// from platform-specific storage (NSUserDefaults on iOS, SharedPreferences
  /// on Android, localStorage on web).
  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    // getBool returns null if the key doesn't exist; `?? false` provides
    // a default value (light mode).
    _isDarkMode = prefs.getBool(_themeKey) ?? false;
    notifyListeners();
  }

  /// Saves the current theme preference to disk.
  Future<void> _saveThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _isDarkMode);
  }
}
