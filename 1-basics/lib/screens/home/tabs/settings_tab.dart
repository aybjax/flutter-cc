// =============================================================================
// Settings Tab
// =============================================================================
// Concepts demonstrated:
// - SwitchListTile — a ListTile with a built-in Switch toggle
// - Consumer for accessing ThemeProvider and AuthProvider
// - SharedPreferences direct usage (via provider)
// - showAboutDialog — built-in Flutter about dialog
// - Location permission and GPS fetch (placeholder, full in Commit 14)
// - Logout flow — clear state and navigate
// =============================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/route_names.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/todo_provider.dart';
import '../../../theme/theme_provider.dart';
import '../../../services/location_service.dart';
import '../../../widgets/custom_snackbar.dart';

/// Settings screen with theme toggle, user info, location, and logout.
///
/// Demonstrates [SwitchListTile], [Consumer] for multiple providers,
/// and the logout flow.
class SettingsTab extends StatefulWidget {
  /// Creates the settings tab.
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  /// Location text display (updated when GPS is fetched).
  String _locationText = 'Not fetched';

  /// Whether a location fetch is in progress.
  bool _isFetchingLocation = false;

  // ---------------------------------------------------------------------------
  // Actions
  // ---------------------------------------------------------------------------

  /// The location service for GPS access.
  final LocationService _locationService = LocationService();

  /// Fetches the user's GPS location.
  Future<void> _fetchLocation() async {
    setState(() {
      _isFetchingLocation = true;
    });

    try {
      final position = await _locationService.getCurrentPosition();

      if (!mounted) return;

      setState(() {
        _isFetchingLocation = false;
        _locationText =
            'Lat: ${position.latitude.toStringAsFixed(6)}, '
            'Lng: ${position.longitude.toStringAsFixed(6)}';
      });

      CustomSnackBar.showSuccess(context, message: 'Location fetched');
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isFetchingLocation = false;
        _locationText = e.toString().replaceFirst('Exception: ', '');
      });

      CustomSnackBar.showError(
        context,
        message: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  /// Logs out the user and navigates to the login screen.
  Future<void> _logout() async {
    // Clear auth state.
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);

    await authProvider.logout();
    todoProvider.clear();

    if (!mounted) return;

    // Navigate to login, clearing the navigation stack.
    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteNames.login,
      (route) => false, // Remove all previous routes
    );
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        // =====================================================================
        // Theme section
        // =====================================================================
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Appearance',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),

        // SwitchListTile — a ListTile with a built-in Switch.
        Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return SwitchListTile(
              // -- SwitchListTile fields --
              title: const Text('Dark Mode'),
              subtitle: Text(
                themeProvider.isDarkMode ? 'Dark theme active' : 'Light theme active',
              ),
              value: themeProvider.isDarkMode,
              onChanged: (_) => themeProvider.toggleTheme(),
              secondary: Icon(
                themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              ),
              // activeColor: ...,             // Switch color when on
              // activeTrackColor: ...,        // Track color when on
              // inactiveThumbColor: ...,      // Switch color when off
              // inactiveTrackColor: ...,      // Track color when off
              // thumbIcon: ...,               // Icon inside switch thumb
              // dense: false,                 // Compact mode
              // contentPadding: ...,          // Override padding
              // shape: ...,                   // Tile shape
              // tileColor: ...,               // Background color
              // selectedTileColor: ...,       // Background when selected
              // controlAffinity: ListTileControlAffinity.trailing, // Switch position
            );
          },
        ),

        const Divider(),

        // =====================================================================
        // Account section
        // =====================================================================
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Account',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),

        Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Email'),
              subtitle: Text(authProvider.user?.email ?? 'Not logged in'),
            );
          },
        ),

        Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return ListTile(
              leading: const Icon(Icons.badge),
              title: const Text('User ID'),
              subtitle: Text('${authProvider.user?.id ?? 'N/A'}'),
            );
          },
        ),

        const Divider(),

        // =====================================================================
        // Location section
        // =====================================================================
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Location',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),

        ListTile(
          leading: const Icon(Icons.location_on),
          title: const Text('GPS Location'),
          subtitle: Text(_locationText),
          trailing: _isFetchingLocation
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: _fetchLocation,
                ),
        ),

        const Divider(),

        // =====================================================================
        // Actions section
        // =====================================================================
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Actions',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),

        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('About'),
          onTap: () {
            showAboutDialog(
              context: context,
              applicationName: 'Flutter Basics',
              applicationVersion: '1.0.0',
              applicationIcon: Icon(
                Icons.check_circle_outline,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              children: [
                const Text(
                  'A comprehensive Flutter tutorial app.',
                ),
              ],
            );
          },
        ),

        ListTile(
          leading: Icon(Icons.logout, color: Theme.of(context).colorScheme.error),
          title: Text(
            'Logout',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
          onTap: _logout,
        ),
      ],
    );
  }
}
