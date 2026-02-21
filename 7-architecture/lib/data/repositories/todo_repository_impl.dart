// =============================================================================
// Todo Repository Implementation (Data Layer)
// =============================================================================
// Concrete implementation of TodoRepository. Follows the same pattern
// as AuthRepositoryImpl: delegate to datasource, convert models to
// entities, catch exceptions.
// =============================================================================

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/todo_entity.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_remote_datasource.dart';
import '../models/todo_model.dart';

// ---------------------------------------------------------------------------
// TodoRepositoryImpl
// ---------------------------------------------------------------------------

/// Implements [TodoRepository] by delegating to [TodoRemoteDataSource].
///
/// Handles the data-to-domain boundary conversion and error mapping.
class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource _dataSource;

  /// Creates a [TodoRepositoryImpl] with the injected data source.
  const TodoRepositoryImpl(this._dataSource);

  // ---------------------------------------------------------------------------
  // Get Todos (paginated)
  // ---------------------------------------------------------------------------

  @override
  Future<Either<Failure, TodosResponse>> getTodos({
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      final data = await _dataSource.getTodos(
        page: page,
        pageSize: pageSize,
      );

      // Parse the list of todos from the response
      final todosJson = data['todos'] as List<dynamic>? ?? [];
      final todos = todosJson
          .map((json) => TodoModel.fromJson(json as Map<String, dynamic>))
          .map((model) => model.toEntity())
          .toList();

      return Right(TodosResponse(
        todos: todos,
        total: data['total'] as int? ?? 0,
        page: data['page'] as int? ?? page,
        pageSize: data['page_size'] as int? ?? pageSize,
      ));
    } on DioException catch (e) {
      return Left(_mapDioException(e));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Get Todo by ID
  // ---------------------------------------------------------------------------

  @override
  Future<Either<Failure, TodoEntity>> getTodoById(int id) async {
    try {
      final model = await _dataSource.getTodoById(id);
      return Right(model.toEntity());
    } on DioException catch (e) {
      return Left(_mapDioException(e));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Create Todo
  // ---------------------------------------------------------------------------

  @override
  Future<Either<Failure, TodoEntity>> createTodo({
    required String title,
    required String description,
  }) async {
    try {
      final model = await _dataSource.createTodo(
        title: title,
        description: description,
      );
      return Right(model.toEntity());
    } on DioException catch (e) {
      return Left(_mapDioException(e));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Update Todo
  // ---------------------------------------------------------------------------

  @override
  Future<Either<Failure, TodoEntity>> updateTodo({
    required int id,
    String? title,
    String? description,
    bool? checked,
  }) async {
    try {
      final model = await _dataSource.updateTodo(
        id: id,
        title: title,
        description: description,
        checked: checked,
      );
      return Right(model.toEntity());
    } on DioException catch (e) {
      return Left(_mapDioException(e));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Delete Todo
  // ---------------------------------------------------------------------------

  @override
  Future<Either<Failure, void>> deleteTodo(int id) async {
    try {
      await _dataSource.deleteTodo(id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(_mapDioException(e));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Maps a [DioException] to the appropriate [Failure] type.
  Failure _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return Failure.network(
          message: e.message ?? 'Network error occurred',
        );
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode ?? 0;
        if (statusCode == 401) {
          return Failure.unauthorized(
            message: e.message ?? 'Unauthorized',
          );
        }
        return Failure.server(
          message: e.message ?? 'Server error occurred',
        );
      default:
        return Failure.unknown(
          message: e.message ?? 'Unknown error occurred',
        );
    }
  }
}
