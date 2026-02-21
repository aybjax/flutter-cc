// =============================================================================
// GoRouter Configuration — Declarative URL-based Navigation
// =============================================================================
// Concepts demonstrated:
// - GoRouter — declarative routing with URL-based navigation
// - GoRoute — defines a single route with path, builder, and children
// - ShellRoute — wraps child routes in a persistent shell (e.g., bottom nav)
// - Path parameters — /category/:name extracts "name" from the URL
// - Query parameters — /search?q=flutter extracts "q" from the URL
// - Redirect guards — redirect unauthenticated users to login
// - go() vs push():
//   * go('/path') — navigates to URL, replacing the current stack
//   * push('/path') — pushes onto the stack (like Navigator.push)
// - Sub-routes — nested route definitions for hierarchical URLs
//
// GoRouter vs Navigator:
// - GoRouter is DECLARATIVE: you define routes as a tree, not imperatively
// - URLs are first-class: every screen has a URL (great for deep links)
// - redirect() provides centralized auth guards
// - ShellRoute keeps persistent UI (like bottom nav) across routes
//
// Alternative: StatefulShellRoute for maintaining tab state when switching.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/category_list_screen.dart';
import '../screens/article_list_screen.dart';
import '../screens/article_detail_screen.dart';
import '../screens/search_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/login_screen.dart';

// =============================================================================
// GoRouter Instance
// =============================================================================
// The router is created once and reused. In a larger app, you might
// use riverpod or provider to manage the router instance.

/// Creates and configures the GoRouter for the demo.
///
/// This is a function (not a const) because redirect guards need
/// to check dynamic auth state.
GoRouter createGoRouter() {
  return GoRouter(
    // -- Initial location --
    // The URL to navigate to when the router is first created.
    initialLocation: '/go',

    // -- Debug logging --
    // Set to true to see route matching in the console.
    // Useful for debugging path parameter extraction.
    debugLogDiagnostics: true,

    // -------------------------------------------------------------------------
    // Redirect Guard
    // -------------------------------------------------------------------------
    // This callback runs BEFORE every navigation. It can return:
    // - null: allow navigation to proceed
    // - a URL string: redirect to that URL instead
    //
    // This is the GoRouter equivalent of auto_route's AutoRouteGuard.
    // Unlike Navigator (which requires manual checks), the redirect is
    // centralized and automatic.
    redirect: (context, state) {
      final isGoingToLogin = state.matchedLocation == '/go/login';
      final isGoingToProfile = state.matchedLocation == '/go/profile';

      // If not authenticated and trying to access profile, redirect to login
      if (!isAuthenticated.value && isGoingToProfile) {
        return '/go/login';
      }

      // If authenticated and on login page, redirect to profile
      if (isAuthenticated.value && isGoingToLogin) {
        return '/go/profile';
      }

      // null means "no redirect — continue to the requested route"
      return null;
    },

    // -------------------------------------------------------------------------
    // Route Definitions
    // -------------------------------------------------------------------------
    // Routes are defined as a tree. Child routes inherit the parent's path
    // prefix, so a child with path 'details' under a parent with path '/go'
    // matches '/go/details'.
    routes: [
      // -- ShellRoute --
      // A ShellRoute wraps its child routes in a persistent "shell" widget.
      // The shell widget (here: a Scaffold with bottom nav) stays on screen
      // while child routes change.
      //
      // This is perfect for bottom navigation bars, side drawers, or any
      // persistent UI that should survive route changes.
      //
      // Alternative: StatefulShellRoute preserves the state of each branch
      // when switching tabs. ShellRoute rebuilds branches on each switch.
      ShellRoute(
        builder: (context, state, child) {
          // The `child` is the widget for the currently matched child route.
          // We wrap it in a Scaffold with a bottom navigation bar.
          return _GoRouterShell(child: child);
        },
        routes: [
          // -- Category list (root) --
          GoRoute(
            path: '/go',
            builder: (context, state) {
              return CategoryListScreen(
                onCategoryTap: (category) {
                  // -- go() navigates by replacing the stack --
                  // go('/go/category/tech') changes the URL to that path.
                  // The router matches the URL and builds the right widget.
                  context.go('/go/category/${category.name}');

                  // Alternative: push() adds to the stack
                  // context.push('/go/category/${category.name}');
                  //
                  // Difference:
                  // go()  → URL changes, back button goes to parent
                  // push()→ URL changes, back button goes to previous page
                },
              );
            },
            routes: [
              // -- Article list (nested under /go) --
              // Path: /go/category/:categoryName
              //
              // The :categoryName is a PATH PARAMETER — GoRouter extracts
              // the value from the URL and provides it via state.pathParameters.
              GoRoute(
                path: 'category/:categoryName',
                builder: (context, state) {
                  // Extract path parameter
                  final categoryName = state.pathParameters['categoryName']!;

                  return ArticleListScreen(
                    categoryName: categoryName,
                    onArticleTap: (article) {
                      // Navigate to article detail with the article ID in the URL
                      context.go('/go/article/${article.id}');
                    },
                  );
                },
              ),

              // -- Article detail --
              // Path: /go/article/:articleId
              //
              // This route is a sibling of category, not nested under it.
              // Deep links can go directly to an article: /go/article/tech-1
              GoRoute(
                path: 'article/:articleId',
                builder: (context, state) {
                  final articleId = state.pathParameters['articleId']!;
                  return ArticleDetailScreen(articleId: articleId);
                },
              ),

              // -- Search --
              // Path: /go/search?q=flutter
              //
              // Query parameters are extracted from state.uri.queryParameters.
              // Unlike path params (which are part of the path), query params
              // are optional and come after the '?' in the URL.
              GoRoute(
                path: 'search',
                builder: (context, state) {
                  // Extract optional query parameter
                  final query = state.uri.queryParameters['q'];

                  return SearchScreen(
                    initialQuery: query,
                    onArticleTap: (article) {
                      context.go('/go/article/${article.id}');
                    },
                  );
                },
              ),

              // -- Profile (auth-protected) --
              // The redirect guard above handles auth checking for this route.
              GoRoute(
                path: 'profile',
                builder: (context, state) => const ProfileScreen(),
              ),

              // -- Login --
              GoRoute(
                path: 'login',
                builder: (context, state) {
                  return LoginScreen(
                    onLoginSuccess: () {
                      // After login, go to profile (redirect guard handles
                      // the case where they're already logged in)
                      context.go('/go/profile');
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

// =============================================================================
// GoRouter Shell Widget
// =============================================================================
// This widget wraps all routes inside the ShellRoute. It provides
// a persistent bottom navigation bar that stays on screen as the
// user navigates between categories, search, and profile.

/// Persistent shell with bottom navigation for GoRouter routes.
class _GoRouterShell extends StatelessWidget {
  /// The child widget (current route's content).
  final Widget child;

  const _GoRouterShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Categories (home)
            IconButton(
              icon: const Icon(Icons.home),
              tooltip: 'Categories',
              onPressed: () => context.go('/go'),
            ),
            // Search
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () => context.go('/go/search'),

              // Alternative with query parameter:
              // onPressed: () => context.go('/go/search?q=flutter'),
            ),
            // Profile (auth-guarded)
            IconButton(
              icon: const Icon(Icons.person),
              tooltip: 'Profile',
              onPressed: () => context.go('/go/profile'),
              // No manual auth check needed — the redirect guard handles it!
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// GoRouter Demo Widget
// =============================================================================
// This widget embeds the GoRouter as a nested router inside the tab.
// MaterialApp.router would normally be the root, but since we're inside
// a TabBarView, we use Router directly.

/// Wraps GoRouter in a widget that can live inside a TabBarView.
///
/// In a standalone app, you'd use `MaterialApp.router(routerConfig: goRouter)`.
/// Here, we embed it as a nested router for the demo.
class GoRouterDemo extends StatefulWidget {
  /// Creates the [GoRouterDemo].
  const GoRouterDemo({super.key});

  @override
  State<GoRouterDemo> createState() => _GoRouterDemoState();
}

class _GoRouterDemoState extends State<GoRouterDemo> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = createGoRouter();
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Router widget wraps GoRouter's routerDelegate and routeInformationParser.
    // In a full app, you'd use MaterialApp.router instead.
    //
    // MaterialApp.router(
    //   routerConfig: _router,
    // )
    return Router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}

// =============================================================================
// go() vs push() — Key Difference
// =============================================================================
//
// context.go('/go/article/tech-1'):
//   - Navigates to the URL, building the route stack from scratch
//   - The back button follows the route hierarchy (parent routes)
//   - Like typing a URL in a browser
//
// context.push('/go/article/tech-1'):
//   - Pushes the route ON TOP of the current stack
//   - The back button goes back to the previous page (not parent)
//   - Like clicking a link that opens in the same tab
//
// Example:
//   From /go/category/tech, viewing article tech-1:
//
//   go('/go/article/tech-1'):
//     Stack: [/go, /go/article/tech-1]
//     Back → /go (category list, not tech articles)
//
//   push('/go/article/tech-1'):
//     Stack: [/go, /go/category/tech, /go/article/tech-1]
//     Back → /go/category/tech (tech articles list)
