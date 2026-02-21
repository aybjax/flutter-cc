// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TodoSummary _$TodoSummaryFromJson(Map<String, dynamic> json) {
  return _TodoSummary.fromJson(json);
}

/// @nodoc
mixin _$TodoSummary {
  /// Unique todo ID assigned by the backend.
  int get id => throw _privateConstructorUsedError;

  /// The todo's title text.
  String get title => throw _privateConstructorUsedError;

  /// Whether the todo has been completed.
  bool get checked => throw _privateConstructorUsedError;

  /// Optional thumbnail URL (for icon support).
  String? get thumbnail => throw _privateConstructorUsedError;

  /// Serializes this TodoSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TodoSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodoSummaryCopyWith<TodoSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoSummaryCopyWith<$Res> {
  factory $TodoSummaryCopyWith(
    TodoSummary value,
    $Res Function(TodoSummary) then,
  ) = _$TodoSummaryCopyWithImpl<$Res, TodoSummary>;
  @useResult
  $Res call({int id, String title, bool checked, String? thumbnail});
}

/// @nodoc
class _$TodoSummaryCopyWithImpl<$Res, $Val extends TodoSummary>
    implements $TodoSummaryCopyWith<$Res> {
  _$TodoSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodoSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? checked = null,
    Object? thumbnail = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            checked: null == checked
                ? _value.checked
                : checked // ignore: cast_nullable_to_non_nullable
                      as bool,
            thumbnail: freezed == thumbnail
                ? _value.thumbnail
                : thumbnail // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TodoSummaryImplCopyWith<$Res>
    implements $TodoSummaryCopyWith<$Res> {
  factory _$$TodoSummaryImplCopyWith(
    _$TodoSummaryImpl value,
    $Res Function(_$TodoSummaryImpl) then,
  ) = __$$TodoSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String title, bool checked, String? thumbnail});
}

/// @nodoc
class __$$TodoSummaryImplCopyWithImpl<$Res>
    extends _$TodoSummaryCopyWithImpl<$Res, _$TodoSummaryImpl>
    implements _$$TodoSummaryImplCopyWith<$Res> {
  __$$TodoSummaryImplCopyWithImpl(
    _$TodoSummaryImpl _value,
    $Res Function(_$TodoSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? checked = null,
    Object? thumbnail = freezed,
  }) {
    return _then(
      _$TodoSummaryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        checked: null == checked
            ? _value.checked
            : checked // ignore: cast_nullable_to_non_nullable
                  as bool,
        thumbnail: freezed == thumbnail
            ? _value.thumbnail
            : thumbnail // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TodoSummaryImpl implements _TodoSummary {
  const _$TodoSummaryImpl({
    required this.id,
    required this.title,
    this.checked = false,
    this.thumbnail,
  });

  factory _$TodoSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoSummaryImplFromJson(json);

  /// Unique todo ID assigned by the backend.
  @override
  final int id;

  /// The todo's title text.
  @override
  final String title;

  /// Whether the todo has been completed.
  @override
  @JsonKey()
  final bool checked;

  /// Optional thumbnail URL (for icon support).
  @override
  final String? thumbnail;

  @override
  String toString() {
    return 'TodoSummary(id: $id, title: $title, checked: $checked, thumbnail: $thumbnail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.checked, checked) || other.checked == checked) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, checked, thumbnail);

  /// Create a copy of TodoSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoSummaryImplCopyWith<_$TodoSummaryImpl> get copyWith =>
      __$$TodoSummaryImplCopyWithImpl<_$TodoSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoSummaryImplToJson(this);
  }
}

abstract class _TodoSummary implements TodoSummary {
  const factory _TodoSummary({
    required final int id,
    required final String title,
    final bool checked,
    final String? thumbnail,
  }) = _$TodoSummaryImpl;

  factory _TodoSummary.fromJson(Map<String, dynamic> json) =
      _$TodoSummaryImpl.fromJson;

  /// Unique todo ID assigned by the backend.
  @override
  int get id;

  /// The todo's title text.
  @override
  String get title;

  /// Whether the todo has been completed.
  @override
  bool get checked;

  /// Optional thumbnail URL (for icon support).
  @override
  String? get thumbnail;

  /// Create a copy of TodoSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodoSummaryImplCopyWith<_$TodoSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TodoDetail _$TodoDetailFromJson(Map<String, dynamic> json) {
  return _TodoDetail.fromJson(json);
}

/// @nodoc
mixin _$TodoDetail {
  /// Unique todo ID assigned by the backend.
  int get id => throw _privateConstructorUsedError;

  /// The owning user's ID.
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;

  /// The todo's title text.
  String get title => throw _privateConstructorUsedError;

  /// The todo's description / body text.
  String get description => throw _privateConstructorUsedError;

  /// Whether the todo has been completed.
  bool get checked => throw _privateConstructorUsedError;

  /// Optional full-size image URL.
  String? get image => throw _privateConstructorUsedError;

  /// Serializes this TodoDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TodoDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodoDetailCopyWith<TodoDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoDetailCopyWith<$Res> {
  factory $TodoDetailCopyWith(
    TodoDetail value,
    $Res Function(TodoDetail) then,
  ) = _$TodoDetailCopyWithImpl<$Res, TodoDetail>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'user_id') int userId,
    String title,
    String description,
    bool checked,
    String? image,
  });
}

/// @nodoc
class _$TodoDetailCopyWithImpl<$Res, $Val extends TodoDetail>
    implements $TodoDetailCopyWith<$Res> {
  _$TodoDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodoDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? description = null,
    Object? checked = null,
    Object? image = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            checked: null == checked
                ? _value.checked
                : checked // ignore: cast_nullable_to_non_nullable
                      as bool,
            image: freezed == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TodoDetailImplCopyWith<$Res>
    implements $TodoDetailCopyWith<$Res> {
  factory _$$TodoDetailImplCopyWith(
    _$TodoDetailImpl value,
    $Res Function(_$TodoDetailImpl) then,
  ) = __$$TodoDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'user_id') int userId,
    String title,
    String description,
    bool checked,
    String? image,
  });
}

/// @nodoc
class __$$TodoDetailImplCopyWithImpl<$Res>
    extends _$TodoDetailCopyWithImpl<$Res, _$TodoDetailImpl>
    implements _$$TodoDetailImplCopyWith<$Res> {
  __$$TodoDetailImplCopyWithImpl(
    _$TodoDetailImpl _value,
    $Res Function(_$TodoDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? description = null,
    Object? checked = null,
    Object? image = freezed,
  }) {
    return _then(
      _$TodoDetailImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        checked: null == checked
            ? _value.checked
            : checked // ignore: cast_nullable_to_non_nullable
                  as bool,
        image: freezed == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TodoDetailImpl implements _TodoDetail {
  const _$TodoDetailImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    required this.title,
    this.description = '',
    this.checked = false,
    this.image,
  });

  factory _$TodoDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoDetailImplFromJson(json);

  /// Unique todo ID assigned by the backend.
  @override
  final int id;

  /// The owning user's ID.
  @override
  @JsonKey(name: 'user_id')
  final int userId;

  /// The todo's title text.
  @override
  final String title;

  /// The todo's description / body text.
  @override
  @JsonKey()
  final String description;

  /// Whether the todo has been completed.
  @override
  @JsonKey()
  final bool checked;

  /// Optional full-size image URL.
  @override
  final String? image;

  @override
  String toString() {
    return 'TodoDetail(id: $id, userId: $userId, title: $title, description: $description, checked: $checked, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.checked, checked) || other.checked == checked) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, userId, title, description, checked, image);

  /// Create a copy of TodoDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoDetailImplCopyWith<_$TodoDetailImpl> get copyWith =>
      __$$TodoDetailImplCopyWithImpl<_$TodoDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoDetailImplToJson(this);
  }
}

abstract class _TodoDetail implements TodoDetail {
  const factory _TodoDetail({
    required final int id,
    @JsonKey(name: 'user_id') required final int userId,
    required final String title,
    final String description,
    final bool checked,
    final String? image,
  }) = _$TodoDetailImpl;

  factory _TodoDetail.fromJson(Map<String, dynamic> json) =
      _$TodoDetailImpl.fromJson;

  /// Unique todo ID assigned by the backend.
  @override
  int get id;

  /// The owning user's ID.
  @override
  @JsonKey(name: 'user_id')
  int get userId;

  /// The todo's title text.
  @override
  String get title;

  /// The todo's description / body text.
  @override
  String get description;

  /// Whether the todo has been completed.
  @override
  bool get checked;

  /// Optional full-size image URL.
  @override
  String? get image;

  /// Create a copy of TodoDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodoDetailImplCopyWith<_$TodoDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
