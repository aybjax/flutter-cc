// =============================================================================
// Main Entry Point - Product Catalog App with BLoC Pattern
// =============================================================================
// Demonstrates:
// - HydratedBloc.storage initialization (required for HydratedBloc)
// - Global BlocObserver registration
// - MultiBlocProvider for providing multiple BLoCs to the widget tree
// - Localization setup with flutter_localizations
// - Theme configuration with colorSchemeSeed
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:state_bloc_tutorial/l10n/app_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:state_bloc_tutorial/blocs/bloc_observer.dart';
import 'package:state_bloc_tutorial/blocs/product_list/product_list_bloc.dart';
import 'package:state_bloc_tutorial/blocs/product_list/product_list_event.dart';
import 'package:state_bloc_tutorial/blocs/favorites/favorites_bloc.dart';
import 'package:state_bloc_tutorial/blocs/cart/cart_bloc.dart';
import 'package:state_bloc_tutorial/repositories/product_repository.dart';
import 'package:state_bloc_tutorial/screens/product_list_screen.dart';

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------

/// App entry point.
///
/// Initialization sequence:
/// 1. Ensure Flutter bindings are initialized (required for async main)
/// 2. Initialize HydratedStorage for state persistence
/// 3. Register global BlocObserver for logging
/// 4. Run the app
Future<void> main() async {
  // Step 1: Required before any async operations in main
  WidgetsFlutterBinding.ensureInitialized();

  // Step 2: Initialize HydratedStorage for persisting BLoC state
  // This sets up local file storage for HydratedBloc to use
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: Directory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );

  // Step 3: Register the global observer for debugging
  Bloc.observer = AppBlocObserver();

  // Step 4: Run the app
  runApp(const ProductCatalogApp());
}

// ---------------------------------------------------------------------------
// App Widget
// ---------------------------------------------------------------------------

/// Root widget that sets up BLoC providers, theme, and localization.
///
/// Uses [MultiBlocProvider] to provide all BLoCs at the top of the widget
/// tree so they're accessible from any screen via `context.read<T>()`.
class ProductCatalogApp extends StatelessWidget {
  /// Creates the [ProductCatalogApp].
  const ProductCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create the repository (shared across BLoCs)
    final productRepository = ProductRepository();

    // MultiBlocProvider makes all BLoCs available to the entire widget tree
    return MultiBlocProvider(
      providers: [
        // ProductListBloc: manages product browsing, search, filtering
        BlocProvider<ProductListBloc>(
          create: (_) => ProductListBloc(repository: productRepository)
            // Immediately load products when the BLoC is created
            ..add(const ProductListEvent.loadProducts()),
        ),

        // FavoritesBloc: HydratedBloc that persists favorites to disk
        BlocProvider<FavoritesBloc>(
          create: (_) => FavoritesBloc(),
        ),

        // CartBloc: manages shopping cart state
        BlocProvider<CartBloc>(
          create: (_) => CartBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Product Catalog',
        debugShowCheckedModeBanner: false,

        // --- Theme ---
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

        // --- Localization ---
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
        ],

        // --- Home screen ---
        home: const ProductListScreen(),
      ),
    );
  }
}

// Alternative: You could use RepositoryProvider instead of creating
// the repository inline:
// MultiBlocProvider(
//   providers: [
//     RepositoryProvider(create: (_) => ProductRepository()),
//   ],
//   child: MultiBlocProvider(
//     providers: [
//       BlocProvider(
//         create: (context) => ProductListBloc(
//           repository: context.read<ProductRepository>(),
//         )..add(const ProductListEvent.loadProducts()),
//       ),
//       ...
//     ],
//     child: MaterialApp(...),
//   ),
// );
