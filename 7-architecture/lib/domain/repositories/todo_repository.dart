// =============================================================================
// Todo Repository Interface (Domain Layer)
// =============================================================================
// Abstract contract for todo CRUD operations. The domain layer owns this
// interface; the data layer implements it.
// =============================================================================

import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/todo_entity.dart';

// ---------------------------------------------------------------------------
// TodosResponse - simple wrapper for paginated results
// ---------------------------------------------------------------------------

/// Holds a page of todos along with pagination metadata.
class TodosResponse {
  /// The list of todos for the current page.
  final List<TodoEntity> todos;

  /// Total number of todos across all pages.
  final int total;

  /// Current page number (1-indexed).
  final int page;

  /// Number of items per page.
  final int pageSize;

  /// Creates a [TodosResponse].
  const TodosResponse({
    required this.todos,
    required this.total,
    required this.page,
    required this.pageSize,
  });
}

// ---------------------------------------------------------------------------
// TodoRepository
// ---------------------------------------------------------------------------

/// Defines all todo-related data operations.
///
/// Each method returns [Either<Failure, T>] for functional error handling.
abstract class TodoRepository {
  /// Fetches a paginated list of todos.
  Future<Either<Failure, TodosResponse>> getTodos({
    int page = 1,
    int pageSize = 10,
  });

  /// Fetches a single todo by [id] with full details.
  Future<Either<Failure, TodoEntity>> getTodoById(int id);

  /// Creates a new todo with [title] and [description].
  Future<Either<Failure, TodoEntity>> createTodo({
    required String title,
    required String description,
  });

  /// Updates an existing todo. Only non-null fields are sent.
  Future<Either<Failure, TodoEntity>> updateTodo({
    required int id,
    String? title,
    String? description,
    bool? checked,
  });

  /// Deletes a todo by [id].
  Future<Either<Failure, void>> deleteTodo(int id);

  // Alternative: add search/filter
  // Future<Either<Failure, TodosResponse>> searchTodos(String query);
}
