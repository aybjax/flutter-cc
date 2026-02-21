// =============================================================================
// Todo Model — Freezed + JSON Serializable
// =============================================================================
// Concepts demonstrated:
// - @freezed annotation — generates immutable data class
// - @JsonKey for mapping snake_case JSON to camelCase Dart fields
// - @Default for fields that may be absent in JSON
// - Two models: TodoSummary (list view) and TodoDetail (detail view)
//
// The Go backend has two response shapes:
// 1. List endpoint returns TodoSummary: { id, title, checked, thumbnail? }
// 2. Detail endpoint returns TodoDetail: { id, user_id, title, description, checked, image? }
//
// We model both so the UI can work with the right level of detail.
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

// -- Part directives --
part 'todo.freezed.dart';
part 'todo.g.dart';

// =============================================================================
// TodoSummary — Slim Model for List View
// =============================================================================

/// A lightweight todo for displaying in list views.
///
/// The GET /todos endpoint returns an array of these:
/// ```json
/// { "id": 1, "title": "Buy groceries", "checked": false }
/// ```
///
/// Using a separate summary model avoids fetching description data
/// that isn't needed in the list view (network optimization).
@freezed
abstract class TodoSummary with _$TodoSummary {
  /// Creates a [TodoSummary] from list endpoint data.
  const factory TodoSummary({
    /// Unique todo ID assigned by the backend.
    required int id,

    /// The todo's title text.
    required String title,

    /// Whether the todo has been completed.
    @Default(false) bool checked,

    /// Optional thumbnail URL (for icon support).
    String? thumbnail,
  }) = _TodoSummary;

  /// Deserializes a [TodoSummary] from a JSON map.
  factory TodoSummary.fromJson(Map<String, dynamic> json) =>
      _$TodoSummaryFromJson(json);
}

// =============================================================================
// TodoDetail — Full Model for Detail/Edit View
// =============================================================================

/// A complete todo with all fields, returned by detail endpoints.
///
/// The GET /todos/{id} endpoint returns:
/// ```json
/// {
///   "id": 1,
///   "user_id": 1,
///   "title": "Buy groceries",
///   "description": "Milk, eggs, bread",
///   "checked": false,
///   "image": "http://localhost:8080/images/abc123.png"
/// }
/// ```
@freezed
abstract class TodoDetail with _$TodoDetail {
  /// Creates a [TodoDetail] from detail endpoint data.
  const factory TodoDetail({
    /// Unique todo ID assigned by the backend.
    required int id,

    /// The owning user's ID.
    @JsonKey(name: 'user_id') required int userId,

    /// The todo's title text.
    required String title,

    /// The todo's description / body text.
    @Default('') String description,

    /// Whether the todo has been completed.
    @Default(false) bool checked,

    /// Optional full-size image URL.
    String? image,
  }) = _TodoDetail;

  /// Deserializes a [TodoDetail] from a JSON map.
  factory TodoDetail.fromJson(Map<String, dynamic> json) =>
      _$TodoDetailFromJson(json);
}

// =============================================================================
// Design Notes
// =============================================================================
//
// Why two models (Summary vs Detail)?
// - The backend intentionally returns different shapes for list vs detail
// - TodoSummary is lighter: no description, no user_id
// - This mirrors a common API pattern: slim list responses, full detail responses
// - The list screen uses TodoSummary, detail/edit screens use TodoDetail
//
// Alternative: use a single Todo model with nullable fields.
// That works but loses the type-level guarantee of what data you have.
//
// Cubit vs ChangeNotifier comparison:
// - With ChangeNotifier, you'd store List<TodoSummary> and call notifyListeners()
// - With Cubit, you emit a new state (e.g., TodoListState.loaded(todos))
// - Cubit makes state transitions explicit: initial → loading → loaded/error
// =============================================================================
