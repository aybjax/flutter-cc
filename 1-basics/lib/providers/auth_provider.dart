// =============================================================================
// Auth Provider
// =============================================================================
// Concepts demonstrated:
// - ChangeNotifier for state management with Provider
// - Private state fields with public getters
// - Async methods in providers (login, register, logout)
// - Error handling with try/catch and user-facing error messages
// - Auto-login flow using persisted tokens
// - notifyListeners() to trigger UI rebuilds
// - Separation: provider orchestrates services, doesn't do HTTP directly
// =============================================================================

import 'package:flutter/foundation.dart'; // ChangeNotifier

import '../models/user.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

/// Manages authentication state (login, register, logout, auto-login).
///
/// This provider sits between the UI and the services layer:
/// - UI calls provider methods (login, register, logout)
/// - Provider calls ApiService for HTTP and AuthService for persistence
/// - Provider updates its state and calls notifyListeners()
/// - Consumer widgets in the UI rebuild with the new state
///
/// State fields:
/// - [_token] — the JWT token (null when logged out)
/// - [_user] — the authenticated user (null when logged out)
/// - [_isLoading] — true while a network request is in progress
/// - [_errorMessage] — set when a request fails, cleared on next attempt
class AuthProvider extends ChangeNotifier {
  // ---------------------------------------------------------------------------
  // Dependencies
  // ---------------------------------------------------------------------------

  /// HTTP service for login/register API calls.
  final ApiService _apiService = ApiService();

  /// Persistence service for token storage.
  final AuthService _authService = AuthService();

  // ---------------------------------------------------------------------------
  // State
  // ---------------------------------------------------------------------------

  /// The current JWT token, or null if not authenticated.
  String? _token;

  /// The currently authenticated user, or null if not authenticated.
  User? _user;

  /// Whether a network request is in progress.
  ///
  /// The UI uses this to show a loading spinner and disable buttons.
  bool _isLoading = false;

  /// The error message from the last failed request, or null if no error.
  ///
  /// Cleared at the start of each new request so stale errors don't linger.
  String? _errorMessage;

  // ---------------------------------------------------------------------------
  // Getters
  // ---------------------------------------------------------------------------

  /// The JWT token. Null when the user is not authenticated.
  String? get token => _token;

  /// The authenticated user. Null when not logged in.
  User? get user => _user;

  /// Whether a login/register request is in progress.
  bool get isLoading => _isLoading;

  /// The last error message, or null.
  String? get errorMessage => _errorMessage;

  /// Whether the user is currently authenticated.
  ///
  /// Checks both token and user are present. A token without a user
  /// (or vice versa) is treated as unauthenticated.
  bool get isAuthenticated => _token != null && _user != null;

  // ---------------------------------------------------------------------------
  // Auth methods
  // ---------------------------------------------------------------------------

  /// Attempts to log in with the given credentials.
  ///
  /// Returns `true` on success, `false` on failure.
  /// On failure, [errorMessage] is set with a user-friendly message.
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null; // Clear any previous error
    notifyListeners();

    try {
      // Call the API service to perform the login HTTP request.
      final data = await _apiService.login(email, password);

      // Extract user and token from the response.
      _user = User.fromJson(data['user'] as Map<String, dynamic>);
      _token = data['token'] as String;

      // Persist the token and user info for auto-login on next app start.
      await _authService.saveToken(_token!);
      await _authService.saveUserInfo(_user!.id, _user!.email);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      // catch (e) captures any thrown exception.
      // We extract the message and store it for the UI to display.
      _isLoading = false;
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  /// Registers a new user account.
  ///
  /// On success, the user is automatically logged in (the backend returns
  /// both user and token in the register response).
  Future<bool> register(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await _apiService.register(email, password);

      _user = User.fromJson(data['user'] as Map<String, dynamic>);
      _token = data['token'] as String;

      await _authService.saveToken(_token!);
      await _authService.saveUserInfo(_user!.id, _user!.email);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  /// Logs out by clearing all auth state and persisted data.
  ///
  /// After calling this, [isAuthenticated] returns false and the UI
  /// should navigate back to the login screen.
  Future<void> logout() async {
    _token = null;
    _user = null;
    _errorMessage = null;
    notifyListeners();

    // Clear persisted auth data so auto-login won't work next time.
    await _authService.clearAll();
  }

  /// Tries to restore a previous session using the stored token.
  ///
  /// Called on app startup (e.g., in the splash screen). If a token is
  /// found in SharedPreferences, the user is restored without hitting
  /// the API.
  ///
  /// Returns `true` if auto-login succeeded (token and user info found).
  ///
  /// Note: This does not verify the token with the server. In production
  /// you would make a "me" or "verify" API call to confirm the token
  /// is still valid.
  Future<bool> tryAutoLogin() async {
    final token = await _authService.getToken();

    if (token == null) {
      return false; // No saved token — user must log in
    }

    // Retrieve the saved user info.
    final email = await _authService.getUserEmail();
    final userId = await _authService.getUserId();

    if (email == null || userId == null) {
      // Token exists but user info is missing — inconsistent state.
      // Clear everything and require a fresh login.
      await _authService.clearAll();
      return false;
    }

    // Restore the session.
    _token = token;
    _user = User(id: userId, email: email);
    notifyListeners();
    return true;
  }

  /// Clears the error message (e.g., when navigating away from the form).
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
