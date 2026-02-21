// =============================================================================
// Dio Client Setup
// =============================================================================
// Configures a single Dio instance with BaseOptions and interceptors.
// This is registered as a singleton in the DI container so every datasource
// shares the same HTTP client (and therefore the same auth token).
//
// Why Dio over http?
// - Built-in interceptor chain (auth, logging, error transform)
// - Automatic JSON serialization
// - CancelToken support for request cancellation
// - Configurable timeouts per-request or globally
// - FormData and multipart uploads out of the box
// =============================================================================

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../constants/api_constants.dart';
import 'auth_interceptor.dart';
import 'error_interceptor.dart';
import 'logging_interceptor.dart';

// ---------------------------------------------------------------------------
// DioClient
// ---------------------------------------------------------------------------

/// Wraps a [Dio] instance with app-specific configuration.
///
/// Provides a pre-configured [dio] getter and exposes the [authInterceptor]
/// so callers can set/clear the token on login/logout.
///
/// Registered as a **lazy singleton** in get_it:
/// ```dart
/// getIt.registerLazySingleton<DioClient>(() => DioClient());
/// ```
class DioClient {
  /// The underlying Dio instance. Use this for API calls.
  late final Dio dio;

  /// Exposed so the auth cubit can call setToken / clearToken.
  final AuthInterceptor authInterceptor = AuthInterceptor();

  // ---------------------------------------------------------------------------
  // Constructor - sets up BaseOptions + interceptor chain
  // ---------------------------------------------------------------------------

  DioClient() {
    // Read the base URL from the .env file loaded at startup
    final baseUrl = dotenv.env['BASE_URL'] ?? 'http://localhost:8080';

    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(
          milliseconds: ApiConstants.connectTimeout,
        ),
        receiveTimeout: Duration(
          milliseconds: ApiConstants.receiveTimeout,
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        // Alternative: set responseType to plain and parse manually
        // responseType: ResponseType.plain,
      ),
    );

    // ---------------------------------------------------------------------------
    // Interceptor ordering matters!
    // 1. Auth - adds token before the request leaves
    // 2. Logging - logs the final request (with token)
    // 3. Error - transforms errors after logging captures them
    // ---------------------------------------------------------------------------
    dio.interceptors.addAll([
      authInterceptor,
      LoggingInterceptor(),
      ErrorInterceptor(),
    ]);

    // Alternative: add retry interceptor for transient failures
    // dio.interceptors.add(RetryInterceptor(
    //   dio: dio,
    //   retries: 3,
    //   retryDelays: [
    //     Duration(seconds: 1),
    //     Duration(seconds: 2),
    //     Duration(seconds: 4),
    //   ],
    // ));
  }
}
