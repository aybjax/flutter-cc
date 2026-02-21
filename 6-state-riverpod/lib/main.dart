// =============================================================================
// Main Entry Point — ProviderScope wrapping MaterialApp
// =============================================================================
//
// The entire Riverpod state tree lives inside [ProviderScope]. Every provider
// declared anywhere in the app is lazily initialised and cached here.
//
// Key Riverpod concepts demonstrated in this file:
//  - ProviderScope: the root container for all provider state.
//  - ConsumerWidget: a widget that can read providers via `ref`.
//  - ProviderScope overrides: shown in comments for testing patterns.
//
// To run:
//   flutter run
//
// To regenerate code-gen files:
//   dart run build_runner build --delete-conflicting-outputs
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_riverpod_tutorial/l10n/app_localizations.dart';
import 'package:state_riverpod_tutorial/screens/home_screen.dart';
import 'package:state_riverpod_tutorial/screens/settings_screen.dart';

// ---------------------------------------------------------------------------
// App entry point
// ---------------------------------------------------------------------------

/// Application entry point.
///
/// Wraps the entire widget tree in a [ProviderScope] so that all Riverpod
/// providers are available to every widget.
void main() {
  runApp(
    // ProviderScope MUST be at the very top of the widget tree.
    // It stores the state for all providers.
    const ProviderScope(
      // You can pass `overrides` here for testing or configuration:
      //
      // overrides: [
      //   weatherRepositoryProvider.overrideWithValue(FakeWeatherRepo()),
      // ],
      child: WeatherApp(),
    ),
  );
}

// Alternative: for testing you'd create ProviderScope per test:
//
// testWidgets('shows weather', (tester) async {
//   await tester.pumpWidget(
//     ProviderScope(
//       overrides: [
//         weatherRepositoryProvider.overrideWithValue(mockRepo),
//       ],
//       child: const WeatherApp(),
//     ),
//   );
//   ...
// });

// ---------------------------------------------------------------------------
// Root App Widget
// ---------------------------------------------------------------------------

/// The root application widget.
///
/// Extends [ConsumerWidget] so it can read the locale provider to dynamically
/// switch the app's language.
class WeatherApp extends ConsumerWidget {
  /// Creates the [WeatherApp].
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the locale provider to reactively update the app language
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      title: 'Weather Dashboard',
      debugShowCheckedModeBanner: false,

      // -------------------------------------------------------------------
      // Theme — using colorSchemeSeed (NOT ColorScheme.fromSeed)
      // -------------------------------------------------------------------
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,

      // -------------------------------------------------------------------
      // Localisation
      // -------------------------------------------------------------------
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale, // null => use system locale

      // -------------------------------------------------------------------
      // Home screen
      // -------------------------------------------------------------------
      home: const HomeScreen(),
    );
  }
}
