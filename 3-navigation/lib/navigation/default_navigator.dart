// =============================================================================
// Default Navigator — Traditional Imperative Navigation
// =============================================================================
// Concepts demonstrated:
// - Navigator.push() — pushes a new route onto the navigation stack
// - Navigator.pushNamed() — pushes a route by name string
// - Navigator.pop() — removes the top route from the stack
// - onGenerateRoute — dynamic route creation based on route settings
// - MaterialPageRoute — platform-adaptive page transition
// - Nested Navigator — a Navigator inside another Navigator
// - PopScope — intercepting the back button/gesture
// - RouteSettings — passing arguments with named routes
//
// The Navigator works like a STACK:
//   push → adds a page on top
//   pop  → removes the top page
//   pushReplacement → replaces the top page
//   pushAndRemoveUntil → clears the stack to a condition
//
// Alternative: CupertinoPageRoute for iOS-style slide transitions
// instead of MaterialPageRoute's platform-adaptive behavior.
// =============================================================================

import 'package:flutter/material.dart';

import '../models/models.dart';
import '../screens/category_list_screen.dart';
import '../screens/article_list_screen.dart';
import '../screens/article_detail_screen.dart';
import '../screens/search_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/login_screen.dart';

// =============================================================================
// Route Names
// =============================================================================
// Defining route names as constants prevents typos and makes refactoring
// easier. In a larger app, these would live in a separate file.

/// Route name constants for the default Navigator approach.
class DefaultRoutes {
  DefaultRoutes._();

  static const String categories = '/default/categories';
  static const String articleList = '/default/articles';
  static const String articleDetail = '/default/article';
  static const String search = '/default/search';
  static const String profile = '/default/profile';
  static const String login = '/default/login';
}

// =============================================================================
// Default Navigator Demo Widget
// =============================================================================
// This widget hosts a NESTED Navigator — a Navigator inside the main
// app's Navigator. This is useful for tab-based UIs where each tab
// maintains its own navigation stack.
//
// Key concept: Navigator.of(context) finds the NEAREST Navigator ancestor.
// With nested navigators, this is the inner one, not the root.

/// Demonstrates traditional Navigator.push/pop navigation.
///
/// Uses a nested [Navigator] so this tab maintains its own back stack
/// independent of the other tabs.
class DefaultNavigatorDemo extends StatelessWidget {
  /// Creates the [DefaultNavigatorDemo].
  const DefaultNavigatorDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // -- Nested Navigator --
    // This Navigator is INSIDE the TabBarView, so it has its own stack.
    // Pushing a route here doesn't affect the other tabs or the root Navigator.
    //
    // The key ensures the Navigator persists across tab switches.
    // Without it, the Navigator would be recreated when switching tabs.
    return Navigator(
      key: const ValueKey('default_nav'),
      // ---------------------------------------------------------------------------
      // onGenerateRoute — the "router" for the nested Navigator
      // ---------------------------------------------------------------------------
      // This callback is called when:
      // 1. The Navigator is first created (with initialRoute '/')
      // 2. Navigator.pushNamed is called with a route name
      //
      // RouteSettings contains:
      // - name: the route string (e.g., '/default/articles')
      // - arguments: arbitrary data passed with the route
      onGenerateRoute: (settings) {
        // -- Root route: category list --
        if (settings.name == '/' || settings.name == DefaultRoutes.categories) {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => _buildCategoryList(),
          );
        }

        // -- Article list for a category --
        if (settings.name == DefaultRoutes.articleList) {
          // Arguments are passed as dynamic — we cast to the expected type.
          // In production, consider using a typed arguments class.
          final categoryName = settings.arguments as String;
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => _buildArticleList(categoryName),
          );
        }

        // -- Article detail --
        if (settings.name == DefaultRoutes.articleDetail) {
          final article = settings.arguments as Article;
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => ArticleDetailScreen(
              articleId: article.id,
              article: article,
            ),
          );

          // Alternative: CupertinoPageRoute for iOS-style transitions
          // return CupertinoPageRoute(
          //   settings: settings,
          //   builder: (_) => ArticleDetailScreen(
          //     articleId: article.id,
          //     article: article,
          //   ),
          // );
        }

        // -- Search screen --
        if (settings.name == DefaultRoutes.search) {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => _buildSearchScreen(context),
          );
        }

        // -- Profile screen --
        if (settings.name == DefaultRoutes.profile) {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => const ProfileScreen(),
          );
        }

        // -- Login screen --
        if (settings.name == DefaultRoutes.login) {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => LoginScreen(
              onLoginSuccess: () => Navigator.of(context).pop(),
            ),
          );
        }

        // -- 404: Unknown route --
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Not Found')),
            body: Center(
              child: Text('Route "${settings.name}" not found'),
            ),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Screen builders with navigation callbacks
  // ---------------------------------------------------------------------------
  // These methods wire up the navigation callbacks for each screen.
  // The key insight: with default Navigator, we use IMPERATIVE navigation.
  // We explicitly push/pop routes in response to user actions.

  /// Builds the category list with push-to-article-list navigation.
  Widget _buildCategoryList() {
    return Builder(
      builder: (context) {
        return Scaffold(
          body: CategoryListScreen(
            onCategoryTap: (category) {
              // -- Navigator.pushNamed --
              // Pushes a named route with arguments.
              // The onGenerateRoute callback handles creating the route.
              Navigator.of(context).pushNamed(
                DefaultRoutes.articleList,
                arguments: category.name,
              );

              // Alternative: Navigator.push with explicit MaterialPageRoute
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (_) => _buildArticleList(category.name),
              //   ),
              // );
            },
          ),
          // Bottom navigation bar for search and profile
          bottomNavigationBar: _buildBottomBar(context),
        );
      },
    );
  }

  /// Builds the article list with push-to-detail navigation.
  Widget _buildArticleList(String categoryName) {
    return Builder(
      builder: (context) {
        return ArticleListScreen(
          categoryName: categoryName,
          onArticleTap: (article) {
            // -- Navigator.push with explicit route --
            // This approach lets you control the page transition.
            Navigator.of(context).push(
              MaterialPageRoute(
                settings: RouteSettings(
                  name: DefaultRoutes.articleDetail,
                  arguments: article,
                ),
                builder: (_) => ArticleDetailScreen(
                  articleId: article.id,
                  article: article,
                ),
              ),
            );

            // Alternative: pushNamed (shorter but less type-safe)
            // Navigator.of(context).pushNamed(
            //   DefaultRoutes.articleDetail,
            //   arguments: article,
            // );
          },
        );
      },
    );
  }

  /// Builds the search screen with navigation to article detail.
  Widget _buildSearchScreen(BuildContext outerContext) {
    return Builder(
      builder: (context) {
        return SearchScreen(
          onArticleTap: (article) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ArticleDetailScreen(
                  articleId: article.id,
                  article: article,
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Bottom navigation bar
  // ---------------------------------------------------------------------------

  /// Builds a bottom bar with search and profile buttons.
  Widget _buildBottomBar(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Search button
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {
              Navigator.of(context).pushNamed(DefaultRoutes.search);
            },
          ),
          // Profile button — demonstrates manual auth check
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Profile',
            onPressed: () {
              // -- Manual auth guard --
              // With default Navigator, we check auth state manually
              // before pushing the protected route. This is the simplest
              // approach but doesn't scale well.
              //
              // Compare with:
              // - GoRouter: redirect callback in router config
              // - auto_route: AutoRouteGuard class
              if (isAuthenticated.value) {
                Navigator.of(context).pushNamed(DefaultRoutes.profile);
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (navContext) => LoginScreen(
                      onLoginSuccess: () {
                        // After login, pop login screen and push profile
                        Navigator.of(navContext).pop();
                        Navigator.of(context).pushNamed(DefaultRoutes.profile);
                      },
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
