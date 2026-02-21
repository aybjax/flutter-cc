// =============================================================================
// Create Todo Use Case
// =============================================================================
// Encapsulates the "create a new todo" business rule.
// =============================================================================

import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/todo_entity.dart';
import '../repositories/todo_repository.dart';

// ---------------------------------------------------------------------------
// CreateTodoUseCase
// ---------------------------------------------------------------------------

/// Creates a new todo item.
///
/// Validates that the title is not empty before delegating to the
/// repository. This is an example of business logic living in
/// the use case layer rather than the UI.
class CreateTodoUseCase {
  final TodoRepository _repository;

  /// Creates a [CreateTodoUseCase] with the injected [TodoRepository].
  const CreateTodoUseCase(this._repository);

  /// Creates a todo with the given [title] and [description].
  ///
  /// Returns [Left(Failure)] if title is empty (client-side validation).
  Future<Either<Failure, TodoEntity>> call({
    required String title,
    required String description,
  }) {
    // Business rule: title must not be empty
    if (title.trim().isEmpty) {
      return Future.value(
        const Left(Failure.unknown(message: 'Title cannot be empty')),
      );
    }

    return _repository.createTodo(title: title, description: description);
  }
}
