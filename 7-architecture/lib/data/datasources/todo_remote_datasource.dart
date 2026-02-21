// =============================================================================
// Todo Remote Data Source
// =============================================================================
// Handles raw HTTP communication with the Go backend. This is the lowest
// level of the data layer - it speaks Dio and JSON, nothing else.
//
// The repository layer wraps this datasource, catches exceptions, and
// returns Either<Failure, T> for the domain layer.
// =============================================================================

import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../../core/network/dio_client.dart';
import '../models/todo_model.dart';
import '../models/user_model.dart';

// ---------------------------------------------------------------------------
// TodoRemoteDataSource
// ---------------------------------------------------------------------------

/// Low-level API client for all backend endpoints.
///
/// Every method here throws [DioException] on failure. The repository
/// layer catches these and converts them to [Failure] types.
///
/// Registered as a **lazy singleton** in get_it because it holds no
/// mutable state (the Dio instance is shared via DioClient).
class TodoRemoteDataSource {
  final DioClient _dioClient;

  /// Creates a [TodoRemoteDataSource] with the injected [DioClient].
  const TodoRemoteDataSource(this._dioClient);

  /// Quick accessor for the underlying Dio instance.
  Dio get _dio => _dioClient.dio;

  // ---------------------------------------------------------------------------
  // Auth endpoints
  // ---------------------------------------------------------------------------

  /// POST /login - Authenticates a user.
  ///
  /// Throws [DioException] on network/server errors.
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      ApiConstants.login,
      data: {'email': email, 'password': password},
    );
    return UserModel.fromAuthResponse(response.data as Map<String, dynamic>);
  }

  /// POST /register - Creates a new user account.
  ///
  /// Throws [DioException] on network/server errors.
  Future<UserModel> register({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      ApiConstants.register,
      data: {'email': email, 'password': password},
    );
    return UserModel.fromAuthResponse(response.data as Map<String, dynamic>);
  }

  // ---------------------------------------------------------------------------
  // Todo endpoints
  // ---------------------------------------------------------------------------

  /// GET /todos?page=X&page_size=Y - Fetches paginated todos.
  ///
  /// Returns a raw map containing 'todos', 'total', 'page', 'page_size'.
  Future<Map<String, dynamic>> getTodos({
    int page = 1,
    int pageSize = 10,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.get(
      ApiConstants.todos,
      queryParameters: {
        'page': page,
        'page_size': pageSize,
      },
      // CancelToken allows the caller to abort long-running requests
      cancelToken: cancelToken,
    );
    return response.data as Map<String, dynamic>;
  }

  /// GET /todos/{id} - Fetches a single todo with full details.
  Future<TodoModel> getTodoById(int id) async {
    final response = await _dio.get(ApiConstants.todoById(id));
    return TodoModel.fromJson(response.data as Map<String, dynamic>);
  }

  /// POST /todos - Creates a new todo.
  Future<TodoModel> createTodo({
    required String title,
    required String description,
  }) async {
    final response = await _dio.post(
      ApiConstants.todos,
      data: {'title': title, 'description': description},
    );
    return TodoModel.fromJson(response.data as Map<String, dynamic>);
  }

  /// PATCH /todos/{id} - Updates an existing todo.
  ///
  /// Only includes non-null fields in the request body.
  Future<TodoModel> updateTodo({
    required int id,
    String? title,
    String? description,
    bool? checked,
  }) async {
    // Build the request body with only the fields that changed
    final data = <String, dynamic>{};
    if (title != null) data['title'] = title;
    if (description != null) data['description'] = description;
    if (checked != null) data['checked'] = checked;

    final response = await _dio.patch(
      ApiConstants.todoById(id),
      data: data,
    );
    return TodoModel.fromJson(response.data as Map<String, dynamic>);
  }

  /// DELETE /todos/{id} - Deletes a todo.
  Future<void> deleteTodo(int id) async {
    await _dio.delete(ApiConstants.todoById(id));
  }

  // Alternative: support file upload with FormData
  // Future<TodoModel> uploadImage(int id, File file) async {
  //   final formData = FormData.fromMap({
  //     'image': await MultipartFile.fromFile(file.path),
  //   });
  //   final response = await _dio.post(
  //     '${ApiConstants.todoById(id)}/image',
  //     data: formData,
  //   );
  //   return TodoModel.fromJson(response.data);
  // }
}
