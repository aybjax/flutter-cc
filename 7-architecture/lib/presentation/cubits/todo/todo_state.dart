// =============================================================================
// Todo State (Freezed Union)
// =============================================================================
// All possible states for the todo list and detail views.
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/todo_entity.dart';

part 'todo_state.freezed.dart';

// ---------------------------------------------------------------------------
// TodoState
// ---------------------------------------------------------------------------

/// Represents all possible states of the todo feature.
///
/// Supports both list and detail views through different state variants.
@freezed
class TodoState with _$TodoState {
  /// Initial state before any data is loaded.
  const factory TodoState.initial() = _Initial;

  /// Loading state while fetching data.
  const factory TodoState.loading() = _Loading;

  /// Successfully loaded a list of todos.
  const factory TodoState.loaded({
    required List<TodoEntity> todos,
    required int total,
    required int page,
    required int pageSize,
  }) = TodoLoaded;

  /// Successfully loaded a single todo detail.
  const factory TodoState.detail(TodoEntity todo) = _Detail;

  /// An error occurred.
  const factory TodoState.error(String message) = _Error;

  // Alternative: combine list + detail into a single rich state
  // const factory TodoState({
  //   @Default([]) List<TodoEntity> todos,
  //   TodoEntity? selectedTodo,
  //   @Default(false) bool isLoading,
  //   String? errorMessage,
  // }) = _TodoState;
}
