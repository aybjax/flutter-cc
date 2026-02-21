// =============================================================================
// Todo Model (Data Layer)
// =============================================================================
// Freezed + JsonSerializable model for todo items. Handles the mapping
// between the Go backend's JSON format and the domain entity.
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/todo_entity.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

// ---------------------------------------------------------------------------
// TodoModel
// ---------------------------------------------------------------------------

/// Data-layer representation of a todo, with JSON serialization.
///
/// The backend returns:
/// ```json
/// {
///   "id": 1,
///   "user_id": 1,
///   "title": "Buy milk",
///   "description": "From the store",
///   "checked": false,
///   "image": null
/// }
/// ```
@freezed
class TodoModel with _$TodoModel {
  const TodoModel._();

  const factory TodoModel({
    required int id,
    // The Go backend uses snake_case; JsonKey maps to Dart's camelCase
    @JsonKey(name: 'user_id') required int userId,
    required String title,
    @Default('') String description,
    @JsonKey(name: 'checked') @Default(false) bool isChecked,
    String? image,
  }) = _TodoModel;

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

  // ---------------------------------------------------------------------------
  // Domain conversion
  // ---------------------------------------------------------------------------

  /// Converts this data model to a domain [TodoEntity].
  TodoEntity toEntity() {
    return TodoEntity(
      id: id,
      userId: userId,
      title: title,
      description: description,
      checked: isChecked,
      image: image,
    );
  }

  // Alternative: create a model from an entity (for sending to API)
  // factory TodoModel.fromEntity(TodoEntity entity) {
  //   return TodoModel(
  //     id: entity.id,
  //     userId: entity.userId,
  //     title: entity.title,
  //     description: entity.description,
  //     checked: entity.checked,
  //     image: entity.image,
  //   );
  // }
}
