// =============================================================================
// Auth Repository — Login/Register with dartz Either
// =============================================================================
// Concepts demonstrated:
// - HTTP requests to the Go backend using the http package
// - dartz Either<TodoFailure, T> for typed error handling
// - Token storage in memory (in production, use secure_storage)
// - How the repository layer abstracts network calls from the Cubit
//
// Architecture:
//   UI (Screen) → Cubit → Repository → HTTP → Go Backend
//
// The repository:
// 1. Makes HTTP requests to the backend
// 2. Parses JSON responses
// 3. Returns Either<TodoFailure, Success> — never throws
// 4. Stores the auth token for subsequent API calls
//
// Cubit vs ChangeNotifier comparison:
// - With ChangeNotifier, the repository might notify listeners directly
// - With Cubit, the repository is a plain class — the Cubit calls it
//   and decides what state to emit based on the Either result
// =============================================================================

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

// =============================================================================
// Auth Repository
// =============================================================================

/// Handles authentication (login/register) with the Go backend.
///
/// Returns [Either<TodoFailure, (User, String)>] where:
/// - Left = typed failure (network, server, validation, etc.)
/// - Right = tuple of (User, token) on success
///
/// The token is also stored internally so [TodoRepository] can access it.
class AuthRepository {
  /// Base URL for the Go backend.
  ///
  /// In production, this would come from environment config or flavor.
  final String _baseUrl;

  /// The HTTP client. Injectable for testing.
  ///
  /// In production, you'd inject a mock client for unit tests.
  final http.Client _client;

  /// The current auth token, set after successful login/register.
  ///
  /// In production, store this in flutter_secure_storage instead.
  String? _token;

  /// The currently logged-in user.
  User? _currentUser;

  /// Creates an [AuthRepository] with optional base URL and HTTP client.
  ///
  /// Default base URL points to the local Go backend.
  AuthRepository({
    String baseUrl = 'http://localhost:8080',
    http.Client? client,
  })  : _baseUrl = baseUrl,
        _client = client ?? http.Client();

  // ---------------------------------------------------------------------------
  // Public Accessors
  // ---------------------------------------------------------------------------

  /// The current auth token, or null if not logged in.
  String? get token => _token;

  /// The currently logged-in user, or null.
  User? get currentUser => _currentUser;

  /// Whether the user is currently authenticated.
  bool get isAuthenticated => _token != null;

  // ---------------------------------------------------------------------------
  // LOGIN
  // ---------------------------------------------------------------------------

  /// Logs in with email and password.
  ///
  /// Returns [Either]:
  /// - Left([TodoFailure]) on any error
  /// - Right(([User], token)) on success
  ///
  /// The token is stored internally for use by [TodoRepository].
  ///
  /// Example:
  /// ```dart
  /// final result = await authRepo.login('alice@example.com', 'password123');
  /// result.fold(
  ///   (failure) => print('Login failed: $failure'),
  ///   (data) {
  ///     final (user, token) = data;
  ///     print('Welcome, ${user.email}!');
  ///   },
  /// );
  /// ```
  Future<Either<TodoFailure, (User, String)>> login(
    String email,
    String password,
  ) async {
    // Validate inputs before making the network call
    if (email.trim().isEmpty) {
      return const Left(
        TodoFailure.validation(field: 'email', message: 'Email is required'),
      );
    }
    if (password.isEmpty) {
      return const Left(
        TodoFailure.validation(
          field: 'password',
          message: 'Password is required',
        ),
      );
    }

    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email.trim(), 'password': password}),
      );

      return _handleAuthResponse(response);
    } catch (e) {
      // Network errors (no connectivity, DNS failure, timeout, etc.)
      return Left(TodoFailure.network(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // REGISTER
  // ---------------------------------------------------------------------------

  /// Registers a new user with email and password.
  ///
  /// Returns [Either]:
  /// - Left([TodoFailure]) on any error (e.g., email already taken)
  /// - Right(([User], token)) on success
  ///
  /// The token is stored internally, so the user is logged in immediately.
  Future<Either<TodoFailure, (User, String)>> register(
    String email,
    String password,
  ) async {
    // Validate inputs before making the network call
    if (email.trim().isEmpty) {
      return const Left(
        TodoFailure.validation(field: 'email', message: 'Email is required'),
      );
    }
    if (password.isEmpty) {
      return const Left(
        TodoFailure.validation(
          field: 'password',
          message: 'Password is required',
        ),
      );
    }

    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email.trim(), 'password': password}),
      );

      return _handleAuthResponse(response);
    } catch (e) {
      return Left(TodoFailure.network(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // LOGOUT
  // ---------------------------------------------------------------------------

  /// Clears the stored token and user data.
  ///
  /// This is a local-only operation — the Go backend doesn't have a
  /// logout endpoint (JWTs are stateless).
  void logout() {
    _token = null;
    _currentUser = null;
  }

  // ---------------------------------------------------------------------------
  // Private Helpers
  // ---------------------------------------------------------------------------

  /// Parses an auth response (login or register) and stores the token.
  ///
  /// The Go backend returns:
  /// ```json
  /// { "user": { "id": 1, "email": "..." }, "token": "jwt..." }
  /// ```
  ///
  /// On error, it returns:
  /// ```json
  /// { "error": "invalid credentials" }
  /// ```
  Either<TodoFailure, (User, String)> _handleAuthResponse(
    http.Response response,
  ) {
    final body = jsonDecode(response.body) as Map<String, dynamic>;

    // -- Check for HTTP error status codes --
    if (response.statusCode == 401) {
      final message = body['error'] as String? ?? 'Invalid credentials';
      return Left(TodoFailure.server(
        message: message,
        statusCode: response.statusCode,
      ));
    }

    if (response.statusCode == 409) {
      // Email already registered
      final message = body['error'] as String? ?? 'Email already registered';
      return Left(TodoFailure.server(
        message: message,
        statusCode: response.statusCode,
      ));
    }

    if (response.statusCode >= 400) {
      final message = body['error'] as String? ?? 'Unknown error';
      return Left(TodoFailure.server(
        message: message,
        statusCode: response.statusCode,
      ));
    }

    // -- Parse success response --
    try {
      final user = User.fromJson(body['user'] as Map<String, dynamic>);
      final token = body['token'] as String;

      // Store for later use
      _token = token;
      _currentUser = user;

      return Right((user, token));
    } catch (e) {
      return Left(TodoFailure.unexpected(error: e));
    }
  }
}

// =============================================================================
// Design Notes
// =============================================================================
//
// Why Either instead of exceptions?
// - The Cubit doesn't need try/catch — it just folds the Either
// - Error types are explicit in the signature
// - Each error variant carries typed data (message, statusCode, etc.)
//
// Why store the token in the repository?
// - The TodoRepository needs it for Bearer auth
// - In production, you'd use flutter_secure_storage for persistence
// - The token is in-memory here for simplicity
//
// Alternative patterns:
// - Store token in a shared AuthState Cubit and pass it around
// - Use an Interceptor/Middleware pattern (like dio interceptors)
// - Use a TokenProvider abstraction for testing
//
// Cubit integration:
// ```dart
// class AuthCubit extends Cubit<AuthState> {
//   final AuthRepository _repo;
//
//   Future<void> login(String email, String password) async {
//     emit(const AuthState.loading());
//     final result = await _repo.login(email, password);
//     result.fold(
//       (failure) => emit(AuthState.error(failure)),
//       (data) => emit(AuthState.authenticated(user: data.$1, token: data.$2)),
//     );
//   }
// }
// ```
// =============================================================================
