// =============================================================================
// TodoSummary Model
// =============================================================================
// Concepts demonstrated:
// - Nullable types (String?) — Dart null safety
// - Conditional expressions (ternary operator)
// - JSON deserialization with optional fields
// - The difference between a summary and a detail model
// =============================================================================

/// A lightweight representation of a todo item used in list/grid views.
///
/// The backend GET /todos returns an array of these summaries — they
/// contain just enough data to render a list tile or grid card without
/// fetching the full detail.
///
/// Backend JSON:
/// ```json
/// {
///   "id": 1,
///   "title": "Buy groceries",
///   "checked": false,
///   "thumbnail": "/images/thumbnails/abc123.jpg"   // may be absent
/// }
/// ```
class TodoSummary {
  /// Unique identifier for this todo.
  final int id;

  /// Short title displayed in lists and grids.
  final String title;

  /// Whether the todo has been completed.
  final bool checked;

  /// Relative path to a thumbnail image, or `null` if no image was attached.
  ///
  /// The `?` makes this field *nullable* — it can hold a [String] or `null`.
  /// Nullable types are a core part of Dart's sound null safety system.
  final String? thumbnail;

  /// Creates a [TodoSummary].
  const TodoSummary({
    required this.id,
    required this.title,
    required this.checked,
    this.thumbnail, // optional — defaults to null
  });

  /// Deserializes a JSON map into a [TodoSummary].
  ///
  /// The ternary operator `condition ? valueIfTrue : valueIfFalse` is used
  /// to safely handle the optional `thumbnail` field.
  factory TodoSummary.fromJson(Map<String, dynamic> json) {
    return TodoSummary(
      id: json['id'] as int,
      title: json['title'] as String,
      checked: json['checked'] as bool,
      // If the key exists and is not null, cast to String; otherwise null.
      thumbnail: json['thumbnail'] != null
          ? json['thumbnail'] as String
          : null,
    );
  }

  /// Whether this todo has a thumbnail image available.
  ///
  /// A *getter* — looks like a field but is computed on access.
  bool get hasThumbnail => thumbnail != null;

  @override
  String toString() =>
      'TodoSummary(id: $id, title: $title, checked: $checked)';
}
