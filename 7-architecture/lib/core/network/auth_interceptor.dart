// =============================================================================
// Auth Interceptor
// =============================================================================
// Automatically attaches the Bearer token to every outgoing request.
// This keeps auth logic out of individual API calls - a single place
// manages token injection.
// =============================================================================

import 'package:dio/dio.dart';

// ---------------------------------------------------------------------------
// AuthInterceptor
// ---------------------------------------------------------------------------

/// Intercepts outgoing requests to attach the JWT Bearer token.
///
/// The token is stored in-memory and updated via [setToken].
/// When the token is null, requests go out without authorization
/// (useful for login/register endpoints).
///
/// Usage with Dio:
/// ```dart
/// final authInterceptor = AuthInterceptor();
/// dio.interceptors.add(authInterceptor);
///
/// // After login:
/// authInterceptor.setToken(response.token);
/// ```
class AuthInterceptor extends Interceptor {
  /// The current JWT token. Null means unauthenticated.
  String? _token;

  /// Updates the stored token (call after login/register).
  void setToken(String? token) {
    _token = token;
  }

  /// Clears the stored token (call on logout).
  void clearToken() {
    _token = null;
  }

  // ---------------------------------------------------------------------------
  // Interceptor overrides
  // ---------------------------------------------------------------------------

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Only add the header if we have a token
    if (_token != null && _token!.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $_token';
    }

    // Alternative: you could skip auth for specific paths
    // final publicPaths = ['/login', '/register'];
    // if (!publicPaths.contains(options.path) && _token != null) {
    //   options.headers['Authorization'] = 'Bearer $_token';
    // }

    handler.next(options);
  }
}
