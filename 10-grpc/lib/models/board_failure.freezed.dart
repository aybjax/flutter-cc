// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'board_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BoardFailure {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) connectionError,
    required TResult Function(String message) notFound,
    required TResult Function(String message) invalidArgument,
    required TResult Function(String message) serverError,
    required TResult Function(String message) unexpected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? connectionError,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? invalidArgument,
    TResult? Function(String message)? serverError,
    TResult? Function(String message)? unexpected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? connectionError,
    TResult Function(String message)? notFound,
    TResult Function(String message)? invalidArgument,
    TResult Function(String message)? serverError,
    TResult Function(String message)? unexpected,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ConnectionError value) connectionError,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_InvalidArgument value) invalidArgument,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(_Unexpected value) unexpected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ConnectionError value)? connectionError,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_InvalidArgument value)? invalidArgument,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(_Unexpected value)? unexpected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ConnectionError value)? connectionError,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_InvalidArgument value)? invalidArgument,
    TResult Function(_ServerError value)? serverError,
    TResult Function(_Unexpected value)? unexpected,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of BoardFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BoardFailureCopyWith<BoardFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoardFailureCopyWith<$Res> {
  factory $BoardFailureCopyWith(
    BoardFailure value,
    $Res Function(BoardFailure) then,
  ) = _$BoardFailureCopyWithImpl<$Res, BoardFailure>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$BoardFailureCopyWithImpl<$Res, $Val extends BoardFailure>
    implements $BoardFailureCopyWith<$Res> {
  _$BoardFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BoardFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConnectionErrorImplCopyWith<$Res>
    implements $BoardFailureCopyWith<$Res> {
  factory _$$ConnectionErrorImplCopyWith(
    _$ConnectionErrorImpl value,
    $Res Function(_$ConnectionErrorImpl) then,
  ) = __$$ConnectionErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ConnectionErrorImplCopyWithImpl<$Res>
    extends _$BoardFailureCopyWithImpl<$Res, _$ConnectionErrorImpl>
    implements _$$ConnectionErrorImplCopyWith<$Res> {
  __$$ConnectionErrorImplCopyWithImpl(
    _$ConnectionErrorImpl _value,
    $Res Function(_$ConnectionErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BoardFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ConnectionErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ConnectionErrorImpl implements _ConnectionError {
  const _$ConnectionErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'BoardFailure.connectionError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of BoardFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionErrorImplCopyWith<_$ConnectionErrorImpl> get copyWith =>
      __$$ConnectionErrorImplCopyWithImpl<_$ConnectionErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) connectionError,
    required TResult Function(String message) notFound,
    required TResult Function(String message) invalidArgument,
    required TResult Function(String message) serverError,
    required TResult Function(String message) unexpected,
  }) {
    return connectionError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? connectionError,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? invalidArgument,
    TResult? Function(String message)? serverError,
    TResult? Function(String message)? unexpected,
  }) {
    return connectionError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? connectionError,
    TResult Function(String message)? notFound,
    TResult Function(String message)? invalidArgument,
    TResult Function(String message)? serverError,
    TResult Function(String message)? unexpected,
    required TResult orElse(),
  }) {
    if (connectionError != null) {
      return connectionError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ConnectionError value) connectionError,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_InvalidArgument value) invalidArgument,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(_Unexpected value) unexpected,
  }) {
    return connectionError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ConnectionError value)? connectionError,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_InvalidArgument value)? invalidArgument,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(_Unexpected value)? unexpected,
  }) {
    return connectionError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ConnectionError value)? connectionError,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_InvalidArgument value)? invalidArgument,
    TResult Function(_ServerError value)? serverError,
    TResult Function(_Unexpected value)? unexpected,
    required TResult orElse(),
  }) {
    if (connectionError != null) {
      return connectionError(this);
    }
    return orElse();
  }
}

abstract class _ConnectionError implements BoardFailure {
  const factory _ConnectionError(final String message) = _$ConnectionErrorImpl;

  @override
  String get message;

  /// Create a copy of BoardFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionErrorImplCopyWith<_$ConnectionErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NotFoundImplCopyWith<$Res>
    implements $BoardFailureCopyWith<$Res> {
  factory _$$NotFoundImplCopyWith(
    _$NotFoundImpl value,
    $Res Function(_$NotFoundImpl) then,
  ) = __$$NotFoundImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$NotFoundImplCopyWithImpl<$Res>
    extends _$BoardFailureCopyWithImpl<$Res, _$NotFoundImpl>
    implements _$$NotFoundImplCopyWith<$Res> {
  __$$NotFoundImplCopyWithImpl(
    _$NotFoundImpl _value,
    $Res Function(_$NotFoundImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BoardFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$NotFoundImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$NotFoundImpl implements _NotFound {
  const _$NotFoundImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'BoardFailure.notFound(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotFoundImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of BoardFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotFoundImplCopyWith<_$NotFoundImpl> get copyWith =>
      __$$NotFoundImplCopyWithImpl<_$NotFoundImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) connectionError,
    required TResult Function(String message) notFound,
    required TResult Function(String message) invalidArgument,
    required TResult Function(String message) serverError,
    required TResult Function(String message) unexpected,
  }) {
    return notFound(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? connectionError,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? invalidArgument,
    TResult? Function(String message)? serverError,
    TResult? Function(String message)? unexpected,
  }) {
    return notFound?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? connectionError,
    TResult Function(String message)? notFound,
    TResult Function(String message)? invalidArgument,
    TResult Function(String message)? serverError,
    TResult Function(String message)? unexpected,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ConnectionError value) connectionError,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_InvalidArgument value) invalidArgument,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(_Unexpected value) unexpected,
  }) {
    return notFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ConnectionError value)? connectionError,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_InvalidArgument value)? invalidArgument,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(_Unexpected value)? unexpected,
  }) {
    return notFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ConnectionError value)? connectionError,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_InvalidArgument value)? invalidArgument,
    TResult Function(_ServerError value)? serverError,
    TResult Function(_Unexpected value)? unexpected,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(this);
    }
    return orElse();
  }
}

abstract class _NotFound implements BoardFailure {
  const factory _NotFound(final String message) = _$NotFoundImpl;

  @override
  String get message;

  /// Create a copy of BoardFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotFoundImplCopyWith<_$NotFoundImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InvalidArgumentImplCopyWith<$Res>
    implements $BoardFailureCopyWith<$Res> {
  factory _$$InvalidArgumentImplCopyWith(
    _$InvalidArgumentImpl value,
    $Res Function(_$InvalidArgumentImpl) then,
  ) = __$$InvalidArgumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$InvalidArgumentImplCopyWithImpl<$Res>
    extends _$BoardFailureCopyWithImpl<$Res, _$InvalidArgumentImpl>
    implements _$$InvalidArgumentImplCopyWith<$Res> {
  __$$InvalidArgumentImplCopyWithImpl(
    _$InvalidArgumentImpl _value,
    $Res Function(_$InvalidArgumentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BoardFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$InvalidArgumentImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$InvalidArgumentImpl implements _InvalidArgument {
  const _$InvalidArgumentImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'BoardFailure.invalidArgument(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvalidArgumentImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of BoardFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvalidArgumentImplCopyWith<_$InvalidArgumentImpl> get copyWith =>
      __$$InvalidArgumentImplCopyWithImpl<_$InvalidArgumentImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) connectionError,
    required TResult Function(String message) notFound,
    required TResult Function(String message) invalidArgument,
    required TResult Function(String message) serverError,
    required TResult Function(String message) unexpected,
  }) {
    return invalidArgument(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? connectionError,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? invalidArgument,
    TResult? Function(String message)? serverError,
    TResult? Function(String message)? unexpected,
  }) {
    return invalidArgument?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? connectionError,
    TResult Function(String message)? notFound,
    TResult Function(String message)? invalidArgument,
    TResult Function(String message)? serverError,
    TResult Function(String message)? unexpected,
    required TResult orElse(),
  }) {
    if (invalidArgument != null) {
      return invalidArgument(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ConnectionError value) connectionError,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_InvalidArgument value) invalidArgument,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(_Unexpected value) unexpected,
  }) {
    return invalidArgument(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ConnectionError value)? connectionError,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_InvalidArgument value)? invalidArgument,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(_Unexpected value)? unexpected,
  }) {
    return invalidArgument?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ConnectionError value)? connectionError,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_InvalidArgument value)? invalidArgument,
    TResult Function(_ServerError value)? serverError,
    TResult Function(_Unexpected value)? unexpected,
    required TResult orElse(),
  }) {
    if (invalidArgument != null) {
      return invalidArgument(this);
    }
    return orElse();
  }
}

abstract class _InvalidArgument implements BoardFailure {
  const factory _InvalidArgument(final String message) = _$InvalidArgumentImpl;

  @override
  String get message;

  /// Create a copy of BoardFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvalidArgumentImplCopyWith<_$InvalidArgumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ServerErrorImplCopyWith<$Res>
    implements $BoardFailureCopyWith<$Res> {
  factory _$$ServerErrorImplCopyWith(
    _$ServerErrorImpl value,
    $Res Function(_$ServerErrorImpl) then,
  ) = __$$ServerErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ServerErrorImplCopyWithImpl<$Res>
    extends _$BoardFailureCopyWithImpl<$Res, _$ServerErrorImpl>
    implements _$$ServerErrorImplCopyWith<$Res> {
  __$$ServerErrorImplCopyWithImpl(
    _$ServerErrorImpl _value,
    $Res Function(_$ServerErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BoardFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ServerErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ServerErrorImpl implements _ServerError {
  const _$ServerErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'BoardFailure.serverError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of BoardFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerErrorImplCopyWith<_$ServerErrorImpl> get copyWith =>
      __$$ServerErrorImplCopyWithImpl<_$ServerErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) connectionError,
    required TResult Function(String message) notFound,
    required TResult Function(String message) invalidArgument,
    required TResult Function(String message) serverError,
    required TResult Function(String message) unexpected,
  }) {
    return serverError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? connectionError,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? invalidArgument,
    TResult? Function(String message)? serverError,
    TResult? Function(String message)? unexpected,
  }) {
    return serverError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? connectionError,
    TResult Function(String message)? notFound,
    TResult Function(String message)? invalidArgument,
    TResult Function(String message)? serverError,
    TResult Function(String message)? unexpected,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ConnectionError value) connectionError,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_InvalidArgument value) invalidArgument,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(_Unexpected value) unexpected,
  }) {
    return serverError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ConnectionError value)? connectionError,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_InvalidArgument value)? invalidArgument,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(_Unexpected value)? unexpected,
  }) {
    return serverError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ConnectionError value)? connectionError,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_InvalidArgument value)? invalidArgument,
    TResult Function(_ServerError value)? serverError,
    TResult Function(_Unexpected value)? unexpected,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(this);
    }
    return orElse();
  }
}

abstract class _ServerError implements BoardFailure {
  const factory _ServerError(final String message) = _$ServerErrorImpl;

  @override
  String get message;

  /// Create a copy of BoardFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerErrorImplCopyWith<_$ServerErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnexpectedImplCopyWith<$Res>
    implements $BoardFailureCopyWith<$Res> {
  factory _$$UnexpectedImplCopyWith(
    _$UnexpectedImpl value,
    $Res Function(_$UnexpectedImpl) then,
  ) = __$$UnexpectedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UnexpectedImplCopyWithImpl<$Res>
    extends _$BoardFailureCopyWithImpl<$Res, _$UnexpectedImpl>
    implements _$$UnexpectedImplCopyWith<$Res> {
  __$$UnexpectedImplCopyWithImpl(
    _$UnexpectedImpl _value,
    $Res Function(_$UnexpectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BoardFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$UnexpectedImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UnexpectedImpl implements _Unexpected {
  const _$UnexpectedImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'BoardFailure.unexpected(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnexpectedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of BoardFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnexpectedImplCopyWith<_$UnexpectedImpl> get copyWith =>
      __$$UnexpectedImplCopyWithImpl<_$UnexpectedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) connectionError,
    required TResult Function(String message) notFound,
    required TResult Function(String message) invalidArgument,
    required TResult Function(String message) serverError,
    required TResult Function(String message) unexpected,
  }) {
    return unexpected(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? connectionError,
    TResult? Function(String message)? notFound,
    TResult? Function(String message)? invalidArgument,
    TResult? Function(String message)? serverError,
    TResult? Function(String message)? unexpected,
  }) {
    return unexpected?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? connectionError,
    TResult Function(String message)? notFound,
    TResult Function(String message)? invalidArgument,
    TResult Function(String message)? serverError,
    TResult Function(String message)? unexpected,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ConnectionError value) connectionError,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_InvalidArgument value) invalidArgument,
    required TResult Function(_ServerError value) serverError,
    required TResult Function(_Unexpected value) unexpected,
  }) {
    return unexpected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ConnectionError value)? connectionError,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_InvalidArgument value)? invalidArgument,
    TResult? Function(_ServerError value)? serverError,
    TResult? Function(_Unexpected value)? unexpected,
  }) {
    return unexpected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ConnectionError value)? connectionError,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_InvalidArgument value)? invalidArgument,
    TResult Function(_ServerError value)? serverError,
    TResult Function(_Unexpected value)? unexpected,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected(this);
    }
    return orElse();
  }
}

abstract class _Unexpected implements BoardFailure {
  const factory _Unexpected(final String message) = _$UnexpectedImpl;

  @override
  String get message;

  /// Create a copy of BoardFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnexpectedImplCopyWith<_$UnexpectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
