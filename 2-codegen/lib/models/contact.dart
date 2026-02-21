// =============================================================================
// Contact Model — Freezed + JSON Serializable
// =============================================================================
// Concepts demonstrated:
// - @freezed annotation — generates immutable data class
// - @JsonSerializable integration — fromJson/toJson via generated code
// - @JsonKey — customizes JSON field names and default values
// - @Default — provides default values for optional fields
// - part directive — connects this file to generated *.freezed.dart and *.g.dart
// - copyWith — creates a modified copy of an immutable object
// - == and hashCode — generated for value equality
// =============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';
import 'contact_category.dart';

// -- Part directives --
// These tell Dart that generated code lives in sibling files.
// `part 'contact.freezed.dart'` — contains copyWith, ==, hashCode, toString
// `part 'contact.g.dart'`       — contains _$ContactFromJson, _$ContactToJson
//
// The `part` directive is different from `import`:
// - `import` brings in a separate library
// - `part` says "this file is a piece of the SAME library"
// - Generated files use `part of` to declare they belong to this file
part 'contact.freezed.dart';
part 'contact.g.dart';

// =============================================================================
// The @freezed Annotation
// =============================================================================
// When you annotate a class with @freezed and run build_runner, it generates:
//   1. A private _$Contact constructor class
//   2. copyWith() method for creating modified copies
//   3. == operator and hashCode for deep value equality
//   4. toString() for readable debug output
//   5. fromJson/toJson if you mix in _$ContactFromJson
//
// Why immutable models?
// - Predictable state: once created, a Contact never changes
// - Safe to pass around: no one can accidentally mutate it
// - Easy comparison: two Contacts with same fields are == equal
// - Undo/redo friendly: just keep old references

/// A single contact in the contact book.
///
/// This class is immutable — all fields are `final`. To "modify" a contact,
/// use [copyWith] to create a new instance with the changed fields:
/// ```dart
/// final updated = contact.copyWith(name: 'New Name');
/// ```
@freezed
abstract class Contact with _$Contact {
  /// Creates a [Contact] with all required and optional fields.
  ///
  /// The `const factory` pattern is required by freezed. It tells the
  /// generator to create an implementing class with these fields.
  ///
  /// [@JsonKey] customizes how fields map to/from JSON:
  /// - `name:` overrides the JSON key (e.g., `phone_number` in JSON → `phone` in Dart)
  /// - `defaultValue:` provides a value when the key is missing from JSON
  /// - `includeIfNull:` controls whether null fields appear in toJson output
  ///
  /// [@Default] provides a default value AND makes the parameter optional
  /// in the constructor. Without it, the field would be required.
  const factory Contact({
    /// Unique identifier for this contact (UUID v4).
    required String id,

    /// Full name of the contact (required — no default).
    required String name,

    /// Email address, or null if not provided.
    ///
    /// Nullable types (String?) don't need @Default — they default to null.
    String? email,

    /// Phone number. The @JsonKey maps to 'phone_number' in JSON.
    ///
    /// This is useful when the JSON API uses snake_case but your Dart
    /// code uses camelCase. The generator handles the conversion.
    @JsonKey(name: 'phone_number') String? phone,

    /// Optional notes about this contact.
    String? notes,

    /// Contact category. Defaults to [ContactCategory.other].
    ///
    /// [@Default] serves two purposes:
    /// 1. Makes `category` optional in the constructor
    /// 2. Provides the default for JSON deserialization when the key is missing
    @Default(ContactCategory.other) ContactCategory category,

    /// Whether this contact is a favorite.
    ///
    /// Demonstrates @Default with a primitive type.
    @Default(false) bool isFavorite,

    /// When this contact was created. Stored as ISO 8601 string in JSON.
    required DateTime createdAt,
  }) = _Contact;

  // ---------------------------------------------------------------------------
  // JSON serialization
  // ---------------------------------------------------------------------------
  // This factory connects to the generated _$ContactFromJson function
  // in contact.g.dart. The generator reads @JsonSerializable options from
  // the @freezed annotation and produces the parsing code.
  //
  // The generated code handles:
  // - Type conversion (String → DateTime via DateTime.parse)
  // - Null safety (nullable fields get null when missing)
  // - Enum mapping (String → ContactCategory via enum name matching)
  // - Default values (@Default annotations are respected)

  /// Deserializes a [Contact] from a JSON map.
  ///
  /// Example:
  /// ```dart
  /// final json = {'id': '123', 'name': 'Alice', 'createdAt': '2024-01-01'};
  /// final contact = Contact.fromJson(json);
  /// ```
  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);
}

// =============================================================================
// What gets generated? (summary)
// =============================================================================
//
// contact.freezed.dart contains:
// ```dart
// class _$ContactImpl implements Contact {
//   // All fields as final
//   // const constructor
//   // copyWith() method returning a new _$ContactImpl
//   // == operator comparing every field
//   // hashCode combining every field
//   // toString() listing every field
// }
// ```
//
// contact.g.dart contains:
// ```dart
// Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
//   id: json['id'] as String,
//   name: json['name'] as String,
//   email: json['email'] as String?,
//   phone: json['phone_number'] as String?,  // note: @JsonKey(name:)
//   category: $enumDecodeNullable(...) ?? ContactCategory.other,
//   isFavorite: json['isFavorite'] as bool? ?? false,
//   createdAt: DateTime.parse(json['createdAt'] as String),
// );
//
// Map<String, dynamic> _$ContactToJson(Contact instance) => {
//   'id': instance.id,
//   'name': instance.name,
//   'email': instance.email,
//   'phone_number': instance.phone,  // note: @JsonKey(name:)
//   'category': instance.category.name,
//   'isFavorite': instance.isFavorite,
//   'createdAt': instance.createdAt.toIso8601String(),
// };
// ```
