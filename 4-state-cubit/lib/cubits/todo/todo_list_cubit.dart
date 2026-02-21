// =============================================================================
// Todo List Cubit — Paginated List Management
// =============================================================================
// Concepts demonstrated:
// - Cubit for managing a paginated list
// - Calling the repository and folding Either → state
// - Refresh vs initial load vs pagination
// - How the Cubit coordinates with TodoDetailCubit
//
// The TodoListCubit is responsible for:
// 1. Loading the first page of todos
// 2. Refreshing the list after create/update/delete
// 3. Managing pagination (load more)
//
// It does NOT handle individual todo details — that's TodoDetailCubit's job.
// =============================================================================

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/todo_repository.dart';
import 'todo_list_state.dart';

// =============================================================================
// Todo List Cubit
// =============================================================================

/// Manages the paginated todo list state.
///
/// Provides methods for loading, refreshing, and paginating todos.
/// Each method emits a Loading state, calls the repository, and
/// emits either Loaded or Error based on the result.
///
/// Usage:
/// ```dart
/// // In widget tree
/// BlocProvider(
///   create: (context) => TodoListCubit(
///     todoRepository: context.read<TodoRepository>(),
///   )..loadTodos(), // Load immediately on creation
///   child: TodoListScreen(),
/// )
///
/// // In widget
/// context.read<TodoListCubit>().loadTodos();     // initial load
/// context.read<TodoListCubit>().refreshTodos();   // pull-to-refresh
/// context.read<TodoListCubit>().loadPage(2);      // pagination
/// ```
class TodoListCubit extends Cubit<TodoListState> {
  /// The todo repository for fetching data.
  final TodoRepository _todoRepo;

  /// Creates a [TodoListCubit] with initial state.
  TodoListCubit({required TodoRepository todoRepository})
      : _todoRepo = todoRepository,
        super(const TodoListState.initial());

  // ---------------------------------------------------------------------------
  // LOAD TODOS
  // ---------------------------------------------------------------------------

  /// Loads the first page of todos.
  ///
  /// State transitions: current → Loading → Loaded/Error
  ///
  /// Called when:
  /// - The screen is first displayed (via `..loadTodos()` on creation)
  /// - The user pulls to refresh
  /// - After creating, updating, or deleting a todo
  Future<void> loadTodos({int page = 1, int pageSize = 10}) async {
    emit(const TodoListState.loading());

    final result = await _todoRepo.getTodos(page: page, pageSize: pageSize);

    // Fold the Either: Left → error, Right → loaded with todos + pagination
    result.fold(
      (failure) => emit(TodoListState.error(failure)),
      (data) => emit(TodoListState.loaded(
        todos: data.$1,
        total: data.$2,
        page: page,
        pageSize: pageSize,
      )),
    );
  }

  // ---------------------------------------------------------------------------
  // REFRESH
  // ---------------------------------------------------------------------------

  /// Refreshes the todo list by reloading the first page.
  ///
  /// This is called after any mutation (create, update, delete) to
  /// keep the list in sync with the backend.
  ///
  /// Alternative: optimistically update the local list without re-fetching.
  /// We re-fetch for simplicity and to ensure consistency.
  Future<void> refreshTodos() async {
    // Determine the current page size (use previous if available)
    final currentPageSize = state.maybeWhen(
      loaded: (todos, total, pageArg, pageSize) => pageSize,
      orElse: () => 10,
    );

    await loadTodos(pageSize: currentPageSize);
  }

  // ---------------------------------------------------------------------------
  // PAGINATION
  // ---------------------------------------------------------------------------

  /// Loads a specific page of todos.
  ///
  /// Called when the user navigates to the next/previous page.
  Future<void> loadPage(int page) async {
    final currentPageSize = state.maybeWhen(
      loaded: (todos, total, pageArg, pageSize) => pageSize,
      orElse: () => 10,
    );

    await loadTodos(page: page, pageSize: currentPageSize);
  }

  // ---------------------------------------------------------------------------
  // DELETE
  // ---------------------------------------------------------------------------

  /// Deletes a todo and refreshes the list.
  ///
  /// This is a convenience method that combines delete + refresh.
  /// The Cubit handles both operations, so the UI just calls one method.
  Future<void> deleteTodo(int id) async {
    emit(const TodoListState.loading());

    final result = await _todoRepo.deleteTodo(id);

    // If delete succeeded, refresh the list to reflect the change
    // If delete failed, emit the error
    await result.fold(
      (failure) async => emit(TodoListState.error(failure)),
      (_) async => await refreshTodos(),
    );
  }
}

// =============================================================================
// Design Notes
// =============================================================================
//
// Why separate TodoListCubit and TodoDetailCubit?
// - Single Responsibility: list manages list state, detail manages detail state
// - The list screen only needs TodoSummary (lightweight)
// - The detail screen needs TodoDetail (full data)
// - They can emit states independently
//
// Refreshing after mutations:
// We re-fetch from the server after create/update/delete. Alternatives:
// 1. Optimistic updates: update local state, then sync with server
// 2. Event-based: use a Stream/EventBus to notify the list cubit
// 3. Cache invalidation: mark the cache as stale
// We use re-fetch for simplicity — the 2-second backend delay makes it visible.
//
// Testing:
// ```dart
// blocTest<TodoListCubit, TodoListState>(
//   'emits [loading, loaded] when loadTodos succeeds',
//   build: () {
//     when(() => mockRepo.getTodos(page: 1, pageSize: 10))
//         .thenAnswer((_) async => Right(([todo1, todo2], 2)));
//     return TodoListCubit(todoRepository: mockRepo);
//   },
//   act: (cubit) => cubit.loadTodos(),
//   expect: () => [
//     const TodoListState.loading(),
//     isA<TodoListLoaded>(),
//   ],
// );
// ```
// =============================================================================
