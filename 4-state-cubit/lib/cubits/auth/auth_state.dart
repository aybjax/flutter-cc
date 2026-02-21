// =============================================================================
// Auth State — Freezed Union for 4-State Pattern
// =============================================================================
// Concepts demonstrated:
// - The "4-state pattern": Initial, Loading, Authenticated, Error
// - Freezed sealed unions for exhaustive state handling
// - How Cubit<AuthState> emits different state variants
// - BlocBuilder renders based on which variant is active
//
// State diagram:
//   Initial → Loading → Authenticated
//                    ↘ Error
//   Authenticated → Initial (on logout)
//   Error → Loading (on retry)
//
// Cubit vs ChangeNotifier comparison:
// - ChangeNotifier: isLoading, hasError, user — multiple booleans to track
// - Cubit: a single state that is ONE of the four variants
// - The compiler ensures you handle all four cases in BlocBuilder
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/models.dart';

part 'auth_state.freezed.dart';

// =============================================================================
// Auth State Union
// =============================================================================

/// The state of the authentication Cubit.
///
/// This is a sealed union with four variants — exactly one is active at a time.
/// Use [when] or [map] for exhaustive pattern matching.
///
/// Usage in BlocBuilder:
/// ```dart
/// BlocBuilder<AuthCubit, AuthState>(
///   builder: (context, state) {
///     return state.when(
///       initial: () => LoginScreen(),
///       loading: () => CircularProgressIndicator(),
///       authenticated: (user, token) => TodoListScreen(),
///       error: (failure) => ErrorWidget(failure),
///     );
///   },
/// )
/// ```
@freezed
sealed class AuthState with _$AuthState {
  /// The initial state — no login attempt has been made yet.
  ///
  /// This is the starting state for the Cubit. The UI shows the login form.
  const factory AuthState.initial() = AuthInitial;

  /// A login or register operation is in progress.
  ///
  /// The UI should show a loading indicator and disable the form.
  const factory AuthState.loading() = AuthLoading;

  /// The user is successfully authenticated.
  ///
  /// Contains the [User] and the JWT [token] from the backend.
  /// The UI should navigate to the todo list screen.
  const factory AuthState.authenticated({
    required User user,
    required String token,
  }) = AuthAuthenticated;

  /// An authentication error occurred.
  ///
  /// Contains the typed [TodoFailure] for displaying an error message.
  /// The UI should show the error and allow the user to retry.
  const factory AuthState.error(TodoFailure failure) = AuthError;
}

// =============================================================================
// The 4-State Pattern Explained
// =============================================================================
//
// This is the core pattern this tutorial teaches. Instead of tracking state
// with multiple variables (isLoading, hasError, user, errorMessage, etc.),
// we use a single sealed union type.
//
// Benefits:
// 1. IMPOSSIBLE STATES ARE IMPOSSIBLE
//    - Can't be "loading" and "error" at the same time
//    - Can't have a user but also be in "initial" state
//    - With booleans, you can accidentally set isLoading=true AND hasError=true
//
// 2. EXHAUSTIVE HANDLING
//    - state.when() forces you to handle all four cases
//    - Adding a new state variant → compiler errors everywhere it's used
//    - With booleans, nothing forces you to check isLoading
//
// 3. TYPED DATA PER STATE
//    - AuthAuthenticated carries (User, token)
//    - AuthError carries TodoFailure
//    - AuthLoading carries nothing — it's just a marker
//    - With booleans, you'd need nullable fields that "might" be set
//
// 4. TESTABLE
//    - You can assert exact state: expect(state, AuthState.loading())
//    - No need to check multiple fields
//    - blocTest() integrates perfectly with this pattern
//
// ChangeNotifier equivalent (DON'T DO THIS):
// ```dart
// class AuthNotifier extends ChangeNotifier {
//   bool isLoading = false;
//   bool hasError = false;
//   String? errorMessage;
//   User? user;
//   String? token;
//
//   Future<void> login(...) async {
//     isLoading = true;
//     hasError = false;     // remember to reset!
//     errorMessage = null;  // remember to reset!
//     notifyListeners();
//
//     try {
//       // ... make API call
//       user = result.user;
//       token = result.token;
//       isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       isLoading = false;   // remember to set!
//       hasError = true;
//       errorMessage = e.toString();
//       notifyListeners();
//     }
//   }
// }
// ```
//
// See how many things can go wrong? With Cubit + sealed union:
// ```dart
// class AuthCubit extends Cubit<AuthState> {
//   Future<void> login(...) async {
//     emit(const AuthState.loading());
//     final result = await _repo.login(...);
//     result.fold(
//       (failure) => emit(AuthState.error(failure)),
//       (data) => emit(AuthState.authenticated(user: data.$1, token: data.$2)),
//     );
//   }
// }
// ```
// One emit per transition. No booleans. No forgetting to reset fields.
// =============================================================================
