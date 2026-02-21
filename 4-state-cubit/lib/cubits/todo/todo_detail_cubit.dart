// =============================================================================
// Todo Detail Cubit — Single Todo CRUD
// =============================================================================
// Concepts demonstrated:
// - Cubit for managing a single item's lifecycle (load, create, update)
// - The "Saved" state pattern for triggering navigation
// - How create vs edit flows differ in the same Cubit
// - Coordinating with TodoListCubit (via UI, not direct coupling)
//
// This Cubit handles three flows:
// 1. LOAD: fetch an existing todo for viewing/editing
// 2. CREATE: submit a new todo
// 3. UPDATE: modify an existing todo (title, description, checked)
//
// It does NOT directly notify TodoListCubit — the UI does that via
// BlocListener when it sees the Saved state.
// =============================================================================

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/todo_repository.dart';
import 'todo_detail_state.dart';

// =============================================================================
// Todo Detail Cubit
// =============================================================================

/// Manages the state of a single todo (load, create, update).
///
/// Usage for loading an existing todo:
/// ```dart
/// BlocProvider(
///   create: (context) => TodoDetailCubit(
///     todoRepository: context.read<TodoRepository>(),
///   )..loadTodo(42), // Load todo #42
///   child: TodoDetailScreen(),
/// )
/// ```
///
/// Usage for creating a new todo:
/// ```dart
/// BlocProvider(
///   create: (context) => TodoDetailCubit(
///     todoRepository: context.read<TodoRepository>(),
///   ), // No loadTodo — stays in Initial state
///   child: TodoFormScreen(),
/// )
/// ```
class TodoDetailCubit extends Cubit<TodoDetailState> {
  /// The todo repository for API calls.
  final TodoRepository _todoRepo;

  /// Creates a [TodoDetailCubit] with initial state.
  TodoDetailCubit({required TodoRepository todoRepository})
      : _todoRepo = todoRepository,
        super(const TodoDetailState.initial());

  // ---------------------------------------------------------------------------
  // LOAD
  // ---------------------------------------------------------------------------

  /// Loads a single todo by ID.
  ///
  /// State transitions: Initial → Loading → Loaded/Error
  ///
  /// Called when navigating to the detail screen for an existing todo.
  Future<void> loadTodo(int id) async {
    emit(const TodoDetailState.loading());

    final result = await _todoRepo.getTodo(id);

    result.fold(
      (failure) => emit(TodoDetailState.error(failure)),
      (todo) => emit(TodoDetailState.loaded(todo)),
    );
  }

  // ---------------------------------------------------------------------------
  // CREATE
  // ---------------------------------------------------------------------------

  /// Creates a new todo with the given title and description.
  ///
  /// State transitions: current → Loading → Saved/Error
  ///
  /// On success, emits [TodoDetailState.saved] which the UI uses
  /// to navigate back and show a success snackbar.
  Future<void> createTodo({
    required String title,
    String description = '',
  }) async {
    emit(const TodoDetailState.loading());

    final result = await _todoRepo.createTodo(
      title: title,
      description: description,
    );

    result.fold(
      (failure) => emit(TodoDetailState.error(failure)),
      // Emit Saved instead of Loaded — this triggers navigation in the UI
      (todo) => emit(TodoDetailState.saved(todo)),
    );
  }

  // ---------------------------------------------------------------------------
  // UPDATE
  // ---------------------------------------------------------------------------

  /// Updates an existing todo with PATCH semantics.
  ///
  /// Only the provided (non-null) fields are sent to the backend.
  ///
  /// State transitions: Loaded → Loading → Saved/Error
  ///
  /// Example:
  /// ```dart
  /// // Update only the title
  /// cubit.updateTodo(id: 42, title: 'New Title');
  ///
  /// // Toggle checked status
  /// cubit.updateTodo(id: 42, checked: true);
  ///
  /// // Update everything
  /// cubit.updateTodo(id: 42, title: 'New', description: 'Desc', checked: true);
  /// ```
  Future<void> updateTodo({
    required int id,
    String? title,
    String? description,
    bool? checked,
  }) async {
    emit(const TodoDetailState.loading());

    final result = await _todoRepo.updateTodo(
      id: id,
      title: title,
      description: description,
      checked: checked,
    );

    result.fold(
      (failure) => emit(TodoDetailState.error(failure)),
      (todo) => emit(TodoDetailState.saved(todo)),
    );
  }

  // ---------------------------------------------------------------------------
  // TOGGLE CHECKED
  // ---------------------------------------------------------------------------

  /// Toggles the checked status of the currently loaded todo.
  ///
  /// This is a convenience method that reads the current state to
  /// determine the todo ID and current checked status, then flips it.
  ///
  /// Only works when in the Loaded state — otherwise does nothing.
  Future<void> toggleChecked() async {
    // Only toggle if we have a loaded todo
    final currentState = state;
    if (currentState is! TodoDetailLoaded) return;

    final todo = currentState.todo;
    await updateTodo(id: todo.id, checked: !todo.checked);
  }
}

// =============================================================================
// Design Notes
// =============================================================================
//
// Create vs Edit in the same Cubit:
// - Both flows use the same Cubit with different initial actions
// - Create: Cubit starts in Initial, user fills form, calls createTodo()
// - Edit: Cubit starts in Initial, loadTodo() → Loaded, user edits, updateTodo()
// - Both end with Saved state → BlocListener navigates back
//
// Why not have the Cubit notify TodoListCubit directly?
// - Cubits should be independent — no direct references to each other
// - The UI (BlocListener) coordinates: when Saved → pop + refresh list
// - This keeps each Cubit focused on its own responsibility
// - Testing is easier: you test each Cubit in isolation
//
// Alternative: Cubit-to-Cubit communication
// ```dart
// // DON'T DO THIS — Cubits become coupled
// class TodoDetailCubit extends Cubit<TodoDetailState> {
//   final TodoListCubit _listCubit; // BAD: tight coupling
//
//   Future<void> createTodo(...) async {
//     // ...
//     _listCubit.refreshTodos(); // BAD: detail knows about list
//   }
// }
// ```
//
// Instead, let the UI coordinate:
// ```dart
// BlocListener<TodoDetailCubit, TodoDetailState>(
//   listener: (context, state) {
//     if (state is TodoDetailSaved) {
//       context.read<TodoListCubit>().refreshTodos(); // UI coordinates
//       Navigator.pop(context);
//     }
//   },
// )
// ```
// =============================================================================
