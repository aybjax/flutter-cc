// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ContactFailure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) notFound,
    required TResult Function(String field, String message) validationError,
    required TResult Function(String message) storageError,
    required TResult Function(Object error) unexpected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? notFound,
    TResult? Function(String field, String message)? validationError,
    TResult? Function(String message)? storageError,
    TResult? Function(Object error)? unexpected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? notFound,
    TResult Function(String field, String message)? validationError,
    TResult Function(String message)? storageError,
    TResult Function(Object error)? unexpected,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_ValidationError value) validationError,
    required TResult Function(_StorageError value) storageError,
    required TResult Function(_Unexpected value) unexpected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_ValidationError value)? validationError,
    TResult? Function(_StorageError value)? storageError,
    TResult? Function(_Unexpected value)? unexpected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NotFound value)? notFound,
    TResult Function(_ValidationError value)? validationError,
    TResult Function(_StorageError value)? storageError,
    TResult Function(_Unexpected value)? unexpected,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactFailureCopyWith<$Res> {
  factory $ContactFailureCopyWith(
    ContactFailure value,
    $Res Function(ContactFailure) then,
  ) = _$ContactFailureCopyWithImpl<$Res, ContactFailure>;
}

/// @nodoc
class _$ContactFailureCopyWithImpl<$Res, $Val extends ContactFailure>
    implements $ContactFailureCopyWith<$Res> {
  _$ContactFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContactFailure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$NotFoundImplCopyWith<$Res> {
  factory _$$NotFoundImplCopyWith(
    _$NotFoundImpl value,
    $Res Function(_$NotFoundImpl) then,
  ) = __$$NotFoundImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$NotFoundImplCopyWithImpl<$Res>
    extends _$ContactFailureCopyWithImpl<$Res, _$NotFoundImpl>
    implements _$$NotFoundImplCopyWith<$Res> {
  __$$NotFoundImplCopyWithImpl(
    _$NotFoundImpl _value,
    $Res Function(_$NotFoundImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _$NotFoundImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$NotFoundImpl implements _NotFound {
  const _$NotFoundImpl({required this.id});

  @override
  final String id;

  @override
  String toString() {
    return 'ContactFailure.notFound(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotFoundImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of ContactFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotFoundImplCopyWith<_$NotFoundImpl> get copyWith =>
      __$$NotFoundImplCopyWithImpl<_$NotFoundImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) notFound,
    required TResult Function(String field, String message) validationError,
    required TResult Function(String message) storageError,
    required TResult Function(Object error) unexpected,
  }) {
    return notFound(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? notFound,
    TResult? Function(String field, String message)? validationError,
    TResult? Function(String message)? storageError,
    TResult? Function(Object error)? unexpected,
  }) {
    return notFound?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? notFound,
    TResult Function(String field, String message)? validationError,
    TResult Function(String message)? storageError,
    TResult Function(Object error)? unexpected,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_ValidationError value) validationError,
    required TResult Function(_StorageError value) storageError,
    required TResult Function(_Unexpected value) unexpected,
  }) {
    return notFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_ValidationError value)? validationError,
    TResult? Function(_StorageError value)? storageError,
    TResult? Function(_Unexpected value)? unexpected,
  }) {
    return notFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NotFound value)? notFound,
    TResult Function(_ValidationError value)? validationError,
    TResult Function(_StorageError value)? storageError,
    TResult Function(_Unexpected value)? unexpected,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(this);
    }
    return orElse();
  }
}

abstract class _NotFound implements ContactFailure {
  const factory _NotFound({required final String id}) = _$NotFoundImpl;

  String get id;

  /// Create a copy of ContactFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotFoundImplCopyWith<_$NotFoundImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidationErrorImplCopyWith<$Res> {
  factory _$$ValidationErrorImplCopyWith(
    _$ValidationErrorImpl value,
    $Res Function(_$ValidationErrorImpl) then,
  ) = __$$ValidationErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String field, String message});
}

/// @nodoc
class __$$ValidationErrorImplCopyWithImpl<$Res>
    extends _$ContactFailureCopyWithImpl<$Res, _$ValidationErrorImpl>
    implements _$$ValidationErrorImplCopyWith<$Res> {
  __$$ValidationErrorImplCopyWithImpl(
    _$ValidationErrorImpl _value,
    $Res Function(_$ValidationErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? field = null, Object? message = null}) {
    return _then(
      _$ValidationErrorImpl(
        field: null == field
            ? _value.field
            : field // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ValidationErrorImpl implements _ValidationError {
  const _$ValidationErrorImpl({required this.field, required this.message});

  @override
  final String field;
  @override
  final String message;

  @override
  String toString() {
    return 'ContactFailure.validationError(field: $field, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationErrorImpl &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field, message);

  /// Create a copy of ContactFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationErrorImplCopyWith<_$ValidationErrorImpl> get copyWith =>
      __$$ValidationErrorImplCopyWithImpl<_$ValidationErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) notFound,
    required TResult Function(String field, String message) validationError,
    required TResult Function(String message) storageError,
    required TResult Function(Object error) unexpected,
  }) {
    return validationError(field, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? notFound,
    TResult? Function(String field, String message)? validationError,
    TResult? Function(String message)? storageError,
    TResult? Function(Object error)? unexpected,
  }) {
    return validationError?.call(field, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? notFound,
    TResult Function(String field, String message)? validationError,
    TResult Function(String message)? storageError,
    TResult Function(Object error)? unexpected,
    required TResult orElse(),
  }) {
    if (validationError != null) {
      return validationError(field, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_ValidationError value) validationError,
    required TResult Function(_StorageError value) storageError,
    required TResult Function(_Unexpected value) unexpected,
  }) {
    return validationError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_ValidationError value)? validationError,
    TResult? Function(_StorageError value)? storageError,
    TResult? Function(_Unexpected value)? unexpected,
  }) {
    return validationError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NotFound value)? notFound,
    TResult Function(_ValidationError value)? validationError,
    TResult Function(_StorageError value)? storageError,
    TResult Function(_Unexpected value)? unexpected,
    required TResult orElse(),
  }) {
    if (validationError != null) {
      return validationError(this);
    }
    return orElse();
  }
}

abstract class _ValidationError implements ContactFailure {
  const factory _ValidationError({
    required final String field,
    required final String message,
  }) = _$ValidationErrorImpl;

  String get field;
  String get message;

  /// Create a copy of ContactFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidationErrorImplCopyWith<_$ValidationErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StorageErrorImplCopyWith<$Res> {
  factory _$$StorageErrorImplCopyWith(
    _$StorageErrorImpl value,
    $Res Function(_$StorageErrorImpl) then,
  ) = __$$StorageErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$StorageErrorImplCopyWithImpl<$Res>
    extends _$ContactFailureCopyWithImpl<$Res, _$StorageErrorImpl>
    implements _$$StorageErrorImplCopyWith<$Res> {
  __$$StorageErrorImplCopyWithImpl(
    _$StorageErrorImpl _value,
    $Res Function(_$StorageErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$StorageErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$StorageErrorImpl implements _StorageError {
  const _$StorageErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'ContactFailure.storageError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StorageErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ContactFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StorageErrorImplCopyWith<_$StorageErrorImpl> get copyWith =>
      __$$StorageErrorImplCopyWithImpl<_$StorageErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) notFound,
    required TResult Function(String field, String message) validationError,
    required TResult Function(String message) storageError,
    required TResult Function(Object error) unexpected,
  }) {
    return storageError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? notFound,
    TResult? Function(String field, String message)? validationError,
    TResult? Function(String message)? storageError,
    TResult? Function(Object error)? unexpected,
  }) {
    return storageError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? notFound,
    TResult Function(String field, String message)? validationError,
    TResult Function(String message)? storageError,
    TResult Function(Object error)? unexpected,
    required TResult orElse(),
  }) {
    if (storageError != null) {
      return storageError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_ValidationError value) validationError,
    required TResult Function(_StorageError value) storageError,
    required TResult Function(_Unexpected value) unexpected,
  }) {
    return storageError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_ValidationError value)? validationError,
    TResult? Function(_StorageError value)? storageError,
    TResult? Function(_Unexpected value)? unexpected,
  }) {
    return storageError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NotFound value)? notFound,
    TResult Function(_ValidationError value)? validationError,
    TResult Function(_StorageError value)? storageError,
    TResult Function(_Unexpected value)? unexpected,
    required TResult orElse(),
  }) {
    if (storageError != null) {
      return storageError(this);
    }
    return orElse();
  }
}

abstract class _StorageError implements ContactFailure {
  const factory _StorageError({required final String message}) =
      _$StorageErrorImpl;

  String get message;

  /// Create a copy of ContactFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StorageErrorImplCopyWith<_$StorageErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnexpectedImplCopyWith<$Res> {
  factory _$$UnexpectedImplCopyWith(
    _$UnexpectedImpl value,
    $Res Function(_$UnexpectedImpl) then,
  ) = __$$UnexpectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object error});
}

/// @nodoc
class __$$UnexpectedImplCopyWithImpl<$Res>
    extends _$ContactFailureCopyWithImpl<$Res, _$UnexpectedImpl>
    implements _$$UnexpectedImplCopyWith<$Res> {
  __$$UnexpectedImplCopyWithImpl(
    _$UnexpectedImpl _value,
    $Res Function(_$UnexpectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null}) {
    return _then(_$UnexpectedImpl(error: null == error ? _value.error : error));
  }
}

/// @nodoc

class _$UnexpectedImpl implements _Unexpected {
  const _$UnexpectedImpl({required this.error});

  @override
  final Object error;

  @override
  String toString() {
    return 'ContactFailure.unexpected(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnexpectedImpl &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  /// Create a copy of ContactFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnexpectedImplCopyWith<_$UnexpectedImpl> get copyWith =>
      __$$UnexpectedImplCopyWithImpl<_$UnexpectedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) notFound,
    required TResult Function(String field, String message) validationError,
    required TResult Function(String message) storageError,
    required TResult Function(Object error) unexpected,
  }) {
    return unexpected(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? notFound,
    TResult? Function(String field, String message)? validationError,
    TResult? Function(String message)? storageError,
    TResult? Function(Object error)? unexpected,
  }) {
    return unexpected?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? notFound,
    TResult Function(String field, String message)? validationError,
    TResult Function(String message)? storageError,
    TResult Function(Object error)? unexpected,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_ValidationError value) validationError,
    required TResult Function(_StorageError value) storageError,
    required TResult Function(_Unexpected value) unexpected,
  }) {
    return unexpected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_ValidationError value)? validationError,
    TResult? Function(_StorageError value)? storageError,
    TResult? Function(_Unexpected value)? unexpected,
  }) {
    return unexpected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NotFound value)? notFound,
    TResult Function(_ValidationError value)? validationError,
    TResult Function(_StorageError value)? storageError,
    TResult Function(_Unexpected value)? unexpected,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected(this);
    }
    return orElse();
  }
}

abstract class _Unexpected implements ContactFailure {
  const factory _Unexpected({required final Object error}) = _$UnexpectedImpl;

  Object get error;

  /// Create a copy of ContactFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnexpectedImplCopyWith<_$UnexpectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
