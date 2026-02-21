// =============================================================================
// Logging Interceptor
// =============================================================================
// Logs HTTP request/response details for debugging. In production you would
// disable this or route to a proper logging framework.
// =============================================================================

import 'dart:developer' as developer;

import 'package:dio/dio.dart';

// ---------------------------------------------------------------------------
// LoggingInterceptor
// ---------------------------------------------------------------------------

/// Logs HTTP traffic for debugging purposes.
///
/// Prints request method, URL, headers, body, response status, and errors
/// using [developer.log] so output appears in DevTools.
///
/// Tip: Wrap this in a kDebugMode check so it's stripped from release builds:
/// ```dart
/// if (kDebugMode) {
///   dio.interceptors.add(LoggingInterceptor());
/// }
/// ```
class LoggingInterceptor extends Interceptor {
  // ---------------------------------------------------------------------------
  // Request logging
  // ---------------------------------------------------------------------------

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    developer.log(
      '>>> ${options.method} ${options.uri}',
      name: 'HTTP',
    );

    // Log request body if present (useful for POST/PATCH debugging)
    if (options.data != null) {
      developer.log(
        '>>> Body: ${options.data}',
        name: 'HTTP',
      );
    }

    // Alternative: log headers too (careful with sensitive data!)
    // developer.log('>>> Headers: ${options.headers}', name: 'HTTP');

    handler.next(options);
  }

  // ---------------------------------------------------------------------------
  // Response logging
  // ---------------------------------------------------------------------------

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    developer.log(
      '<<< ${response.statusCode} ${response.requestOptions.uri}',
      name: 'HTTP',
    );
    handler.next(response);
  }

  // ---------------------------------------------------------------------------
  // Error logging
  // ---------------------------------------------------------------------------

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    developer.log(
      '!!! ${err.type} ${err.requestOptions.uri}',
      name: 'HTTP',
      error: err.message,
    );
    handler.next(err);
  }
}
