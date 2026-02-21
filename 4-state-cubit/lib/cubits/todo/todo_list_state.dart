// =============================================================================
// Todo List State — Freezed Union for Paginated List
// =============================================================================
// Concepts demonstrated:
// - 4-state pattern applied to a paginated list
// - Carrying pagination metadata in the Loaded state
// - How BlocBuilder renders different UI for each state
//
// State diagram:
//   Initial → Loading → Loaded (with todos, total, page)
//                     ↘ Error
//   Loaded → Loading (on refresh/next page)
//   Error → Loading (on retry)
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/models.dart';

part 'todo_list_state.freezed.dart';

// =============================================================================
// Todo List State Union
// =============================================================================

/// The state of the todo list Cubit.
///
/// Uses the 4-state pattern: Initial, Loading, Loaded, Error.
///
/// The Loaded state carries the full list of todos plus pagination info,
/// so the UI can show "page 1 of 3" and load more.
///
/// Usage in BlocBuilder:
/// ```dart
/// BlocBuilder<TodoListCubit, TodoListState>(
///   builder: (context, state) {
///     return state.when(
///       initial: () => Text('Pull to refresh'),
///       loading: () => CircularProgressIndicator(),
///       loaded: (todos, total, page, pageSize) => ListView(...),
///       error: (failure) => ErrorWidget(failure),
///     );
///   },
/// )
/// ```
@freezed
sealed class TodoListState with _$TodoListState {
  /// No data has been loaded yet.
  const factory TodoListState.initial() = TodoListInitial;

  /// Data is being fetched from the backend.
  const factory TodoListState.loading() = TodoListLoading;

  /// Todos were successfully loaded.
  ///
  /// Contains the list of [TodoSummary] items plus pagination metadata.
  const factory TodoListState.loaded({
    /// The list of todos for the current page.
    required List<TodoSummary> todos,

    /// Total number of todos across all pages.
    required int total,

    /// The current page number (1-indexed).
    required int page,

    /// The number of items per page.
    required int pageSize,
  }) = TodoListLoaded;

  /// An error occurred while fetching todos.
  ///
  /// Contains the typed [TodoFailure] for displaying an error message.
  const factory TodoListState.error(TodoFailure failure) = TodoListError;
}

// =============================================================================
// Design Notes
// =============================================================================
//
// Why include pagination data in the state?
// - The UI needs page/total to show "Showing 10 of 25"
// - The Cubit needs pageSize to know what to request next
// - All of this is bundled in the Loaded variant
//
// Alternative approaches:
// 1. Separate state for pagination (more complex, rarely needed)
// 2. Infinite scroll with append (add todos to existing list):
//    ```dart
//    const factory TodoListState.loaded({
//      required List<TodoSummary> todos,
//      required bool hasMore,
//    }) = TodoListLoaded;
//    ```
//
// BlocBuilder optimization:
// ```dart
// BlocBuilder<TodoListCubit, TodoListState>(
//   // Only rebuild when the state TYPE changes (not when data within Loaded changes)
//   buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
//   builder: ...,
// )
// ```
// This prevents unnecessary rebuilds when, say, a todo's checked status
// changes but we're still in the Loaded state.
// =============================================================================
