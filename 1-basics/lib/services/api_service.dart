// =============================================================================
// API Service
// =============================================================================
// Concepts demonstrated:
// - HTTP methods: GET, POST, PATCH, DELETE via the `http` package
// - jsonEncode / jsonDecode for JSON serialization
// - async / await — Dart's syntax for asynchronous programming
// - Future<T> — a value that will be available later
// - try / catch — error handling for network requests
// - Bearer token authentication via HTTP headers
// - Throwing exceptions to propagate errors to the caller
// - String interpolation in URLs
// =============================================================================

import 'dart:convert'; // jsonEncode, jsonDecode

import 'package:http/http.dart' as http; // HTTP client

import '../config/api_constants.dart';
import '../models/todo_detail.dart';
import '../models/todo_list_response.dart';

/// Handles all HTTP communication with the Go backend.
///
/// This is a *stateless* service — it has no fields that change over time.
/// The auth token is passed as a parameter to each method, keeping the
/// service independent of how authentication state is managed.
///
/// Every method follows the same pattern:
/// 1. Build the request (URL, headers, body)
/// 2. Send the request and await the response
/// 3. Check the status code
/// 4. Decode the response body (JSON → Map → Model)
/// 5. Return the result or throw an exception
class ApiService {
  // ---------------------------------------------------------------------------
  // Auth endpoints
  // ---------------------------------------------------------------------------

  /// Registers a new user account.
  ///
  /// Sends a POST request with email and password.
  /// Returns a [Map] containing `user` and `token` keys.
  ///
  /// Throws an [Exception] if the server returns an error (e.g., 409 Conflict
  /// when the email is already registered).
  Future<Map<String, dynamic>> register(String email, String password) async {
    // http.post sends an HTTP POST request.
    // The `body` parameter is a String — we use jsonEncode to convert
    // a Dart Map to a JSON string.
    final response = await http.post(
      Uri.parse(ApiConstants.registerEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    // Decode the JSON string response body into a Dart Map.
    final data = jsonDecode(response.body) as Map<String, dynamic>;

    // HTTP 201 Created means success for registration.
    if (response.statusCode == 201) {
      return data;
    }

    // If not successful, throw an exception with the server's error message.
    // The `throw` keyword stops execution and propagates the error to
    // the nearest try/catch block (usually in the provider).
    throw Exception(data['error'] ?? 'Registration failed');
  }

  /// Logs in with existing credentials.
  ///
  /// Returns a [Map] with `user` and `token` keys on success.
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(ApiConstants.loginEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return data;
    }

    throw Exception(data['error'] ?? 'Login failed');
  }

  // ---------------------------------------------------------------------------
  // Todo endpoints
  // ---------------------------------------------------------------------------

  /// Fetches a paginated list of todos.
  ///
  /// [token] — the JWT bearer token for authentication.
  /// [page] — the page number (1-based).
  /// [pageSize] — how many items per page.
  ///
  /// Returns a [TodoListResponse] containing the list and pagination info.
  Future<TodoListResponse> fetchTodos(
    String token, {
    int page = 1,
    int pageSize = ApiConstants.defaultPageSize,
  }) async {
    // Query parameters are appended to the URL after a `?`.
    // Uri.parse handles the URL construction.
    final url = '${ApiConstants.todosEndpoint}?page=$page&page_size=$pageSize';

    final response = await http.get(
      Uri.parse(url),
      // The Authorization header sends the JWT token.
      // Format: "Bearer <token>" — this is the standard for JWT auth.
      headers: _authHeaders(token),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return TodoListResponse.fromJson(data);
    }

    throw Exception('Failed to fetch todos');
  }

  /// Fetches the full detail of a single todo by its [id].
  Future<TodoDetail> fetchTodoDetail(String token, int id) async {
    final response = await http.get(
      Uri.parse(ApiConstants.todoByIdEndpoint(id)),
      headers: _authHeaders(token),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return TodoDetail.fromJson(data);
    }

    throw Exception('Failed to fetch todo detail');
  }

  /// Creates a new todo.
  ///
  /// [title] is required; [description] and [iconUrl] are optional.
  /// Returns the created [TodoDetail] from the server.
  Future<TodoDetail> createTodo(
    String token, {
    required String title,
    String? description,
    String? iconUrl,
  }) async {
    final body = <String, dynamic>{
      'title': title,
      if (description != null && description.isNotEmpty)
        'description': description,
      if (iconUrl != null && iconUrl.isNotEmpty) 'icon_url': iconUrl,
    };

    final response = await http.post(
      Uri.parse(ApiConstants.todosEndpoint),
      headers: {
        'Content-Type': 'application/json',
        ..._authHeaders(token), // Spread operator merges maps
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return TodoDetail.fromJson(data);
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    throw Exception(data['error'] ?? 'Failed to create todo');
  }

  /// Updates an existing todo.
  ///
  /// Uses HTTP PATCH — only the provided fields are updated.
  /// All parameters except [token] and [id] are optional.
  Future<TodoDetail> updateTodo(
    String token,
    int id, {
    String? title,
    String? description,
    bool? checked,
    String? iconUrl,
  }) async {
    // Build the body with only the fields that were provided.
    // The `if` inside a map literal is a *collection if* — a Dart feature
    // that conditionally includes entries.
    final body = <String, dynamic>{
      // Null-aware element syntax: `'key': ?value` only includes the entry
      // if `value` is non-null. Equivalent to `if (value != null) 'key': value`.
      'title': ?title,
      'description': ?description,
      'checked': ?checked,
      'icon_url': ?iconUrl,
    };

    // http.patch sends an HTTP PATCH request.
    final response = await http.patch(
      Uri.parse(ApiConstants.todoByIdEndpoint(id)),
      headers: {
        'Content-Type': 'application/json',
        ..._authHeaders(token),
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return TodoDetail.fromJson(data);
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    throw Exception(data['error'] ?? 'Failed to update todo');
  }

  /// Deletes a todo by its [id].
  ///
  /// Uses HTTP DELETE. No response body is needed on success.
  Future<void> deleteTodo(String token, int id) async {
    final response = await http.delete(
      Uri.parse(ApiConstants.todoByIdEndpoint(id)),
      headers: _authHeaders(token),
    );

    if (response.statusCode != 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception(data['error'] ?? 'Failed to delete todo');
    }
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Builds the authorization headers for authenticated requests.
  ///
  /// Returns a map with the `Authorization` header set to `Bearer <token>`.
  /// This is a private method (underscore prefix) — only usable within
  /// this class.
  Map<String, String> _authHeaders(String token) {
    return {
      'Authorization': 'Bearer $token',
    };
  }
}
