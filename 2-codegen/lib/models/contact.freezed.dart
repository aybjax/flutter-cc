// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Contact _$ContactFromJson(Map<String, dynamic> json) {
  return _Contact.fromJson(json);
}

/// @nodoc
mixin _$Contact {
  /// Unique identifier for this contact (UUID v4).
  String get id => throw _privateConstructorUsedError;

  /// Full name of the contact (required — no default).
  String get name => throw _privateConstructorUsedError;

  /// Email address, or null if not provided.
  ///
  /// Nullable types (String?) don't need @Default — they default to null.
  String? get email => throw _privateConstructorUsedError;

  /// Phone number. The @JsonKey maps to 'phone_number' in JSON.
  ///
  /// This is useful when the JSON API uses snake_case but your Dart
  /// code uses camelCase. The generator handles the conversion.
  @JsonKey(name: 'phone_number')
  String? get phone => throw _privateConstructorUsedError;

  /// Optional notes about this contact.
  String? get notes => throw _privateConstructorUsedError;

  /// Contact category. Defaults to [ContactCategory.other].
  ///
  /// [@Default] serves two purposes:
  /// 1. Makes `category` optional in the constructor
  /// 2. Provides the default for JSON deserialization when the key is missing
  ContactCategory get category => throw _privateConstructorUsedError;

  /// Whether this contact is a favorite.
  ///
  /// Demonstrates @Default with a primitive type.
  bool get isFavorite => throw _privateConstructorUsedError;

  /// When this contact was created. Stored as ISO 8601 string in JSON.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Contact to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContactCopyWith<Contact> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactCopyWith<$Res> {
  factory $ContactCopyWith(Contact value, $Res Function(Contact) then) =
      _$ContactCopyWithImpl<$Res, Contact>;
  @useResult
  $Res call({
    String id,
    String name,
    String? email,
    @JsonKey(name: 'phone_number') String? phone,
    String? notes,
    ContactCategory category,
    bool isFavorite,
    DateTime createdAt,
  });
}

/// @nodoc
class _$ContactCopyWithImpl<$Res, $Val extends Contact>
    implements $ContactCopyWith<$Res> {
  _$ContactCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = freezed,
    Object? phone = freezed,
    Object? notes = freezed,
    Object? category = null,
    Object? isFavorite = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as ContactCategory,
            isFavorite: null == isFavorite
                ? _value.isFavorite
                : isFavorite // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ContactImplCopyWith<$Res> implements $ContactCopyWith<$Res> {
  factory _$$ContactImplCopyWith(
    _$ContactImpl value,
    $Res Function(_$ContactImpl) then,
  ) = __$$ContactImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? email,
    @JsonKey(name: 'phone_number') String? phone,
    String? notes,
    ContactCategory category,
    bool isFavorite,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$ContactImplCopyWithImpl<$Res>
    extends _$ContactCopyWithImpl<$Res, _$ContactImpl>
    implements _$$ContactImplCopyWith<$Res> {
  __$$ContactImplCopyWithImpl(
    _$ContactImpl _value,
    $Res Function(_$ContactImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = freezed,
    Object? phone = freezed,
    Object? notes = freezed,
    Object? category = null,
    Object? isFavorite = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$ContactImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as ContactCategory,
        isFavorite: null == isFavorite
            ? _value.isFavorite
            : isFavorite // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ContactImpl implements _Contact {
  const _$ContactImpl({
    required this.id,
    required this.name,
    this.email,
    @JsonKey(name: 'phone_number') this.phone,
    this.notes,
    this.category = ContactCategory.other,
    this.isFavorite = false,
    required this.createdAt,
  });

  factory _$ContactImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContactImplFromJson(json);

  /// Unique identifier for this contact (UUID v4).
  @override
  final String id;

  /// Full name of the contact (required — no default).
  @override
  final String name;

  /// Email address, or null if not provided.
  ///
  /// Nullable types (String?) don't need @Default — they default to null.
  @override
  final String? email;

  /// Phone number. The @JsonKey maps to 'phone_number' in JSON.
  ///
  /// This is useful when the JSON API uses snake_case but your Dart
  /// code uses camelCase. The generator handles the conversion.
  @override
  @JsonKey(name: 'phone_number')
  final String? phone;

  /// Optional notes about this contact.
  @override
  final String? notes;

  /// Contact category. Defaults to [ContactCategory.other].
  ///
  /// [@Default] serves two purposes:
  /// 1. Makes `category` optional in the constructor
  /// 2. Provides the default for JSON deserialization when the key is missing
  @override
  @JsonKey()
  final ContactCategory category;

  /// Whether this contact is a favorite.
  ///
  /// Demonstrates @Default with a primitive type.
  @override
  @JsonKey()
  final bool isFavorite;

  /// When this contact was created. Stored as ISO 8601 string in JSON.
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Contact(id: $id, name: $name, email: $email, phone: $phone, notes: $notes, category: $category, isFavorite: $isFavorite, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    email,
    phone,
    notes,
    category,
    isFavorite,
    createdAt,
  );

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactImplCopyWith<_$ContactImpl> get copyWith =>
      __$$ContactImplCopyWithImpl<_$ContactImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContactImplToJson(this);
  }
}

abstract class _Contact implements Contact {
  const factory _Contact({
    required final String id,
    required final String name,
    final String? email,
    @JsonKey(name: 'phone_number') final String? phone,
    final String? notes,
    final ContactCategory category,
    final bool isFavorite,
    required final DateTime createdAt,
  }) = _$ContactImpl;

  factory _Contact.fromJson(Map<String, dynamic> json) = _$ContactImpl.fromJson;

  /// Unique identifier for this contact (UUID v4).
  @override
  String get id;

  /// Full name of the contact (required — no default).
  @override
  String get name;

  /// Email address, or null if not provided.
  ///
  /// Nullable types (String?) don't need @Default — they default to null.
  @override
  String? get email;

  /// Phone number. The @JsonKey maps to 'phone_number' in JSON.
  ///
  /// This is useful when the JSON API uses snake_case but your Dart
  /// code uses camelCase. The generator handles the conversion.
  @override
  @JsonKey(name: 'phone_number')
  String? get phone;

  /// Optional notes about this contact.
  @override
  String? get notes;

  /// Contact category. Defaults to [ContactCategory.other].
  ///
  /// [@Default] serves two purposes:
  /// 1. Makes `category` optional in the constructor
  /// 2. Provides the default for JSON deserialization when the key is missing
  @override
  ContactCategory get category;

  /// Whether this contact is a favorite.
  ///
  /// Demonstrates @Default with a primitive type.
  @override
  bool get isFavorite;

  /// When this contact was created. Stored as ISO 8601 string in JSON.
  @override
  DateTime get createdAt;

  /// Create a copy of Contact
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContactImplCopyWith<_$ContactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
