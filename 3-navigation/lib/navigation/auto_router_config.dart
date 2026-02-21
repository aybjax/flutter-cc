// =============================================================================
// auto_route Configuration — Code-Generated Type-Safe Routing
// =============================================================================
// Concepts demonstrated:
// - @AutoRouterConfig — marks this class as the router configuration
// - @RoutePage() — annotates screen widgets to generate route classes
// - AutoRouteGuard — intercepts navigation for auth checks
// - AutoTabsRouter — tab-based navigation with auto_route
// - Nested routes — child routes for hierarchical navigation
// - Type-safe route arguments — no casting, no stringly-typed params
// - part directive — connects to generated auto_router_config.gr.dart
//
// How auto_route works:
// 1. Annotate screens with @RoutePage()
// 2. Define route tree in @AutoRouterConfig class
// 3. Run build_runner to generate route classes
// 4. Navigate with type-safe methods: context.pushRoute(ArticleDetailRoute(...))
//
// auto_route vs GoRouter:
// - auto_route: code-generated, type-safe arguments, annotation-based
// - GoRouter: manual config, string-based paths, URI params
// Both support deep linking, guards, and nested navigation.
//
// auto_route vs Navigator:
// - auto_route: declarative config, generated code, built-in guards
// - Navigator: imperative push/pop, manual route matching
// =============================================================================

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../screens/home_screen.dart';
import '../screens/category_list_screen.dart';
import '../screens/article_list_screen.dart';
import '../screens/article_detail_screen.dart';
import '../screens/search_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/login_screen.dart';

// -- Part directive for generated code --
// build_runner generates auto_router_config.gr.dart containing:
// - Route classes (e.g., CategoryListRoute, ArticleDetailRoute)
// - RouteArgs classes for type-safe argument passing
// - Route data serialization for deep linking
part 'auto_router_config.gr.dart';

// =============================================================================
// Router Configuration
// =============================================================================
// The @AutoRouterConfig annotation tells auto_route_generator to:
// 1. Scan @RoutePage() annotated widgets listed in routes
// 2. Generate corresponding Route classes with type-safe args
// 3. Generate the routing infrastructure (RouteParser, RouteGuard support)

/// The auto_route router configuration for the News Reader app.
///
/// Defines all routes, their paths, and nesting relationships.
/// The generated file (auto_router_config.gr.dart) contains the
/// actual Route classes used for navigation.
@AutoRouterConfig()
class AppAutoRouter extends RootStackRouter {
  // ---------------------------------------------------------------------------
  // Route Definitions
  // ---------------------------------------------------------------------------
  // Each AutoRoute defines:
  // - page: the generated Route class (from @RoutePage annotation)
  // - path: the URL path for deep linking
  // - children: nested routes for hierarchical navigation
  //
  // The generator creates Route classes by appending "Route" to the
  // screen class name: CategoryListScreen → CategoryListRoute

  @override
  List<AutoRoute> get routes => [
    // -- Category list (root) --
    AutoRoute(
      page: CategoryListRoute.page,
      path: '/auto',
      // initial: true means this is the default route
      initial: true,
    ),

    // -- Article list --
    // Path parameter :categoryName is extracted from the URL
    // and passed to ArticleListScreen's constructor
    AutoRoute(
      page: ArticleListRoute.page,
      path: '/auto/category/:categoryName',
    ),

    // -- Article detail --
    // :articleId is extracted and passed to ArticleDetailScreen
    AutoRoute(
      page: ArticleDetailRoute.page,
      path: '/auto/article/:articleId',
    ),

    // -- Search --
    // Query parameters (like ?q=flutter) are handled by @queryParam
    AutoRoute(
      page: SearchRoute.page,
      path: '/auto/search',
    ),

    // -- Profile (auth-guarded) --
    // The guard is applied via onNavigation override below
    AutoRoute(
      page: ProfileRoute.page,
      path: '/auto/profile',
    ),

    // -- Login --
    AutoRoute(
      page: LoginRoute.page,
      path: '/auto/login',
    ),
  ];

  // ---------------------------------------------------------------------------
  // Navigation Guards
  // ---------------------------------------------------------------------------
  // The guards getter returns a list of AutoRouteGuard instances.
  // Each guard's onNavigation is called before every route change.
  //
  // resolver.next() — allow navigation to proceed
  // resolver.redirect(route) — redirect to a different route
  //
  // This is more flexible than GoRouter's redirect because you can
  // show dialogs, await user input, etc.

  @override
  List<AutoRouteGuard> get guards => [
    // AutoRouteGuard.simple wraps a callback into an AutoRouteGuard.
    // For complex guards, extend AutoRouteGuard directly.
    AutoRouteGuard.simple((resolver, router) {
      // Check if the target route requires authentication
      final isProfileRoute = resolver.route.name == ProfileRoute.name;

      if (isProfileRoute && !isAuthenticated.value) {
        // Redirect to login, with a callback to retry after login
        resolver.redirect(
          LoginRoute(
            onLoginSuccess: () {
              // After login, retry the original navigation
              resolver.next();
              // Pop the login screen
              router.maybePop();
            },
          ),
        );
      } else {
        // Allow navigation to proceed
        resolver.next();
      }
    }),
  ];
}

// =============================================================================
// auto_route Demo Widget
// =============================================================================
// This widget embeds the auto_route router inside a TabBarView tab.
// In a standalone app, you'd use MaterialApp.router with the generated
// router's config.

/// Wraps auto_route in a widget for the demo tab.
class AutoRouterDemo extends StatefulWidget {
  /// Creates the [AutoRouterDemo].
  const AutoRouterDemo({super.key});

  @override
  State<AutoRouterDemo> createState() => _AutoRouterDemoState();
}

class _AutoRouterDemoState extends State<AutoRouterDemo> {
  late final AppAutoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppAutoRouter();
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Router.withConfig uses the auto_route configuration to manage navigation.
    //
    // In a full app, you'd use:
    // MaterialApp.router(
    //   routerConfig: _router.config(),
    // )
    return Router.withConfig(config: _router.config());
  }
}

// =============================================================================
// How @RoutePage() and Code Generation Work
// =============================================================================
//
// 1. You annotate a screen widget:
//    @RoutePage()
//    class ArticleDetailScreen extends StatelessWidget { ... }
//
// 2. build_runner generates a Route class:
//    class ArticleDetailRoute extends PageRouteInfo<ArticleDetailRouteArgs> {
//      ArticleDetailRoute({required String articleId, ...})
//    }
//
// 3. You navigate with type-safe arguments:
//    context.pushRoute(ArticleDetailRoute(articleId: 'tech-1'));
//    // vs GoRouter: context.go('/article/tech-1')  ← stringly typed
//    // vs Navigator: Navigator.pushNamed(context, '/article', arguments: 'tech-1')
//
// 4. Deep links work automatically:
//    URL /auto/article/tech-1 → ArticleDetailRoute(articleId: 'tech-1')
//
// Benefits over manual routing:
// - Compile-time safety: wrong argument types = build error
// - Refactoring: rename a parameter → all call sites update
// - No string matching: routes are classes, not strings
// - Auto-generated: less boilerplate than manual RouteSettings handling
