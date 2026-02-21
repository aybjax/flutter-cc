// =============================================================================
// Home Screen — Tab-based Navigation Approach Switcher
// =============================================================================
// Concepts demonstrated:
// - TabBar / TabBarView for switching between navigation approaches
// - DefaultTabController — provides tab state to descendants
// - @RoutePage() annotation for auto_route
// - Each tab demonstrates a different navigation approach:
//   1. Default Navigator (imperative: push/pop)
//   2. GoRouter (declarative: go/push with URLs)
//   3. auto_route (code-generated: type-safe routes)
//
// The home screen acts as a "launcher" — each tab is a complete mini-app
// using a different navigation approach.
// =============================================================================

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../navigation/default_navigator.dart';
import '../navigation/go_router_config.dart';
import '../navigation/auto_router_config.dart';

// -----------------------------------------------------------------------------
// Home Screen Widget
// -----------------------------------------------------------------------------

/// The root screen with tabs for each navigation approach.
///
/// Each tab launches a self-contained navigation flow using a different
/// routing library, allowing side-by-side comparison.
@RoutePage()
class HomeScreen extends StatelessWidget {
  /// Creates the [HomeScreen].
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // DefaultTabController provides tab state (selected index, animation)
    // to the TabBar and TabBarView below.
    //
    // Alternative: use TabController with a StatefulWidget and
    // SingleTickerProviderStateMixin for more control.
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('News Reader'),
          // -- TabBar in the AppBar bottom --
          // Each tab represents a navigation approach
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.navigation), text: 'Navigator'),
              Tab(icon: Icon(Icons.route), text: 'GoRouter'),
              Tab(icon: Icon(Icons.auto_awesome), text: 'AutoRoute'),
            ],
          ),
        ),
        // -- TabBarView --
        // Each tab's content is a complete navigation demo.
        // Using a nested Navigator for the default approach,
        // and embedded router widgets for GoRouter and auto_route.
        body: const TabBarView(
          // Disable swipe between tabs to avoid conflict with
          // nested navigator gestures
          physics: NeverScrollableScrollPhysics(),
          children: [
            // Tab 1: Default Navigator approach
            DefaultNavigatorDemo(),

            // Tab 2: GoRouter approach
            GoRouterDemo(),

            // Tab 3: auto_route approach
            AutoRouterDemo(),
          ],
        ),
      ),
    );
  }
}
