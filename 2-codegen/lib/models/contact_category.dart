// =============================================================================
// Contact Category Enum
// =============================================================================
// Concepts demonstrated:
// - Dart enums with json_serializable support
// - @JsonValue annotation for custom JSON mapping
// - Enum extensions for display logic
// - How enums serialize/deserialize in generated code
// =============================================================================

/// The category a contact belongs to.
///
/// Dart enums are first-class types — they can have methods, implement
/// interfaces, and carry metadata. When used with [json_serializable],
/// each enum value is serialized as a string by default.
///
/// You can customize the serialized string with [@JsonValue]:
/// ```dart
/// @JsonValue('custom_string')
/// myValue,
/// ```
enum ContactCategory {
  /// Family members — parents, siblings, children, etc.
  family,

  /// Friends — personal, non-work relationships.
  friend,

  /// Work — colleagues, clients, professional contacts.
  work,

  /// Other — any contact that doesn't fit the above.
  other,
}

// =============================================================================
// Enum Extensions
// =============================================================================
// Extensions add methods to existing types without subclassing.
// This keeps the enum clean while adding display-specific logic.

/// Adds UI-friendly properties to [ContactCategory].
extension ContactCategoryExtension on ContactCategory {
  /// Returns an emoji icon for the category.
  ///
  /// Dart's switch expression (introduced in Dart 3) provides exhaustive
  /// pattern matching — the compiler ensures every enum value is handled.
  String get icon => switch (this) {
    ContactCategory.family => '👨‍👩‍👧‍👦',
    ContactCategory.friend => '🤝',
    ContactCategory.work   => '💼',
    ContactCategory.other  => '📋',
  };

  // Alternative: traditional switch statement (pre-Dart 3)
  // String get icon {
  //   switch (this) {
  //     case ContactCategory.family: return '👨‍👩‍👧‍👦';
  //     case ContactCategory.friend: return '🤝';
  //     case ContactCategory.work:   return '💼';
  //     case ContactCategory.other:  return '📋';
  //   }
  // }
}
