// =============================================================================
// Todo Entity
// =============================================================================
// Pure domain entity representing a todo item. Contains only the fields
// the business logic needs. The data layer handles mapping from JSON models.
// =============================================================================

/// Represents a single todo item in the domain layer.
///
/// This entity is used throughout the domain and presentation layers.
/// The data layer's [TodoModel] maps to/from this entity.
class TodoEntity {
  /// Unique identifier from the backend.
  final int id;

  /// ID of the user who owns this todo.
  final int userId;

  /// Short summary of the task.
  final String title;

  /// Detailed description of the task.
  final String description;

  /// Whether the task has been completed.
  final bool checked;

  /// Optional image URL associated with the todo.
  final String? image;

  /// Creates a [TodoEntity].
  const TodoEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.checked,
    this.image,
  });

  // Alternative: implement copyWith manually for immutable updates
  // TodoEntity copyWith({String? title, bool? checked}) {
  //   return TodoEntity(
  //     id: id,
  //     userId: userId,
  //     title: title ?? this.title,
  //     description: description,
  //     checked: checked ?? this.checked,
  //     image: image,
  //   );
  // }
}
