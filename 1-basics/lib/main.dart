// =============================================================================
// Main Entry Point
// =============================================================================
// Concepts demonstrated:
// - runApp() — the entry point for every Flutter app
// - MultiProvider — providing multiple ChangeNotifiers to the widget tree
// - ChangeNotifierProvider — creates and provides a ChangeNotifier instance
// - MaterialApp — the root widget for Material Design apps
// - Named routes — mapping route strings to widget builders
// - onGenerateRoute — dynamic route handling and 404 pages
// - ThemeData — light and dark theme configuration
// - Consumer — rebuilding only when specific provider state changes
//
// Provider.value example (commented):
// ------------------------------------
// If you already have an instance and don't want Provider to manage its
// lifecycle (create/dispose), use Provider.value:
// ```dart
// Provider.value(
//   value: existingTodoProvider,
//   child: MaterialApp(...),
// )
// ```
// This is useful when passing providers to dialog routes or when the
// instance is created outside the widget tree.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/route_names.dart';
import 'providers/auth_provider.dart';
import 'providers/todo_provider.dart';
import 'theme/app_theme.dart';
import 'theme/theme_provider.dart';

import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/not_found_screen.dart';
import 'screens/todo/todo_detail_screen.dart';
import 'screens/todo/todo_form_screen.dart';
import 'models/todo_detail.dart';

/// The app's entry point.
///
/// [runApp] inflates the given widget and attaches it to the screen.
/// It takes a single [Widget] argument — here we wrap the entire app
/// in a [MultiProvider] so all screens can access shared state.
void main() {
  // Ensure Flutter bindings are initialized before runApp.
  // This is required when calling platform code before runApp,
  // such as SharedPreferences in provider constructors.
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    // -------------------------------------------------------------------------
    // MultiProvider
    // -------------------------------------------------------------------------
    // Wraps the widget tree with multiple providers. Each provider creates
    // a ChangeNotifier instance and makes it available to all descendants
    // via Provider.of or Consumer.
    //
    // Order matters when providers depend on each other — independent ones
    // can be in any order.
    MultiProvider(
      providers: [
        // ThemeProvider manages light/dark mode preference.
        // It loads the saved preference from SharedPreferences on creation.
        ChangeNotifierProvider(create: (_) => ThemeProvider()),

        // AuthProvider manages login state and JWT token.
        ChangeNotifierProvider(create: (_) => AuthProvider()),

        // TodoProvider manages the todo list and CRUD operations.
        ChangeNotifierProvider(create: (_) => TodoProvider()),
      ],
      child: const FlutterBasicsApp(),
    ),
  );
}

/// The root widget of the application.
///
/// Uses [Consumer] to listen to [ThemeProvider] changes so the entire
/// app rebuilds with the new theme when the user toggles dark mode.
class FlutterBasicsApp extends StatelessWidget {
  /// Creates the root app widget.
  const FlutterBasicsApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Consumer<ThemeProvider> rebuilds this subtree whenever
    // ThemeProvider calls notifyListeners() (i.e., when theme changes).
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          // -- App identity --
          title: 'Flutter Basics', // Shown in task switcher on Android

          // debugShowCheckedModeBanner: false,    // Hides the DEBUG banner
          // debugShowMaterialGrid: false,         // Shows Material grid overlay
          // showPerformanceOverlay: false,        // Shows FPS/GPU graphs
          // showSemanticsDebugger: false,         // Shows accessibility tree
          // checkerboardRasterCacheImages: false, // Highlights cached images
          // checkerboardOffscreenLayers: false,   // Highlights offscreen layers

          // -- Theme --
          theme: AppTheme.lightTheme, // Light theme definition
          darkTheme: AppTheme.darkTheme, // Dark theme definition
          themeMode: themeProvider.themeMode, // Which theme to use

          // -- Locale (internationalization) --
          // locale: Locale('en', 'US'),           // Force a specific locale
          // supportedLocales: [Locale('en'), Locale('es')],
          // localizationsDelegates: [...],         // For MaterialLocalizations

          // -- Navigation --
          initialRoute: RouteNames.splash,

          // Named routes map — simple route-name → widget mapping.
          // For routes that need arguments, use onGenerateRoute instead.
          routes: {
            RouteNames.splash: (context) => const SplashScreen(),
            RouteNames.login: (context) => const LoginScreen(),
            RouteNames.register: (context) => const RegisterScreen(),
            RouteNames.home: (context) => const HomeScreen(),
          },

          // onGenerateRoute handles:
          // 1. Routes that need arguments (e.g., todo detail with an id)
          // 2. Unknown routes (404 page)
          onGenerateRoute: (settings) {
            // settings.name is the route string (e.g., '/todo/detail')
            // settings.arguments is the data passed via Navigator.pushNamed

            // Handle routes that need arguments.
            if (settings.name == RouteNames.todoDetail) {
              final todoId = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TodoDetailScreen(todoId: todoId),
              );
            }

            if (settings.name == RouteNames.todoForm) {
              // arguments is null for create, TodoDetail for edit.
              final existingTodo = settings.arguments as TodoDetail?;
              return MaterialPageRoute(
                builder: (_) => TodoFormScreen(existingTodo: existingTodo),
              );
            }

            // Fallback: 404 page for unknown routes.
            return MaterialPageRoute(
              builder: (_) => NotFoundScreen(routeName: settings.name),
            );
          },

          // navigatorObservers: [
          //   // Add observers to track navigation events.
          //   // RouteObserver<ModalRoute>() is useful for RouteAware mixin.
          // ],
        );
      },
    );
  }
}
