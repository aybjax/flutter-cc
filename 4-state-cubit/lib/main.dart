// =============================================================================
// Main Entry Point — 4-state-cubit: Cubit State Management
// =============================================================================
// Concepts demonstrated:
// - MultiBlocProvider — providing multiple Cubits to the widget tree
// - BlocBuilder — rendering UI based on cubit state
// - RepositoryProvider — providing repositories for cubits to use
// - Auth-based navigation: login screen vs todo list based on AuthState
// - Locale switching at runtime with l10n
//
// This app is a "Todo App" that teaches:
// 1. Cubit<State> — lightweight state management (simpler than Bloc)
// 2. emit() — the only way to change state (replaces notifyListeners)
// 3. BlocProvider / BlocBuilder / BlocListener / BlocConsumer
// 4. Freezed sealed unions — 4-state pattern (Initial, Loading, Loaded, Error)
// 5. MultiBlocProvider — providing multiple cubits
// 6. dartz Either — functional error handling in the repository layer
// 7. Repository pattern — abstracting HTTP calls from cubits
//
// Architecture:
//   main.dart
//     → MultiBlocProvider (AuthCubit)
//       → BlocBuilder<AuthCubit> (auth-based navigation)
//         → LoginScreen (not authenticated)
//         → BlocProvider<TodoListCubit> + TodoListScreen (authenticated)
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'cubits/auth/auth_cubit.dart';
import 'cubits/auth/auth_state.dart';
import 'cubits/todo/todo_list_cubit.dart';
import 'l10n/generated/app_localizations.dart';
import 'repositories/auth_repository.dart';
import 'repositories/todo_repository.dart';
import 'screens/login_screen.dart';
import 'screens/todo_list_screen.dart';

// =============================================================================
// App Entry Point
// =============================================================================

/// The app's entry point.
///
/// We create repositories here and provide them via [RepositoryProvider].
/// Cubits are created via [BlocProvider] and receive repositories via
/// constructor injection.
///
/// In later tutorials, you'd use get_it or injectable for full DI.
void main() {
  runApp(const StateCubitTutorialApp());
}

// =============================================================================
// Root Widget with Locale State and MultiBlocProvider
// =============================================================================

/// Root widget that manages locale and provides cubits to the widget tree.
///
/// This is a StatefulWidget for two reasons:
/// 1. Managing the current locale (for language switching)
/// 2. Holding repository instances (created once, shared everywhere)
///
/// The key architecture decision here is WHERE to provide cubits:
/// - AuthCubit: provided at the root — it's needed everywhere
/// - TodoListCubit: provided only when authenticated — it needs a token
/// - TodoDetailCubit: provided per-screen — each detail view is independent
class StateCubitTutorialApp extends StatefulWidget {
  const StateCubitTutorialApp({super.key});

  @override
  State<StateCubitTutorialApp> createState() => _StateCubitTutorialAppState();
}

class _StateCubitTutorialAppState extends State<StateCubitTutorialApp>
    with AppLocaleStateMixin {
  /// Current locale. Defaults to English.
  Locale _locale = const Locale('en');

  /// The shared auth repository (created once, used by AuthCubit).
  final _authRepo = AuthRepository();

  /// Called by the language switcher to change the locale at runtime.
  @override
  void setLocale(Locale locale) {
    setState(() => _locale = locale);
  }

  @override
  Widget build(BuildContext context) {
    // Create the todo repository — it needs the auth repo for the Bearer token
    final todoRepo = TodoRepository(authRepo: _authRepo);

    // =========================================================================
    // MultiRepositoryProvider + MultiBlocProvider
    // =========================================================================
    // MultiRepositoryProvider provides plain objects (repositories) to the tree.
    // MultiBlocProvider provides Cubits/Blocs to the tree.
    //
    // Why separate?
    // - Repositories are plain Dart classes (not Cubit/Bloc)
    // - RepositoryProvider uses Provider under the hood
    // - BlocProvider uses Provider + auto-close
    //
    // The order matters:
    // 1. Repositories first (cubits depend on them)
    // 2. Cubits second (UI depends on them)
    return MultiRepositoryProvider(
      providers: [
        // Provide repositories so cubits and screens can access them
        RepositoryProvider<AuthRepository>.value(value: _authRepo),
        RepositoryProvider<TodoRepository>.value(value: todoRepo),
      ],
      child: MultiBlocProvider(
        // =====================================================================
        // MultiBlocProvider — providing multiple Cubits
        // =====================================================================
        // MultiBlocProvider wraps multiple BlocProvider widgets into one.
        // Without it, you'd have deeply nested BlocProviders:
        //
        // BlocProvider<AuthCubit>(
        //   create: ...,
        //   child: BlocProvider<SomeOtherCubit>(
        //     create: ...,
        //     child: App(),  // deeply nested!
        //   ),
        // )
        //
        // MultiBlocProvider flattens this into a list.
        providers: [
          // AuthCubit is provided at the root — it's needed everywhere
          BlocProvider<AuthCubit>(
            create: (_) => AuthCubit(authRepository: _authRepo),
          ),
        ],
        child: MaterialApp(
          // -- App identity --
          title: 'Todo App',
          debugShowCheckedModeBanner: false,

          // -- Theme --
          // Using colorSchemeSeed instead of ColorScheme.fromSeed
          theme: ThemeData(
            colorSchemeSeed: Colors.indigo,
            useMaterial3: true,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            colorSchemeSeed: Colors.indigo,
            useMaterial3: true,
            brightness: Brightness.dark,
          ),

          // -- Localization --
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: _locale,

          // -- Auth-based navigation --
          // BlocBuilder at the root level switches between login and todo list
          // based on the AuthCubit's state.
          home: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return state.when(
                // Not logged in → show login screen
                initial: () => const LoginScreen(),

                // Loading → show login with a spinner (handled inside LoginScreen)
                loading: () => const LoginScreen(),

                // Authenticated → show todo list
                // We create the TodoListCubit HERE, because it needs the token
                // which is only available after authentication.
                authenticated: (user, token) => BlocProvider(
                  // Create TodoListCubit and immediately load todos
                  create: (context) => TodoListCubit(
                    todoRepository: context.read<TodoRepository>(),
                  )..loadTodos(),
                  child: const TodoListScreen(),
                ),

                // Error → show login screen (error is shown via snackbar)
                error: (failure) => const LoginScreen(),
              );
            },
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// Cubit vs ChangeNotifier — A Complete Comparison
// =============================================================================
//
// ChangeNotifier approach (from Provider):
// ```dart
// class AuthNotifier extends ChangeNotifier {
//   bool _isLoading = false;
//   bool _hasError = false;
//   String? _errorMessage;
//   User? _user;
//   String? _token;
//
//   bool get isLoading => _isLoading;
//   bool get isAuthenticated => _token != null;
//
//   Future<void> login(String email, String password) async {
//     _isLoading = true;
//     _hasError = false;
//     _errorMessage = null;
//     notifyListeners();
//
//     try {
//       final result = await _repo.login(email, password);
//       _user = result.user;
//       _token = result.token;
//       _isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       _isLoading = false;
//       _hasError = true;
//       _errorMessage = e.toString();
//       notifyListeners();
//     }
//   }
// }
// ```
//
// Problems with ChangeNotifier:
// 1. Multiple mutable fields that must stay in sync
// 2. Easy to forget resetting flags (isLoading, hasError)
// 3. notifyListeners() rebuilds ALL consumers, even if their data didn't change
// 4. No exhaustive handling — easy to miss a state
// 5. Testing requires checking multiple fields
//
// Cubit approach (this tutorial):
// ```dart
// class AuthCubit extends Cubit<AuthState> {
//   AuthCubit(...) : super(const AuthState.initial());
//
//   Future<void> login(String email, String password) async {
//     emit(const AuthState.loading());
//     final result = await _repo.login(email, password);
//     result.fold(
//       (failure) => emit(AuthState.error(failure)),
//       (data) => emit(AuthState.authenticated(user: data.$1, token: data.$2)),
//     );
//   }
// }
// ```
//
// Advantages:
// 1. Single state object — impossible to have inconsistent state
// 2. Exhaustive handling — state.when() forces handling all cases
// 3. Immutable states — no accidental mutation
// 4. Simple testing: expect(cubit.state, AuthState.loading())
// 5. No boilerplate: just emit(newState)
//
// When to use Cubit vs Bloc:
// - Cubit: simpler, methods → emit (this tutorial)
// - Bloc: event-driven, add(event) → on<Event> → emit
// - Use Bloc when you need event transformers (debounce, throttle)
// - Use Bloc when you need event replay/logging
// - Use Cubit for everything else (most cases)
// =============================================================================
