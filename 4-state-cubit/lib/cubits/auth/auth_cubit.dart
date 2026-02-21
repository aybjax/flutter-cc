// =============================================================================
// Auth Cubit — State Management with Cubit<AuthState>
// =============================================================================
// Concepts demonstrated:
// - Cubit<State> — the lightweight alternative to Bloc
// - emit() — the ONLY way to change state (replaces notifyListeners)
// - How Cubit wraps a Repository and transforms Either → State
// - BlocProvider — how the Cubit is provided to the widget tree
//
// Cubit vs Bloc:
// - Cubit: methods that emit states (simpler, less boilerplate)
// - Bloc: event-driven (add events → mapEventToState → emit)
// - Use Cubit when you don't need event transformers (debounce, throttle)
// - Use Bloc when you need event replay, complex event transformations
//
// Cubit vs ChangeNotifier:
// - ChangeNotifier: mutable state + notifyListeners()
// - Cubit: immutable state + emit() — state transitions are explicit
// - Cubit states are testable values: expect(cubit.state, AuthState.loading())
// - ChangeNotifier requires checking multiple fields: expect(notifier.isLoading, true)
// =============================================================================

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/auth_repository.dart';
import 'auth_state.dart';

// =============================================================================
// Auth Cubit
// =============================================================================

/// Manages authentication state using the [Cubit] pattern.
///
/// The Cubit is the "brain" between the UI and the Repository:
/// 1. UI calls cubit methods (login, register, logout)
/// 2. Cubit calls repository methods
/// 3. Cubit emits new states based on results
/// 4. UI rebuilds via BlocBuilder when state changes
///
/// Usage with BlocProvider:
/// ```dart
/// BlocProvider(
///   create: (_) => AuthCubit(authRepository: authRepo),
///   child: MyApp(),
/// )
/// ```
///
/// Then in widgets:
/// ```dart
/// // Read the cubit to call methods
/// context.read<AuthCubit>().login(email, password);
///
/// // Watch the cubit to rebuild on state changes
/// BlocBuilder<AuthCubit, AuthState>(
///   builder: (context, state) => state.when(...),
/// )
/// ```
class AuthCubit extends Cubit<AuthState> {
  /// The auth repository for making API calls.
  final AuthRepository _authRepo;

  /// Creates an [AuthCubit] with the initial state set to [AuthState.initial].
  ///
  /// The `super(...)` call sets the initial state — this is Cubit's constructor.
  /// Every Cubit must provide an initial state.
  AuthCubit({required AuthRepository authRepository})
      : _authRepo = authRepository,
        super(const AuthState.initial());

  // ---------------------------------------------------------------------------
  // LOGIN
  // ---------------------------------------------------------------------------

  /// Attempts to log in with the given credentials.
  ///
  /// State transitions:
  ///   current state → Loading → Authenticated (success) or Error (failure)
  ///
  /// The repository returns `Either<TodoFailure, (User, String)>`.
  /// We fold the Either to emit the appropriate state.
  Future<void> login(String email, String password) async {
    // Emit loading state — UI shows spinner, form is disabled
    emit(const AuthState.loading());

    // Call the repository — it returns Either, never throws
    final result = await _authRepo.login(email, password);

    // Fold the Either: Left → error state, Right → authenticated state
    //
    // This is the key pattern: repository returns Either,
    // cubit folds it into a state emit.
    result.fold(
      (failure) => emit(AuthState.error(failure)),
      (data) => emit(AuthState.authenticated(
        user: data.$1,
        token: data.$2,
      )),
    );
  }

  // ---------------------------------------------------------------------------
  // REGISTER
  // ---------------------------------------------------------------------------

  /// Attempts to register a new user.
  ///
  /// State transitions are the same as login:
  ///   current state → Loading → Authenticated (success) or Error (failure)
  ///
  /// On success, the user is immediately authenticated (the backend returns
  /// a token along with the user data).
  Future<void> register(String email, String password) async {
    emit(const AuthState.loading());

    final result = await _authRepo.register(email, password);

    result.fold(
      (failure) => emit(AuthState.error(failure)),
      (data) => emit(AuthState.authenticated(
        user: data.$1,
        token: data.$2,
      )),
    );
  }

  // ---------------------------------------------------------------------------
  // LOGOUT
  // ---------------------------------------------------------------------------

  /// Logs out the current user.
  ///
  /// State transition: Authenticated → Initial
  ///
  /// This clears the token from the repository and resets to initial state.
  /// The UI will show the login screen again.
  void logout() {
    _authRepo.logout();
    emit(const AuthState.initial());
  }
}

// =============================================================================
// How Cubit Works Under the Hood
// =============================================================================
//
// Cubit<T> extends BlocBase<T>, which provides:
// - state: the current state value (read-only from outside)
// - emit(newState): replaces the current state and notifies listeners
// - stream: a Stream<T> of state changes (used by BlocBuilder internally)
// - close(): disposes the cubit and closes the stream
//
// Key rules:
// 1. NEVER modify state directly — always use emit()
// 2. emit() is synchronous — the state is immediately updated
// 3. emit() after close() throws — the cubit is disposed
// 4. Each emit() triggers a rebuild in all BlocBuilder/BlocListener widgets
//
// BlocProvider does two things:
// 1. Creates the Cubit and provides it to the widget tree via InheritedWidget
// 2. Automatically calls close() when the widget is disposed
//
// BlocBuilder<AuthCubit, AuthState> does:
// 1. Finds AuthCubit in the widget tree (via context)
// 2. Subscribes to its stream
// 3. Calls builder() whenever a new state is emitted
// 4. Optionally filters rebuilds with buildWhen: (previous, current) => ...
//
// Testing with bloc_test:
// ```dart
// blocTest<AuthCubit, AuthState>(
//   'emits [loading, authenticated] when login succeeds',
//   build: () => AuthCubit(authRepository: mockAuthRepo),
//   act: (cubit) => cubit.login('test@test.com', 'password'),
//   expect: () => [
//     const AuthState.loading(),
//     isA<AuthAuthenticated>(),
//   ],
// );
// ```
// =============================================================================
