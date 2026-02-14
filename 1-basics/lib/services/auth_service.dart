// =============================================================================
// Auth Service (Token Storage)
// =============================================================================
// Concepts demonstrated:
// - SharedPreferences for persistent key-value storage
// - async / await for asynchronous disk I/O
// - Nullable return types (String?) for optional values
// - Separation of concerns — this service only handles token persistence,
//   not HTTP calls or UI state
// =============================================================================

import 'package:shared_preferences/shared_preferences.dart';

/// Manages persistent storage of the authentication token.
///
/// The JWT token must survive app restarts so the user doesn't have to
/// log in every time. [SharedPreferences] is the simplest way to persist
/// small strings across sessions.
///
/// This class is intentionally thin — it wraps SharedPreferences with
/// domain-specific methods (saveToken, getToken, deleteToken) so the
/// rest of the app doesn't need to know the storage key or mechanism.
class AuthService {
  /// The key under which the JWT token is stored.
  static const String _tokenKey = 'auth_token';

  /// The key under which the user's email is stored (for display purposes).
  static const String _emailKey = 'user_email';

  /// The key under which the user's ID is stored.
  static const String _userIdKey = 'user_id';

  /// Saves the JWT token to persistent storage.
  ///
  /// Called after a successful login or registration.
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  /// Retrieves the saved JWT token, or `null` if not saved.
  ///
  /// Called during app startup to check if the user is already logged in
  /// (auto-login flow).
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// Deletes the stored token (used during logout).
  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  /// Saves user info alongside the token for quick access.
  ///
  /// We store email and user ID so we can display them without making
  /// an API call. In a real app you might store more user profile data.
  Future<void> saveUserInfo(int userId, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userIdKey, userId);
    await prefs.setString(_emailKey, email);
  }

  /// Retrieves the saved user email, or `null` if not saved.
  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }

  /// Retrieves the saved user ID, or `null` if not saved.
  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userIdKey);
  }

  /// Clears all auth-related data (token + user info).
  ///
  /// Called during logout to ensure a clean slate.
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    // Use Future.wait to run multiple async operations in parallel.
    // This is faster than awaiting each one sequentially.
    await Future.wait([
      prefs.remove(_tokenKey),
      prefs.remove(_emailKey),
      prefs.remove(_userIdKey),
    ]);
  }
}
