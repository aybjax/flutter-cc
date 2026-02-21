// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TaskCard _$TaskCardFromJson(Map<String, dynamic> json) {
  return _TaskCard.fromJson(json);
}

/// @nodoc
mixin _$TaskCard {
  /// Unique identifier for the card.
  String get id => throw _privateConstructorUsedError;

  /// Short title of the task.
  String get title => throw _privateConstructorUsedError;

  /// Longer description of what the task involves.
  String get description => throw _privateConstructorUsedError;

  /// The ID of the column this card belongs to.
  String get columnId => throw _privateConstructorUsedError;

  /// Zero-based position within the column (top to bottom).
  int get position => throw _privateConstructorUsedError;

  /// Serializes this TaskCard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskCardCopyWith<TaskCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCardCopyWith<$Res> {
  factory $TaskCardCopyWith(TaskCard value, $Res Function(TaskCard) then) =
      _$TaskCardCopyWithImpl<$Res, TaskCard>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String columnId,
    int position,
  });
}

/// @nodoc
class _$TaskCardCopyWithImpl<$Res, $Val extends TaskCard>
    implements $TaskCardCopyWith<$Res> {
  _$TaskCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? columnId = null,
    Object? position = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            columnId: null == columnId
                ? _value.columnId
                : columnId // ignore: cast_nullable_to_non_nullable
                      as String,
            position: null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TaskCardImplCopyWith<$Res>
    implements $TaskCardCopyWith<$Res> {
  factory _$$TaskCardImplCopyWith(
    _$TaskCardImpl value,
    $Res Function(_$TaskCardImpl) then,
  ) = __$$TaskCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    String columnId,
    int position,
  });
}

/// @nodoc
class __$$TaskCardImplCopyWithImpl<$Res>
    extends _$TaskCardCopyWithImpl<$Res, _$TaskCardImpl>
    implements _$$TaskCardImplCopyWith<$Res> {
  __$$TaskCardImplCopyWithImpl(
    _$TaskCardImpl _value,
    $Res Function(_$TaskCardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TaskCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? columnId = null,
    Object? position = null,
  }) {
    return _then(
      _$TaskCardImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        columnId: null == columnId
            ? _value.columnId
            : columnId // ignore: cast_nullable_to_non_nullable
                  as String,
        position: null == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskCardImpl implements _TaskCard {
  const _$TaskCardImpl({
    required this.id,
    required this.title,
    this.description = '',
    required this.columnId,
    required this.position,
  });

  factory _$TaskCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskCardImplFromJson(json);

  /// Unique identifier for the card.
  @override
  final String id;

  /// Short title of the task.
  @override
  final String title;

  /// Longer description of what the task involves.
  @override
  @JsonKey()
  final String description;

  /// The ID of the column this card belongs to.
  @override
  final String columnId;

  /// Zero-based position within the column (top to bottom).
  @override
  final int position;

  @override
  String toString() {
    return 'TaskCard(id: $id, title: $title, description: $description, columnId: $columnId, position: $position)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskCardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.columnId, columnId) ||
                other.columnId == columnId) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, description, columnId, position);

  /// Create a copy of TaskCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskCardImplCopyWith<_$TaskCardImpl> get copyWith =>
      __$$TaskCardImplCopyWithImpl<_$TaskCardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskCardImplToJson(this);
  }
}

abstract class _TaskCard implements TaskCard {
  const factory _TaskCard({
    required final String id,
    required final String title,
    final String description,
    required final String columnId,
    required final int position,
  }) = _$TaskCardImpl;

  factory _TaskCard.fromJson(Map<String, dynamic> json) =
      _$TaskCardImpl.fromJson;

  /// Unique identifier for the card.
  @override
  String get id;

  /// Short title of the task.
  @override
  String get title;

  /// Longer description of what the task involves.
  @override
  String get description;

  /// The ID of the column this card belongs to.
  @override
  String get columnId;

  /// Zero-based position within the column (top to bottom).
  @override
  int get position;

  /// Create a copy of TaskCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskCardImplCopyWith<_$TaskCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
