// =============================================================================
// Todo Cubit
// =============================================================================
// Manages todo list and detail state. Calls use cases for business logic
// and emits state changes for the UI to react to.
// =============================================================================

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/todo_repository.dart';
import '../../../domain/usecases/create_todo_usecase.dart';
import '../../../domain/usecases/delete_todo_usecase.dart';
import '../../../domain/usecases/get_todos_usecase.dart';
import 'todo_state.dart';

// ---------------------------------------------------------------------------
// TodoCubit
// ---------------------------------------------------------------------------

/// Manages todo CRUD operations and state.
///
/// Depends on use cases for get/create/delete and the repository
/// directly for update (no dedicated use case for simplicity).
///
/// Registered as a **factory** in get_it:
/// ```dart
/// getIt.registerFactory(() => TodoCubit(
///   getTodosUseCase: getIt(),
///   createTodoUseCase: getIt(),
///   deleteTodoUseCase: getIt(),
///   todoRepository: getIt(),
/// ));
/// ```
class TodoCubit extends Cubit<TodoState> {
  final GetTodosUseCase _getTodosUseCase;
  final CreateTodoUseCase _createTodoUseCase;
  final DeleteTodoUseCase _deleteTodoUseCase;
  final TodoRepository _todoRepository;

  /// Creates a [TodoCubit] with all required dependencies injected.
  TodoCubit({
    required GetTodosUseCase getTodosUseCase,
    required CreateTodoUseCase createTodoUseCase,
    required DeleteTodoUseCase deleteTodoUseCase,
    required TodoRepository todoRepository,
  })  : _getTodosUseCase = getTodosUseCase,
        _createTodoUseCase = createTodoUseCase,
        _deleteTodoUseCase = deleteTodoUseCase,
        _todoRepository = todoRepository,
        super(const TodoState.initial());

  // ---------------------------------------------------------------------------
  // Load Todos
  // ---------------------------------------------------------------------------

  /// Fetches a paginated list of todos.
  ///
  /// Emits [TodoState.loading] then [TodoState.loaded] or [TodoState.error].
  Future<void> loadTodos({int page = 1, int pageSize = 10}) async {
    emit(const TodoState.loading());

    final result = await _getTodosUseCase(
      page: page,
      pageSize: pageSize,
    );

    result.fold(
      (failure) => emit(TodoState.error(failure.message)),
      (response) => emit(TodoState.loaded(
        todos: response.todos,
        total: response.total,
        page: response.page,
        pageSize: response.pageSize,
      )),
    );
  }

  // ---------------------------------------------------------------------------
  // Load Todo Detail
  // ---------------------------------------------------------------------------

  /// Fetches a single todo by [id] for the detail view.
  Future<void> loadTodoDetail(int id) async {
    emit(const TodoState.loading());

    final result = await _todoRepository.getTodoById(id);

    result.fold(
      (failure) => emit(TodoState.error(failure.message)),
      (todo) => emit(TodoState.detail(todo)),
    );
  }

  // ---------------------------------------------------------------------------
  // Create Todo
  // ---------------------------------------------------------------------------

  /// Creates a new todo and reloads the list on success.
  ///
  /// Returns true on success so the UI can navigate back.
  Future<bool> createTodo({
    required String title,
    required String description,
  }) async {
    emit(const TodoState.loading());

    final result = await _createTodoUseCase(
      title: title,
      description: description,
    );

    return result.fold(
      (failure) {
        emit(TodoState.error(failure.message));
        return false;
      },
      (todo) {
        // Reload the list to include the new todo
        loadTodos();
        return true;
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Update Todo
  // ---------------------------------------------------------------------------

  /// Updates an existing todo.
  ///
  /// Returns true on success so the UI can navigate back.
  Future<bool> updateTodo({
    required int id,
    String? title,
    String? description,
    bool? checked,
  }) async {
    emit(const TodoState.loading());

    final result = await _todoRepository.updateTodo(
      id: id,
      title: title,
      description: description,
      checked: checked,
    );

    return result.fold(
      (failure) {
        emit(TodoState.error(failure.message));
        return false;
      },
      (todo) {
        loadTodos();
        return true;
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Toggle Todo
  // ---------------------------------------------------------------------------

  /// Toggles the checked status of a todo.
  Future<void> toggleTodo(int id, bool currentValue) async {
    final result = await _todoRepository.updateTodo(
      id: id,
      checked: !currentValue,
    );

    result.fold(
      (failure) => emit(TodoState.error(failure.message)),
      (_) => loadTodos(), // Refresh list after toggle
    );
  }

  // ---------------------------------------------------------------------------
  // Delete Todo
  // ---------------------------------------------------------------------------

  /// Deletes a todo by [id] and reloads the list.
  Future<void> deleteTodo(int id) async {
    final result = await _deleteTodoUseCase(id);

    result.fold(
      (failure) => emit(TodoState.error(failure.message)),
      (_) => loadTodos(), // Refresh list after deletion
    );
  }

  // Alternative: optimistic updates for better UX
  // Future<void> toggleTodoOptimistic(int id, bool currentValue) async {
  //   // Immediately update UI
  //   final currentState = state;
  //   if (currentState is TodoLoaded) {
  //     final updatedTodos = currentState.todos.map((t) {
  //       if (t.id == id) return t.copyWith(checked: !currentValue);
  //       return t;
  //     }).toList();
  //     emit(currentState.copyWith(todos: updatedTodos));
  //   }
  //   // Then sync with server (rollback on failure)
  //   final result = await _todoRepository.updateTodo(id: id, checked: !currentValue);
  //   result.fold(
  //     (failure) { emit(currentState); /* rollback */ },
  //     (_) { /* already updated */ },
  //   );
  // }
}
