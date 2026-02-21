// =============================================================================
// Delete Todo Use Case
// =============================================================================
// Encapsulates the "delete a todo" business rule.
// =============================================================================

import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../repositories/todo_repository.dart';

// ---------------------------------------------------------------------------
// DeleteTodoUseCase
// ---------------------------------------------------------------------------

/// Deletes a todo by its ID.
///
/// This is a simple pass-through use case. In a more complex app,
/// you might check permissions or cascade-delete related data here.
class DeleteTodoUseCase {
  final TodoRepository _repository;

  /// Creates a [DeleteTodoUseCase] with the injected [TodoRepository].
  const DeleteTodoUseCase(this._repository);

  /// Deletes the todo with the given [id].
  ///
  /// Returns [Right(void)] on success, [Left(Failure)] on error.
  Future<Either<Failure, void>> call(int id) {
    return _repository.deleteTodo(id);
  }

  // Alternative: soft-delete pattern
  // Future<Either<Failure, void>> call(int id) {
  //   return _repository.updateTodo(id: id, deletedAt: DateTime.now());
  // }
}
