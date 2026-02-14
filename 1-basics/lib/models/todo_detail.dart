// ignore_for_file: unnecessary_getters_setters
// The getter/setter pattern below is intentionally used for teaching purposes.
// In production, plain fields would be simpler.

// =============================================================================
// TodoDetail Model
// =============================================================================
// Concepts demonstrated:
// - Mutable vs immutable fields (final vs non-final)
// - Explicit getters and setters with custom logic
// - Nullable types and null-aware operators (?., ??)
// - The difference between a summary model and a full detail model
// - copyWith pattern for creating modified copies
// =============================================================================

/// Full representation of a single todo item.
///
/// Unlike [TodoSummary], this model includes the description, user_id,
/// and the original-size image path. It is returned by GET /todos/{id}.
///
/// Some fields use explicit getters/setters to demonstrate the concept,
/// even though simple final fields would suffice in production code.
///
/// Backend JSON:
/// ```json
/// {
///   "id": 1,
///   "user_id": 1,
///   "title": "Buy groceries",
///   "description": "Milk, eggs, bread",
///   "checked": false,
///   "image": "/images/originals/abc123.png"   // may be absent
/// }
/// ```
class TodoDetail {
  /// Unique identifier — immutable after creation.
  final int id;

  /// ID of the user who owns this todo — immutable.
  final int userId;

  // ---------------------------------------------------------------------------
  // Fields with explicit getters/setters
  // ---------------------------------------------------------------------------
  // In Dart, you can use a private field (_title) paired with a public getter
  // (get title) and setter (set title). This lets you add validation or
  // side-effects when a value is read or written.
  // ---------------------------------------------------------------------------

  /// Backing field for [title]. The underscore makes it library-private.
  String _title;

  /// The todo's title.
  ///
  /// Getter — returns the private backing field.
  String get title => _title;

  /// Setter — allows updating the title after creation.
  ///
  /// In a real app you might add validation here, e.g.:
  /// ```dart
  /// set title(String value) {
  ///   if (value.isEmpty) throw ArgumentError('Title cannot be empty');
  ///   _title = value;
  /// }
  /// ```
  set title(String value) => _title = value;

  /// Backing field for [description].
  String _description;

  /// The todo's detailed description.
  String get description => _description;

  /// Setter for description.
  set description(String value) => _description = value;

  /// Backing field for [checked].
  bool _checked;

  /// Whether this todo is completed.
  bool get checked => _checked;

  /// Setter for the checked state.
  set checked(bool value) => _checked = value;

  /// Relative path to the full-size image, or `null` if none.
  ///
  /// This field is kept as a simple nullable field (no getter/setter)
  /// to show that you don't *always* need explicit accessors.
  String? image;

  /// Creates a [TodoDetail] with all fields.
  TodoDetail({
    required this.id,
    required this.userId,
    required String title,
    required String description,
    required bool checked,
    this.image,
  })  : _title = title,
        _description = description,
        _checked = checked;

  /// Factory constructor for JSON deserialization.
  factory TodoDetail.fromJson(Map<String, dynamic> json) {
    return TodoDetail(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      title: json['title'] as String,
      // The `??` (null-coalescing) operator provides a default value
      // when the left-hand side is null.
      description: (json['description'] as String?) ?? '',
      checked: json['checked'] as bool,
      // Nullable field — pass null if the key is absent.
      image: json['image'] as String?,
    );
  }

  /// Whether this todo has an attached image.
  bool get hasImage => image != null;

  /// Creates a copy of this [TodoDetail] with selected fields replaced.
  ///
  /// The *copyWith* pattern is common in Flutter (see ThemeData.copyWith).
  /// It lets you create a new object that is identical except for the
  /// fields you specify:
  /// ```dart
  /// final updated = todo.copyWith(checked: true);
  /// ```
  TodoDetail copyWith({
    String? title,
    String? description,
    bool? checked,
    String? image,
  }) {
    return TodoDetail(
      id: id,
      userId: userId,
      title: title ?? _title,
      description: description ?? _description,
      checked: checked ?? _checked,
      image: image ?? this.image,
    );
  }

  /// Converts to a JSON map suitable for PATCH requests.
  ///
  /// Only includes mutable fields — id and userId are never sent in updates.
  Map<String, dynamic> toJson() {
    return {
      'title': _title,
      'description': _description,
      'checked': _checked,
      if (image != null) 'icon_url': image,
    };
  }

  @override
  String toString() =>
      'TodoDetail(id: $id, title: $_title, checked: $_checked)';
}
