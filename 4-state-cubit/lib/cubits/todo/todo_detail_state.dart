// =============================================================================
// Todo Detail State — Freezed Union for Single Todo
// =============================================================================
// Concepts demonstrated:
// - 4-state pattern for a single item (load, edit, toggle checked)
// - Separating detail state from list state
// - How BlocListener reacts to state changes (navigation, snackbars)
//
// State diagram:
//   Initial → Loading → Loaded (with TodoDetail)
//                     ↘ Error
//   Loaded → Loading (on update/toggle)
//   Loaded → Saved (after successful save — triggers navigation)
//   Error → Loading (on retry)
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/models.dart';

part 'todo_detail_state.freezed.dart';

// =============================================================================
// Todo Detail State Union
// =============================================================================

/// The state of the todo detail Cubit.
///
/// Uses the 4-state pattern with an additional [Saved] variant.
/// The Saved state is used by BlocListener to trigger navigation
/// back to the list screen after a successful save.
///
/// Usage with BlocConsumer (Builder + Listener combined):
/// ```dart
/// BlocConsumer<TodoDetailCubit, TodoDetailState>(
///   listener: (context, state) {
///     state.maybeWhen(
///       saved: (todo) {
///         // Navigate back and refresh list
///         Navigator.pop(context);
///         context.read<TodoListCubit>().refreshTodos();
///       },
///       orElse: () {},
///     );
///   },
///   builder: (context, state) {
///     return state.when(
///       initial: () => SizedBox.shrink(),
///       loading: () => CircularProgressIndicator(),
///       loaded: (todo) => TodoForm(todo: todo),
///       saved: (todo) => CircularProgressIndicator(),
///       error: (failure) => ErrorWidget(failure),
///     );
///   },
/// )
/// ```
@freezed
sealed class TodoDetailState with _$TodoDetailState {
  /// No todo has been loaded yet.
  const factory TodoDetailState.initial() = TodoDetailInitial;

  /// The todo is being loaded, created, or updated.
  const factory TodoDetailState.loading() = TodoDetailLoading;

  /// A todo was successfully loaded.
  ///
  /// Contains the full [TodoDetail] for display and editing.
  const factory TodoDetailState.loaded(TodoDetail todo) = TodoDetailLoaded;

  /// A todo was successfully saved (created or updated).
  ///
  /// This is a transient state — BlocListener should react to it
  /// (e.g., show a snackbar, navigate back) and then the screen is popped.
  const factory TodoDetailState.saved(TodoDetail todo) = TodoDetailSaved;

  /// An error occurred while loading, creating, or updating the todo.
  const factory TodoDetailState.error(TodoFailure failure) = TodoDetailError;
}

// =============================================================================
// Design Notes
// =============================================================================
//
// Why a "Saved" state?
// - BlocListener needs to know when a save completed successfully
// - This triggers navigation (pop back to list) and a snackbar
// - Without it, the Cubit would have to call Navigator directly (bad practice)
//
// BlocBuilder vs BlocListener vs BlocConsumer:
// - BlocBuilder: rebuilds the UI when state changes (rendering)
// - BlocListener: executes side effects when state changes (navigation, snackbar)
// - BlocConsumer: combines both — rebuild AND execute side effects
//
// When to use each:
// - Use BlocBuilder for rendering state (loading indicator, list, error)
// - Use BlocListener for one-time actions (navigate, show dialog, show snackbar)
// - Use BlocConsumer when you need both (form screen that shows loading AND
//   navigates on save)
//
// Example:
// ```dart
// // BlocListener — for one-time side effects
// BlocListener<TodoDetailCubit, TodoDetailState>(
//   listenWhen: (previous, current) => current is TodoDetailSaved,
//   listener: (context, state) {
//     ScaffoldMessenger.of(context).showSnackBar(...);
//     Navigator.pop(context);
//   },
//   child: ...,
// )
// ```
// =============================================================================
