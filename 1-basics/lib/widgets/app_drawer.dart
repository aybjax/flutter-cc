// =============================================================================
// App Drawer Widget
// =============================================================================
// Concepts demonstrated:
// - Drawer — a slide-out panel from the left edge
// - DrawerHeader — the top section of a Drawer (typically branding/user info)
// - ListTile — standard row widget for menus and lists
// - Navigator.push with MaterialPageRoute — non-named route navigation
// - Navigator.pop — closing the drawer before navigating
// - Divider — a horizontal line separating sections
// - Consumer — accessing provider state in the drawer
// =============================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/route_names.dart';
import '../providers/auth_provider.dart';
import '../providers/todo_provider.dart';
import '../screens/demos/sliver_demo_screen.dart';
import '../screens/demos/animation_demo_screen.dart';
import '../screens/demos/gestures_demo_screen.dart';
import '../screens/demos/media_query_demo_screen.dart';
import '../screens/demos/lifecycle_demo_screen.dart';
import 'page_transition.dart';

/// The main navigation drawer shown on the home screen.
///
/// Contains links to demo screens (navigated via non-named routes)
/// and displays user info in the header.
///
/// Non-named routes are used here (Navigator.push with MaterialPageRoute)
/// to demonstrate the alternative to named routes. This is useful when
/// you want to pass complex objects directly to the screen constructor.
class AppDrawer extends StatelessWidget {
  /// Creates the app drawer.
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Drawer width, background, etc. come from drawerTheme in AppTheme.
      child: Column(
        children: [
          // ===================================================================
          // Drawer Header
          // ===================================================================
          // DrawerHeader provides a styled top section.
          // UserAccountsDrawerHeader is a specialized version with avatar,
          // name, and email — shown commented out below.
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                margin: EdgeInsets.zero, // Remove default margin
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // User avatar
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // User email
                    Text(
                      authProvider.user?.email ?? 'Guest',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                    ),
                  ],
                ),
              );

              // Alternative: UserAccountsDrawerHeader
              // return UserAccountsDrawerHeader(
              //   accountName: Text(authProvider.user?.email ?? 'Guest'),
              //   accountEmail: Text('ID: ${authProvider.user?.id}'),
              //   currentAccountPicture: CircleAvatar(
              //     child: Icon(Icons.person),
              //   ),
              //   decoration: BoxDecoration(
              //     color: Theme.of(context).colorScheme.primaryContainer,
              //   ),
              //   // otherAccountsPictures: [...],  // Additional small avatars
              //   // arrowColor: ...,               // Dropdown arrow color
              //   // onDetailsPressed: () {},        // Tap on name/email area
              // );
            },
          ),

          // ===================================================================
          // Navigation Items
          // ===================================================================
          // Each ListTile navigates to a demo screen using non-named routes.
          // The pattern is:
          // 1. Close the drawer with Navigator.pop
          // 2. Push the new route with Navigator.push

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // -- Sliver Demo (non-named route via MaterialPageRoute) --
                ListTile(
                  leading: const Icon(Icons.view_list),
                  title: const Text('Sliver Demo'),
                  subtitle: const Text('CustomScrollView, SliverAppBar'),
                  onTap: () {
                    Navigator.pop(context); // Close drawer first
                    // Navigator.push with MaterialPageRoute is a non-named route.
                    // Unlike pushNamed, you pass the widget directly.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SliverDemoScreen(),
                      ),
                    );
                  },
                ),

                // -- Animation Demo (uses custom FadeSlidePageRoute) --
                ListTile(
                  leading: const Icon(Icons.animation),
                  title: const Text('Animation Demo'),
                  subtitle: const Text('Controllers, transitions, curves'),
                  onTap: () {
                    Navigator.pop(context);
                    // Uses custom page transition (FadeSlidePageRoute)
                    // instead of the default MaterialPageRoute.
                    Navigator.push(
                      context,
                      FadeSlidePageRoute(
                        page: const AnimationDemoScreen(),
                      ),
                    );
                  },
                ),

                // -- Gestures Demo --
                ListTile(
                  leading: const Icon(Icons.touch_app),
                  title: const Text('Gestures Demo'),
                  subtitle: const Text('GestureDetector, InkWell'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const GesturesDemoScreen(),
                      ),
                    );
                  },
                ),

                // -- MediaQuery Demo --
                ListTile(
                  leading: const Icon(Icons.devices),
                  title: const Text('MediaQuery Demo'),
                  subtitle: const Text('Screen size, orientation, insets'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MediaQueryDemoScreen(),
                      ),
                    );
                  },
                ),

                // -- Lifecycle Demo --
                ListTile(
                  leading: const Icon(Icons.loop),
                  title: const Text('Lifecycle Demo'),
                  subtitle: const Text('Widget & app lifecycle events'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LifecycleDemoScreen(),
                      ),
                    );
                  },
                ),

                const Divider(),

                // -- About --
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('About'),
                  onTap: () {
                    Navigator.pop(context);
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
                          'A comprehensive Flutter tutorial app that teaches '
                          'Flutter/Dart concepts through a functional todo client.',
                        ),
                      ],
                    );
                  },
                ),

                // -- Logout --
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context); // Close drawer first
                    final authProvider = Provider.of<AuthProvider>(
                      context,
                      listen: false,
                    );
                    final todoProvider = Provider.of<TodoProvider>(
                      context,
                      listen: false,
                    );
                    await authProvider.logout();
                    todoProvider.clear();
                    if (context.mounted) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouteNames.login,
                        (route) => false,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
