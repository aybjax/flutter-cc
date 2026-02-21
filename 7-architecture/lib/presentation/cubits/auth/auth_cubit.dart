// =============================================================================
// Auth Cubit
// =============================================================================
// Manages authentication state using flutter_bloc's Cubit. The cubit
// calls use cases (not repositories directly) and updates state based
// on the Either result.
// =============================================================================

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/dio_client.dart';
import '../../../domain/usecases/login_usecase.dart';
import 'auth_state.dart';

// ---------------------------------------------------------------------------
// AuthCubit
// ---------------------------------------------------------------------------

/// Manages the authentication lifecycle.
///
/// Depends on:
/// - [LoginUseCase] for executing login/register logic
/// - [DioClient] for setting/clearing the auth token
///
/// Registered as a **factory** in get_it so each usage gets a fresh instance:
/// ```dart
/// getIt.registerFactory(() => AuthCubit(
///   loginUseCase: getIt(),
///   dioClient: getIt(),
/// ));
/// ```
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final DioClient _dioClient;

  // We reuse the LoginUseCase's repository for register too.
  // In a larger app you might have a separate RegisterUseCase.

  /// Creates an [AuthCubit].
  AuthCubit({
    required LoginUseCase loginUseCase,
    required DioClient dioClient,
  })  : _loginUseCase = loginUseCase,
        _dioClient = dioClient,
        super(const AuthState.initial());

  // ---------------------------------------------------------------------------
  // Login
  // ---------------------------------------------------------------------------

  /// Attempts to log in with [email] and [password].
  ///
  /// Emits [AuthState.loading] immediately, then either
  /// [AuthState.authenticated] or [AuthState.error].
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const AuthState.loading());

    final result = await _loginUseCase(
      email: email,
      password: password,
    );

    result.fold(
      // On failure: emit error state
      (failure) => emit(AuthState.error(failure.message)),
      // On success: set token and emit authenticated state
      (user) {
        // Tell the Dio interceptor about the new token
        _dioClient.authInterceptor.setToken(user.token);
        emit(AuthState.authenticated(user));
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Register
  // ---------------------------------------------------------------------------

  /// Attempts to register with [email] and [password].
  ///
  /// Uses the auth repository directly since we don't have a separate
  /// register use case (keeping it simple for this tutorial).
  Future<void> register({
    required String email,
    required String password,
  }) async {
    emit(const AuthState.loading());

    // Access the repository through the use case's repository
    // In a real app, you'd inject a RegisterUseCase separately
    final result = await _loginUseCase(
      email: email,
      password: password,
    );

    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (user) {
        _dioClient.authInterceptor.setToken(user.token);
        emit(AuthState.authenticated(user));
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Logout
  // ---------------------------------------------------------------------------

  /// Clears the auth token and returns to initial state.
  void logout() {
    _dioClient.authInterceptor.clearToken();
    emit(const AuthState.initial());
  }

  // Alternative: persist token to secure storage
  // Future<void> checkAuthStatus() async {
  //   final token = await _secureStorage.read('token');
  //   if (token != null) {
  //     _dioClient.authInterceptor.setToken(token);
  //     emit(AuthState.authenticated(user));
  //   }
  // }
}
