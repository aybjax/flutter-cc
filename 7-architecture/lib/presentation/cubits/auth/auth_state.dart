// =============================================================================
// Auth State (Freezed Union)
// =============================================================================
// All possible states for the authentication flow. Using @freezed gives
// us exhaustive when() matching in the UI.
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/user_entity.dart';

part 'auth_state.freezed.dart';

// ---------------------------------------------------------------------------
// AuthState
// ---------------------------------------------------------------------------

/// Represents all possible states of the auth flow.
///
/// The UI uses pattern matching to render the correct screen:
/// ```dart
/// state.when(
///   initial: () => LoginScreen(),
///   loading: () => CircularProgressIndicator(),
///   authenticated: (user) => TodoListScreen(),
///   error: (message) => ErrorWidget(message),
/// );
/// ```
@freezed
class AuthState with _$AuthState {
  /// Initial state before any auth action.
  const factory AuthState.initial() = _Initial;

  /// Loading state while login/register is in progress.
  const factory AuthState.loading() = _Loading;

  /// Successfully authenticated with [user] data.
  const factory AuthState.authenticated(UserEntity user) = _Authenticated;

  /// Authentication failed with [message].
  const factory AuthState.error(String message) = _Error;

  // Alternative: add an unauthenticated state for explicit logout
  // const factory AuthState.unauthenticated() = _Unauthenticated;
}
