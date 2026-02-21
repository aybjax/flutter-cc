// =============================================================================
// Main Entry Point
// =============================================================================
// Bootstraps the application:
// 1. Loads environment variables from .env
// 2. Sets up dependency injection via get_it
// 3. Wraps the app with BlocProviders for global state
// 4. Configures localization (English + Spanish)
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'l10n/app_localizations.dart';

import 'core/di/injection_container.dart';
import 'presentation/cubits/auth/auth_cubit.dart';
import 'presentation/screens/login_screen.dart';

// ---------------------------------------------------------------------------
// main()
// ---------------------------------------------------------------------------

/// Application entry point.
///
/// Initialization order matters:
/// 1. Flutter bindings (needed for async operations before runApp)
/// 2. .env file loading (provides BASE_URL to DioClient)
/// 3. Dependency injection setup (registers all services)
/// 4. runApp with the root widget
Future<void> main() async {
  // Ensure Flutter bindings are initialized before async work
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables from .env file
  // flutter_dotenv reads from the assets bundle at runtime
  await dotenv.load(fileName: '.env');

  // Set up all dependencies (get_it)
  await setupDependencies();

  runApp(const ArchitectureTutorialApp());
}

// ---------------------------------------------------------------------------
// Root Widget
// ---------------------------------------------------------------------------

/// The root widget of the application.
///
/// Provides:
/// - [AuthCubit] at the app level (persists across navigation)
/// - Material 3 theme with colorSchemeSeed
/// - Localization support (English + Spanish)
class ArchitectureTutorialApp extends StatelessWidget {
  /// Creates the root [ArchitectureTutorialApp] widget.
  const ArchitectureTutorialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // AuthCubit lives at the app level so it's accessible everywhere
      create: (_) => getIt<AuthCubit>(),
      child: MaterialApp(
        // ---------------------------------------------------------------------------
        // App identity
        // ---------------------------------------------------------------------------
        title: 'Architecture Tutorial',
        debugShowCheckedModeBanner: false,

        // ---------------------------------------------------------------------------
        // Theme: Material 3 with colorSchemeSeed
        // ---------------------------------------------------------------------------
        // Using colorSchemeSeed instead of ColorScheme.fromSeed
        theme: ThemeData(
          colorSchemeSeed: Colors.indigo,
          brightness: Brightness.light,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorSchemeSeed: Colors.indigo,
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,

        // Alternative: explicit ColorScheme for full control
        // theme: ThemeData(
        //   colorScheme: const ColorScheme.light(
        //     primary: Colors.indigo,
        //     secondary: Colors.amber,
        //   ),
        // ),

        // ---------------------------------------------------------------------------
        // Localization
        // ---------------------------------------------------------------------------
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,

        // ---------------------------------------------------------------------------
        // Home screen
        // ---------------------------------------------------------------------------
        home: const LoginScreen(),
      ),
    );
  }
}
