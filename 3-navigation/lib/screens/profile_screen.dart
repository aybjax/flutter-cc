// =============================================================================
// Profile Screen — Auth-Protected Route
// =============================================================================
// Concepts demonstrated:
// - Auth-protected screen that requires login
// - @RoutePage() annotation for auto_route
// - ValueListenableBuilder for reactive auth state
// - Different auth guard behaviors across navigation approaches:
//   * Navigator: manual check + push to login
//   * GoRouter: redirect guard in router config
//   * auto_route: AutoRouteGuard in router config
//
// This screen is intentionally behind an auth wall to demonstrate how
// each navigation approach handles protected routes differently.
// =============================================================================

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

// -----------------------------------------------------------------------------
// Profile Screen Widget
// -----------------------------------------------------------------------------

/// Displays user profile information.
///
/// This screen requires authentication. Each navigation approach
/// protects it differently:
/// - **Navigator**: checks `isAuthenticated` in `onTap` before pushing
/// - **GoRouter**: uses `redirect` callback to redirect to `/login`
/// - **auto_route**: uses `AutoRouteGuard` to intercept and redirect
@RoutePage()
class ProfileScreen extends StatelessWidget {
  /// Creates a [ProfileScreen].
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ValueListenableBuilder rebuilds when isAuthenticated changes.
    // This is simpler than Provider for a single boolean value.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          // Logout button — only visible when authenticated
          ValueListenableBuilder<bool>(
            valueListenable: isAuthenticated,
            builder: (context, loggedIn, _) {
              if (!loggedIn) return const SizedBox.shrink();
              return IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Logout',
                onPressed: () {
                  isAuthenticated.value = false;
                  currentUserName.value = '';

                  // Show feedback
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logged out')),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: isAuthenticated,
        builder: (context, loggedIn, _) {
          if (!loggedIn) {
            // -- Not authenticated state --
            // This is shown when the user navigates directly via
            // the default Navigator approach (no guard).
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Please log in to view your profile',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => LoginScreen(
                            onLoginSuccess: () => Navigator.of(context).pop(),
                          ),
                        ),
                      );
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            );
          }

          // ---------------------------------------------------------------------------
          // Authenticated profile content
          // ---------------------------------------------------------------------------

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // -- Avatar --
                CircleAvatar(
                  radius: 48,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text(
                    currentUserName.value.isNotEmpty
                        ? currentUserName.value[0].toUpperCase()
                        : '?',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // -- User name --
                ValueListenableBuilder<String>(
                  valueListenable: currentUserName,
                  builder: (context, name, _) {
                    return Text(
                      'Welcome, $name!',
                      style: Theme.of(context).textTheme.headlineSmall,
                    );
                  },
                ),
                const SizedBox(height: 32),

                // -- Settings tiles --
                _buildSettingsTile(
                  context,
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  subtitle: 'Manage push notification preferences',
                ),
                _buildSettingsTile(
                  context,
                  icon: Icons.bookmark_outline,
                  title: 'Bookmarks',
                  subtitle: 'View your saved articles',
                ),
                _buildSettingsTile(
                  context,
                  icon: Icons.palette_outlined,
                  title: 'Appearance',
                  subtitle: 'Theme and display settings',
                ),
                _buildSettingsTile(
                  context,
                  icon: Icons.info_outline,
                  title: 'About',
                  subtitle: 'App version and licenses',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helper: settings list tile
  // ---------------------------------------------------------------------------

  /// Builds a single settings row with icon, title, and subtitle.
  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // Placeholder — these would navigate to sub-settings screens
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title tapped (not implemented in demo)'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
    );
  }
}
