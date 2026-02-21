// =============================================================================
// Get Todos Use Case
// =============================================================================
// Fetches a paginated list of todos. The use case layer sits between
// the presentation (cubits) and the data (repositories), enforcing
// the dependency rule.
// =============================================================================

import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../repositories/todo_repository.dart';

// ---------------------------------------------------------------------------
// GetTodosUseCase
// ---------------------------------------------------------------------------

/// Fetches a paginated list of todos from the repository.
///
/// This use case is intentionally thin - it just delegates to the
/// repository. In a real app you might add caching logic, merge
/// data from multiple sources, or apply business rules here.
class GetTodosUseCase {
  final TodoRepository _repository;

  /// Creates a [GetTodosUseCase] with the injected [TodoRepository].
  const GetTodosUseCase(this._repository);

  /// Fetches todos for the given [page] and [pageSize].
  ///
  /// Returns [Right(TodosResponse)] on success, [Left(Failure)] on error.
  Future<Either<Failure, TodosResponse>> call({
    int page = 1,
    int pageSize = 10,
  }) {
    return _repository.getTodos(page: page, pageSize: pageSize);
  }

  // Alternative: add offline-first logic
  // Future<Either<Failure, TodosResponse>> call({...}) async {
  //   final cached = await _localRepo.getCachedTodos(page);
  //   if (cached != null) return Right(cached);
  //   return _repository.getTodos(page: page, pageSize: pageSize);
  // }
}
