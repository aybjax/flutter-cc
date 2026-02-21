// =============================================================================
// Todo Repository — CRUD with dartz Either
// =============================================================================
// Concepts demonstrated:
// - HTTP CRUD operations against the Go backend
// - Bearer token authentication via AuthRepository
// - dartz Either<TodoFailure, T> for every operation
// - Pagination support (page, page_size)
// - PATCH semantics — only send fields that changed
//
// Architecture flow:
//   TodoListCubit → TodoRepository → HTTP → Go Backend
//   TodoDetailCubit → TodoRepository → HTTP → Go Backend
//
// The repository is a plain Dart class — it doesn't extend Cubit or
// ChangeNotifier. It's just a service that makes HTTP calls and returns
// typed results. The Cubits decide what state to emit.
// =============================================================================

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';
import 'auth_repository.dart';

// =============================================================================
// Todo Repository
// =============================================================================

/// Handles CRUD operations for todos with the Go backend.
///
/// Every method returns [Either<TodoFailure, T>] — the caller must
/// handle both failure (Left) and success (Right) cases.
///
/// Requires an [AuthRepository] for the Bearer token. If the token
/// is missing, operations return [TodoFailure.unauthorized].
class TodoRepository {
  /// Base URL for the Go backend.
  final String _baseUrl;

  /// The HTTP client. Injectable for testing.
  final http.Client _client;

  /// The auth repository, used to get the current Bearer token.
  final AuthRepository _authRepo;

  /// Creates a [TodoRepository] with the required [AuthRepository].
  TodoRepository({
    required AuthRepository authRepo,
    String baseUrl = 'http://localhost:8080',
    http.Client? client,
  })  : _authRepo = authRepo,
        _baseUrl = baseUrl,
        _client = client ?? http.Client();

  // ---------------------------------------------------------------------------
  // LIST (with pagination)
  // ---------------------------------------------------------------------------

  /// Fetches a paginated list of todos.
  ///
  /// Returns [Either]:
  /// - Left([TodoFailure]) on error
  /// - Right(([List<TodoSummary>], total count)) on success
  ///
  /// The backend returns:
  /// ```json
  /// {
  ///   "todos": [{ "id": 1, "title": "...", "checked": false }],
  ///   "total": 25,
  ///   "page": 1,
  ///   "page_size": 10
  /// }
  /// ```
  Future<Either<TodoFailure, (List<TodoSummary>, int)>> getTodos({
    int page = 1,
    int pageSize = 10,
  }) async {
    final headers = _authHeaders();
    if (headers == null) {
      return const Left(TodoFailure.unauthorized());
    }

    try {
      final uri = Uri.parse('$_baseUrl/todos').replace(
        queryParameters: {
          'page': page.toString(),
          'page_size': pageSize.toString(),
        },
      );

      final response = await _client.get(uri, headers: headers);

      // Check for auth errors first
      if (response.statusCode == 401) {
        return const Left(TodoFailure.unauthorized());
      }

      if (response.statusCode >= 400) {
        return Left(_serverError(response));
      }

      // Parse the paginated response
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final todosJson = body['todos'] as List<dynamic>? ?? [];
      final total = body['total'] as int? ?? 0;

      final todos = todosJson
          .map((json) => TodoSummary.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right((todos, total));
    } catch (e) {
      return Left(TodoFailure.network(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // GET SINGLE
  // ---------------------------------------------------------------------------

  /// Fetches a single todo by ID.
  ///
  /// Returns [Either]:
  /// - Left([TodoFailure.notFound]) if the todo doesn't exist
  /// - Left([TodoFailure]) for other errors
  /// - Right([TodoDetail]) on success
  Future<Either<TodoFailure, TodoDetail>> getTodo(int id) async {
    final headers = _authHeaders();
    if (headers == null) {
      return const Left(TodoFailure.unauthorized());
    }

    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/todos/$id'),
        headers: headers,
      );

      if (response.statusCode == 401) {
        return const Left(TodoFailure.unauthorized());
      }

      if (response.statusCode == 404) {
        return Left(TodoFailure.notFound(id: id));
      }

      if (response.statusCode >= 400) {
        return Left(_serverError(response));
      }

      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return Right(TodoDetail.fromJson(body));
    } catch (e) {
      return Left(TodoFailure.network(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // CREATE
  // ---------------------------------------------------------------------------

  /// Creates a new todo with a title and optional description.
  ///
  /// Returns [Either]:
  /// - Left([TodoFailure.validation]) if title is empty
  /// - Left([TodoFailure]) for other errors
  /// - Right([TodoDetail]) with the created todo
  ///
  /// Example:
  /// ```dart
  /// final result = await todoRepo.createTodo(
  ///   title: 'Buy groceries',
  ///   description: 'Milk, eggs, bread',
  /// );
  /// ```
  Future<Either<TodoFailure, TodoDetail>> createTodo({
    required String title,
    String description = '',
  }) async {
    // Client-side validation — fail fast before making a network call
    if (title.trim().isEmpty) {
      return const Left(
        TodoFailure.validation(field: 'title', message: 'Title is required'),
      );
    }

    final headers = _authHeaders();
    if (headers == null) {
      return const Left(TodoFailure.unauthorized());
    }

    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/todos'),
        headers: {...headers, 'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': title.trim(),
          'description': description.trim(),
        }),
      );

      if (response.statusCode == 401) {
        return const Left(TodoFailure.unauthorized());
      }

      if (response.statusCode >= 400) {
        return Left(_serverError(response));
      }

      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return Right(TodoDetail.fromJson(body));
    } catch (e) {
      return Left(TodoFailure.network(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // UPDATE (PATCH)
  // ---------------------------------------------------------------------------

  /// Updates an existing todo with PATCH semantics.
  ///
  /// Only the provided (non-null) fields are sent to the backend.
  /// This matches the Go backend's PATCH handler which uses pointer
  /// fields (*string, *bool) to distinguish "not sent" from "set to empty".
  ///
  /// Returns [Either]:
  /// - Left([TodoFailure.notFound]) if the todo doesn't exist
  /// - Left([TodoFailure]) for other errors
  /// - Right([TodoDetail]) with the updated todo
  Future<Either<TodoFailure, TodoDetail>> updateTodo({
    required int id,
    String? title,
    String? description,
    bool? checked,
  }) async {
    final headers = _authHeaders();
    if (headers == null) {
      return const Left(TodoFailure.unauthorized());
    }

    // Build the PATCH body — only include fields that are provided
    final patchBody = <String, dynamic>{};
    if (title != null) patchBody['title'] = title.trim();
    if (description != null) patchBody['description'] = description.trim();
    if (checked != null) patchBody['checked'] = checked;

    try {
      final response = await _client.patch(
        Uri.parse('$_baseUrl/todos/$id'),
        headers: {...headers, 'Content-Type': 'application/json'},
        body: jsonEncode(patchBody),
      );

      if (response.statusCode == 401) {
        return const Left(TodoFailure.unauthorized());
      }

      if (response.statusCode == 404) {
        return Left(TodoFailure.notFound(id: id));
      }

      if (response.statusCode >= 400) {
        return Left(_serverError(response));
      }

      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return Right(TodoDetail.fromJson(body));
    } catch (e) {
      return Left(TodoFailure.network(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // DELETE
  // ---------------------------------------------------------------------------

  /// Deletes a todo by ID.
  ///
  /// Returns [Either]:
  /// - Left([TodoFailure.notFound]) if the todo doesn't exist
  /// - Left([TodoFailure]) for other errors
  /// - Right([Unit]) on success — Unit is dartz's void equivalent
  ///
  /// Why [Unit] instead of void?
  /// - void can't be used as a type parameter (`Either<Failure, void>` is invalid)
  /// - Unit is a real type with a single value: unit
  /// - It means "operation succeeded, no meaningful return value"
  Future<Either<TodoFailure, Unit>> deleteTodo(int id) async {
    final headers = _authHeaders();
    if (headers == null) {
      return const Left(TodoFailure.unauthorized());
    }

    try {
      final response = await _client.delete(
        Uri.parse('$_baseUrl/todos/$id'),
        headers: headers,
      );

      if (response.statusCode == 401) {
        return const Left(TodoFailure.unauthorized());
      }

      if (response.statusCode == 404) {
        return Left(TodoFailure.notFound(id: id));
      }

      if (response.statusCode >= 400) {
        return Left(_serverError(response));
      }

      return const Right(unit);
    } catch (e) {
      return Left(TodoFailure.network(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Private Helpers
  // ---------------------------------------------------------------------------

  /// Builds auth headers with the Bearer token, or null if not authenticated.
  Map<String, String>? _authHeaders() {
    final token = _authRepo.token;
    if (token == null) return null;
    return {'Authorization': 'Bearer $token'};
  }

  /// Parses a server error response into a [TodoFailure.server].
  TodoFailure _serverError(http.Response response) {
    try {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final message = body['error'] as String? ?? 'Unknown server error';
      return TodoFailure.server(
        message: message,
        statusCode: response.statusCode,
      );
    } catch (_) {
      return TodoFailure.server(
        message: 'Server error',
        statusCode: response.statusCode,
      );
    }
  }
}

// =============================================================================
// Design Notes
// =============================================================================
//
// Repository vs Cubit responsibilities:
// - Repository: makes HTTP calls, parses JSON, returns Either
// - Cubit: calls repository, manages UI state (loading → loaded/error)
//
// This separation means:
// 1. Repository is testable without Flutter (pure Dart)
// 2. Cubit is testable without HTTP (mock the repository)
// 3. UI is testable without either (BlocBuilder just renders state)
//
// PATCH semantics:
// The Go backend uses pointer fields (*string, *bool) for PATCH.
// - If a field is null in the request, it's not updated
// - If a field is present, it's updated to the new value
// This is why our updateTodo() accepts nullable parameters and only
// includes non-null fields in the request body.
//
// Error handling flow:
// 1. Repository catches all exceptions → returns Left(TodoFailure)
// 2. Cubit folds the Either → emits appropriate state
// 3. UI (BlocBuilder) renders based on state variant
//
// Alternative: use dio instead of http for interceptors, retry logic, etc.
// We use http here for simplicity and fewer dependencies.
// =============================================================================
