// =============================================================================
// Error Interceptor
// =============================================================================
// Transforms raw Dio errors into app-specific DioExceptions with clear
// messages. This keeps error handling consistent across all API calls.
// =============================================================================

import 'package:dio/dio.dart';

// ---------------------------------------------------------------------------
// ErrorInterceptor
// ---------------------------------------------------------------------------

/// Transforms raw HTTP errors into structured, user-friendly messages.
///
/// Instead of letting each repository handle raw DioExceptions, this
/// interceptor normalizes error messages at the network layer.
///
/// The error_interceptor sits *after* the logging interceptor in the
/// interceptor chain so errors are logged before being transformed.
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // ---------------------------------------------------------------------------
    // Extract a meaningful message from the response or fall back to defaults
    // ---------------------------------------------------------------------------

    String message;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = 'Connection timed out. Please try again.';
        break;

      case DioExceptionType.connectionError:
        message = 'Could not connect to server. Is it running?';
        break;

      case DioExceptionType.badResponse:
        // Try to extract error message from the response body
        message = _extractErrorMessage(err.response);
        break;

      case DioExceptionType.cancel:
        message = 'Request was cancelled.';
        break;

      // Alternative: handle badCertificate for SSL pinning
      // case DioExceptionType.badCertificate:
      //   message = 'SSL certificate validation failed.';
      //   break;

      default:
        message = err.message ?? 'An unexpected network error occurred.';
    }

    // Re-throw with the cleaned-up message
    handler.next(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: err.error,
        message: message,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Tries to pull an error message from the JSON response body.
  String _extractErrorMessage(Response? response) {
    if (response == null) return 'No response from server.';

    final statusCode = response.statusCode ?? 0;
    final data = response.data;

    // The Go backend returns {"error": "..."} on failure
    if (data is Map<String, dynamic> && data.containsKey('error')) {
      return data['error'] as String;
    }

    // Fall back to status-code-based messages
    if (statusCode == 401) return 'Unauthorized. Please login again.';
    if (statusCode == 403) return 'You do not have permission.';
    if (statusCode == 404) return 'Resource not found.';
    if (statusCode >= 500) return 'Server error ($statusCode). Try later.';

    return 'Request failed with status $statusCode.';
  }
}
