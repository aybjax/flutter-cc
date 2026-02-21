// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'board_column.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BoardColumn _$BoardColumnFromJson(Map<String, dynamic> json) {
  return _BoardColumn.fromJson(json);
}

/// @nodoc
mixin _$BoardColumn {
  /// Unique identifier for the column.
  String get id => throw _privateConstructorUsedError;

  /// Display name (e.g., "To Do", "In Progress", "Done").
  String get name => throw _privateConstructorUsedError;

  /// Zero-based position in the board (left to right).
  int get position => throw _privateConstructorUsedError;

  /// Cards currently in this column, ordered by position.
  List<TaskCard> get cards => throw _privateConstructorUsedError;

  /// Serializes this BoardColumn to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BoardColumn
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BoardColumnCopyWith<BoardColumn> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoardColumnCopyWith<$Res> {
  factory $BoardColumnCopyWith(
    BoardColumn value,
    $Res Function(BoardColumn) then,
  ) = _$BoardColumnCopyWithImpl<$Res, BoardColumn>;
  @useResult
  $Res call({String id, String name, int position, List<TaskCard> cards});
}

/// @nodoc
class _$BoardColumnCopyWithImpl<$Res, $Val extends BoardColumn>
    implements $BoardColumnCopyWith<$Res> {
  _$BoardColumnCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BoardColumn
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? position = null,
    Object? cards = null,
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
            position: null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as int,
            cards: null == cards
                ? _value.cards
                : cards // ignore: cast_nullable_to_non_nullable
                      as List<TaskCard>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BoardColumnImplCopyWith<$Res>
    implements $BoardColumnCopyWith<$Res> {
  factory _$$BoardColumnImplCopyWith(
    _$BoardColumnImpl value,
    $Res Function(_$BoardColumnImpl) then,
  ) = __$$BoardColumnImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, int position, List<TaskCard> cards});
}

/// @nodoc
class __$$BoardColumnImplCopyWithImpl<$Res>
    extends _$BoardColumnCopyWithImpl<$Res, _$BoardColumnImpl>
    implements _$$BoardColumnImplCopyWith<$Res> {
  __$$BoardColumnImplCopyWithImpl(
    _$BoardColumnImpl _value,
    $Res Function(_$BoardColumnImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BoardColumn
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? position = null,
    Object? cards = null,
  }) {
    return _then(
      _$BoardColumnImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        position: null == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as int,
        cards: null == cards
            ? _value._cards
            : cards // ignore: cast_nullable_to_non_nullable
                  as List<TaskCard>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BoardColumnImpl implements _BoardColumn {
  const _$BoardColumnImpl({
    required this.id,
    required this.name,
    required this.position,
    final List<TaskCard> cards = const [],
  }) : _cards = cards;

  factory _$BoardColumnImpl.fromJson(Map<String, dynamic> json) =>
      _$$BoardColumnImplFromJson(json);

  /// Unique identifier for the column.
  @override
  final String id;

  /// Display name (e.g., "To Do", "In Progress", "Done").
  @override
  final String name;

  /// Zero-based position in the board (left to right).
  @override
  final int position;

  /// Cards currently in this column, ordered by position.
  final List<TaskCard> _cards;

  /// Cards currently in this column, ordered by position.
  @override
  @JsonKey()
  List<TaskCard> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @override
  String toString() {
    return 'BoardColumn(id: $id, name: $name, position: $position, cards: $cards)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoardColumnImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.position, position) ||
                other.position == position) &&
            const DeepCollectionEquality().equals(other._cards, _cards));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    position,
    const DeepCollectionEquality().hash(_cards),
  );

  /// Create a copy of BoardColumn
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BoardColumnImplCopyWith<_$BoardColumnImpl> get copyWith =>
      __$$BoardColumnImplCopyWithImpl<_$BoardColumnImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BoardColumnImplToJson(this);
  }
}

abstract class _BoardColumn implements BoardColumn {
  const factory _BoardColumn({
    required final String id,
    required final String name,
    required final int position,
    final List<TaskCard> cards,
  }) = _$BoardColumnImpl;

  factory _BoardColumn.fromJson(Map<String, dynamic> json) =
      _$BoardColumnImpl.fromJson;

  /// Unique identifier for the column.
  @override
  String get id;

  /// Display name (e.g., "To Do", "In Progress", "Done").
  @override
  String get name;

  /// Zero-based position in the board (left to right).
  @override
  int get position;

  /// Cards currently in this column, ordered by position.
  @override
  List<TaskCard> get cards;

  /// Create a copy of BoardColumn
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BoardColumnImplCopyWith<_$BoardColumnImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
