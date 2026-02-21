// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TodoFailure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message, int statusCode) server,
    required TResult Function() unauthorized,
    required TResult Function(int id) notFound,
    required TResult Function(String field, String message) validation,
    required TResult Function(Object error) unexpected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message, int statusCode)? server,
    TResult? Function()? unauthorized,
    TResult? Function(int id)? notFound,
    TResult? Function(String field, String message)? validation,
    TResult? Function(Object error)? unexpected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message, int statusCode)? server,
    TResult Function()? unauthorized,
    TResult Function(int id)? notFound,
    TResult Function(String field, String message)? validation,
    TResult Function(Object error)? unexpected,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Network value) network,
    required TResult Function(_Server value) server,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_Validation value) validation,
    required TResult Function(_Unexpected value) unexpected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Network value)? network,
    TResult? Function(_Server value)? server,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_Validation value)? validation,
    TResult? Function(_Unexpected value)? unexpected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Network value)? network,
    TResult Function(_Server value)? server,
    TResult Function(_Unauthorized value)? unauthorized,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_Validation value)? validation,
    TResult Function(_Unexpected value)? unexpected,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoFailureCopyWith<$Res> {
  factory $TodoFailureCopyWith(
    TodoFailure value,
    $Res Function(TodoFailure) then,
  ) = _$TodoFailureCopyWithImpl<$Res, TodoFailure>;
}

/// @nodoc
class _$TodoFailureCopyWithImpl<$Res, $Val extends TodoFailure>
    implements $TodoFailureCopyWith<$Res> {
  _$TodoFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodoFailure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$NetworkImplCopyWith<$Res> {
  factory _$$NetworkImplCopyWith(
    _$NetworkImpl value,
    $Res Function(_$NetworkImpl) then,
  ) = __$$NetworkImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$NetworkImplCopyWithImpl<$Res>
    extends _$TodoFailureCopyWithImpl<$Res, _$NetworkImpl>
    implements _$$NetworkImplCopyWith<$Res> {
  __$$NetworkImplCopyWithImpl(
    _$NetworkImpl _value,
    $Res Function(_$NetworkImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$NetworkImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$NetworkImpl implements _Network {
  const _$NetworkImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'TodoFailure.network(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of TodoFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkImplCopyWith<_$NetworkImpl> get copyWith =>
      __$$NetworkImplCopyWithImpl<_$NetworkImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message, int statusCode) server,
    required TResult Function() unauthorized,
    required TResult Function(int id) notFound,
    required TResult Function(String field, String message) validation,
    required TResult Function(Object error) unexpected,
  }) {
    return network(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message, int statusCode)? server,
    TResult? Function()? unauthorized,
    TResult? Function(int id)? notFound,
    TResult? Function(String field, String message)? validation,
    TResult? Function(Object error)? unexpected,
  }) {
    return network?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message, int statusCode)? server,
    TResult Function()? unauthorized,
    TResult Function(int id)? notFound,
    TResult Function(String field, String message)? validation,
    TResult Function(Object error)? unexpected,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Network value) network,
    required TResult Function(_Server value) server,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_Validation value) validation,
    required TResult Function(_Unexpected value) unexpected,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Network value)? network,
    TResult? Function(_Server value)? server,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_Validation value)? validation,
    TResult? Function(_Unexpected value)? unexpected,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Network value)? network,
    TResult Function(_Server value)? server,
    TResult Function(_Unauthorized value)? unauthorized,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_Validation value)? validation,
    TResult Function(_Unexpected value)? unexpected,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class _Network implements TodoFailure {
  const factory _Network({required final String message}) = _$NetworkImpl;

  String get message;

  /// Create a copy of TodoFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkImplCopyWith<_$NetworkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ServerImplCopyWith<$Res> {
  factory _$$ServerImplCopyWith(
    _$ServerImpl value,
    $Res Function(_$ServerImpl) then,
  ) = __$$ServerImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, int statusCode});
}

/// @nodoc
class __$$ServerImplCopyWithImpl<$Res>
    extends _$TodoFailureCopyWithImpl<$Res, _$ServerImpl>
    implements _$$ServerImplCopyWith<$Res> {
  __$$ServerImplCopyWithImpl(
    _$ServerImpl _value,
    $Res Function(_$ServerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? statusCode = null}) {
    return _then(
      _$ServerImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        statusCode: null == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$ServerImpl implements _Server {
  const _$ServerImpl({required this.message, required this.statusCode});

  @override
  final String message;
  @override
  final int statusCode;

  @override
  String toString() {
    return 'TodoFailure.server(message: $message, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, statusCode);

  /// Create a copy of TodoFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerImplCopyWith<_$ServerImpl> get copyWith =>
      __$$ServerImplCopyWithImpl<_$ServerImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message, int statusCode) server,
    required TResult Function() unauthorized,
    required TResult Function(int id) notFound,
    required TResult Function(String field, String message) validation,
    required TResult Function(Object error) unexpected,
  }) {
    return server(message, statusCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message, int statusCode)? server,
    TResult? Function()? unauthorized,
    TResult? Function(int id)? notFound,
    TResult? Function(String field, String message)? validation,
    TResult? Function(Object error)? unexpected,
  }) {
    return server?.call(message, statusCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message, int statusCode)? server,
    TResult Function()? unauthorized,
    TResult Function(int id)? notFound,
    TResult Function(String field, String message)? validation,
    TResult Function(Object error)? unexpected,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(message, statusCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Network value) network,
    required TResult Function(_Server value) server,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_Validation value) validation,
    required TResult Function(_Unexpected value) unexpected,
  }) {
    return server(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Network value)? network,
    TResult? Function(_Server value)? server,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_Validation value)? validation,
    TResult? Function(_Unexpected value)? unexpected,
  }) {
    return server?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Network value)? network,
    TResult Function(_Server value)? server,
    TResult Function(_Unauthorized value)? unauthorized,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_Validation value)? validation,
    TResult Function(_Unexpected value)? unexpected,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(this);
    }
    return orElse();
  }
}

abstract class _Server implements TodoFailure {
  const factory _Server({
    required final String message,
    required final int statusCode,
  }) = _$ServerImpl;

  String get message;
  int get statusCode;

  /// Create a copy of TodoFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerImplCopyWith<_$ServerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnauthorizedImplCopyWith<$Res> {
  factory _$$UnauthorizedImplCopyWith(
    _$UnauthorizedImpl value,
    $Res Function(_$UnauthorizedImpl) then,
  ) = __$$UnauthorizedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnauthorizedImplCopyWithImpl<$Res>
    extends _$TodoFailureCopyWithImpl<$Res, _$UnauthorizedImpl>
    implements _$$UnauthorizedImplCopyWith<$Res> {
  __$$UnauthorizedImplCopyWithImpl(
    _$UnauthorizedImpl _value,
    $Res Function(_$UnauthorizedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoFailure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UnauthorizedImpl implements _Unauthorized {
  const _$UnauthorizedImpl();

  @override
  String toString() {
    return 'TodoFailure.unauthorized()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnauthorizedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message, int statusCode) server,
    required TResult Function() unauthorized,
    required TResult Function(int id) notFound,
    required TResult Function(String field, String message) validation,
    required TResult Function(Object error) unexpected,
  }) {
    return unauthorized();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message, int statusCode)? server,
    TResult? Function()? unauthorized,
    TResult? Function(int id)? notFound,
    TResult? Function(String field, String message)? validation,
    TResult? Function(Object error)? unexpected,
  }) {
    return unauthorized?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message, int statusCode)? server,
    TResult Function()? unauthorized,
    TResult Function(int id)? notFound,
    TResult Function(String field, String message)? validation,
    TResult Function(Object error)? unexpected,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Network value) network,
    required TResult Function(_Server value) server,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_Validation value) validation,
    required TResult Function(_Unexpected value) unexpected,
  }) {
    return unauthorized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Network value)? network,
    TResult? Function(_Server value)? server,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_Validation value)? validation,
    TResult? Function(_Unexpected value)? unexpected,
  }) {
    return unauthorized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Network value)? network,
    TResult Function(_Server value)? server,
    TResult Function(_Unauthorized value)? unauthorized,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_Validation value)? validation,
    TResult Function(_Unexpected value)? unexpected,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(this);
    }
    return orElse();
  }
}

abstract class _Unauthorized implements TodoFailure {
  const factory _Unauthorized() = _$UnauthorizedImpl;
}

/// @nodoc
abstract class _$$NotFoundImplCopyWith<$Res> {
  factory _$$NotFoundImplCopyWith(
    _$NotFoundImpl value,
    $Res Function(_$NotFoundImpl) then,
  ) = __$$NotFoundImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$$NotFoundImplCopyWithImpl<$Res>
    extends _$TodoFailureCopyWithImpl<$Res, _$NotFoundImpl>
    implements _$$NotFoundImplCopyWith<$Res> {
  __$$NotFoundImplCopyWithImpl(
    _$NotFoundImpl _value,
    $Res Function(_$NotFoundImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _$NotFoundImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$NotFoundImpl implements _NotFound {
  const _$NotFoundImpl({required this.id});

  @override
  final int id;

  @override
  String toString() {
    return 'TodoFailure.notFound(id: $id)';
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

  /// Create a copy of TodoFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotFoundImplCopyWith<_$NotFoundImpl> get copyWith =>
      __$$NotFoundImplCopyWithImpl<_$NotFoundImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message, int statusCode) server,
    required TResult Function() unauthorized,
    required TResult Function(int id) notFound,
    required TResult Function(String field, String message) validation,
    required TResult Function(Object error) unexpected,
  }) {
    return notFound(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message, int statusCode)? server,
    TResult? Function()? unauthorized,
    TResult? Function(int id)? notFound,
    TResult? Function(String field, String message)? validation,
    TResult? Function(Object error)? unexpected,
  }) {
    return notFound?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message, int statusCode)? server,
    TResult Function()? unauthorized,
    TResult Function(int id)? notFound,
    TResult Function(String field, String message)? validation,
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
    required TResult Function(_Network value) network,
    required TResult Function(_Server value) server,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_Validation value) validation,
    required TResult Function(_Unexpected value) unexpected,
  }) {
    return notFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Network value)? network,
    TResult? Function(_Server value)? server,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_Validation value)? validation,
    TResult? Function(_Unexpected value)? unexpected,
  }) {
    return notFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Network value)? network,
    TResult Function(_Server value)? server,
    TResult Function(_Unauthorized value)? unauthorized,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_Validation value)? validation,
    TResult Function(_Unexpected value)? unexpected,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(this);
    }
    return orElse();
  }
}

abstract class _NotFound implements TodoFailure {
  const factory _NotFound({required final int id}) = _$NotFoundImpl;

  int get id;

  /// Create a copy of TodoFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotFoundImplCopyWith<_$NotFoundImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidationImplCopyWith<$Res> {
  factory _$$ValidationImplCopyWith(
    _$ValidationImpl value,
    $Res Function(_$ValidationImpl) then,
  ) = __$$ValidationImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String field, String message});
}

/// @nodoc
class __$$ValidationImplCopyWithImpl<$Res>
    extends _$TodoFailureCopyWithImpl<$Res, _$ValidationImpl>
    implements _$$ValidationImplCopyWith<$Res> {
  __$$ValidationImplCopyWithImpl(
    _$ValidationImpl _value,
    $Res Function(_$ValidationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? field = null, Object? message = null}) {
    return _then(
      _$ValidationImpl(
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

class _$ValidationImpl implements _Validation {
  const _$ValidationImpl({required this.field, required this.message});

  @override
  final String field;
  @override
  final String message;

  @override
  String toString() {
    return 'TodoFailure.validation(field: $field, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationImpl &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field, message);

  /// Create a copy of TodoFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationImplCopyWith<_$ValidationImpl> get copyWith =>
      __$$ValidationImplCopyWithImpl<_$ValidationImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message, int statusCode) server,
    required TResult Function() unauthorized,
    required TResult Function(int id) notFound,
    required TResult Function(String field, String message) validation,
    required TResult Function(Object error) unexpected,
  }) {
    return validation(field, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message, int statusCode)? server,
    TResult? Function()? unauthorized,
    TResult? Function(int id)? notFound,
    TResult? Function(String field, String message)? validation,
    TResult? Function(Object error)? unexpected,
  }) {
    return validation?.call(field, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message, int statusCode)? server,
    TResult Function()? unauthorized,
    TResult Function(int id)? notFound,
    TResult Function(String field, String message)? validation,
    TResult Function(Object error)? unexpected,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(field, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Network value) network,
    required TResult Function(_Server value) server,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_Validation value) validation,
    required TResult Function(_Unexpected value) unexpected,
  }) {
    return validation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Network value)? network,
    TResult? Function(_Server value)? server,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_Validation value)? validation,
    TResult? Function(_Unexpected value)? unexpected,
  }) {
    return validation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Network value)? network,
    TResult Function(_Server value)? server,
    TResult Function(_Unauthorized value)? unauthorized,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_Validation value)? validation,
    TResult Function(_Unexpected value)? unexpected,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(this);
    }
    return orElse();
  }
}

abstract class _Validation implements TodoFailure {
  const factory _Validation({
    required final String field,
    required final String message,
  }) = _$ValidationImpl;

  String get field;
  String get message;

  /// Create a copy of TodoFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidationImplCopyWith<_$ValidationImpl> get copyWith =>
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
    extends _$TodoFailureCopyWithImpl<$Res, _$UnexpectedImpl>
    implements _$$UnexpectedImplCopyWith<$Res> {
  __$$UnexpectedImplCopyWithImpl(
    _$UnexpectedImpl _value,
    $Res Function(_$UnexpectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoFailure
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
    return 'TodoFailure.unexpected(error: $error)';
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

  /// Create a copy of TodoFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnexpectedImplCopyWith<_$UnexpectedImpl> get copyWith =>
      __$$UnexpectedImplCopyWithImpl<_$UnexpectedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) network,
    required TResult Function(String message, int statusCode) server,
    required TResult Function() unauthorized,
    required TResult Function(int id) notFound,
    required TResult Function(String field, String message) validation,
    required TResult Function(Object error) unexpected,
  }) {
    return unexpected(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? network,
    TResult? Function(String message, int statusCode)? server,
    TResult? Function()? unauthorized,
    TResult? Function(int id)? notFound,
    TResult? Function(String field, String message)? validation,
    TResult? Function(Object error)? unexpected,
  }) {
    return unexpected?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? network,
    TResult Function(String message, int statusCode)? server,
    TResult Function()? unauthorized,
    TResult Function(int id)? notFound,
    TResult Function(String field, String message)? validation,
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
    required TResult Function(_Network value) network,
    required TResult Function(_Server value) server,
    required TResult Function(_Unauthorized value) unauthorized,
    required TResult Function(_NotFound value) notFound,
    required TResult Function(_Validation value) validation,
    required TResult Function(_Unexpected value) unexpected,
  }) {
    return unexpected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Network value)? network,
    TResult? Function(_Server value)? server,
    TResult? Function(_Unauthorized value)? unauthorized,
    TResult? Function(_NotFound value)? notFound,
    TResult? Function(_Validation value)? validation,
    TResult? Function(_Unexpected value)? unexpected,
  }) {
    return unexpected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Network value)? network,
    TResult Function(_Server value)? server,
    TResult Function(_Unauthorized value)? unauthorized,
    TResult Function(_NotFound value)? notFound,
    TResult Function(_Validation value)? validation,
    TResult Function(_Unexpected value)? unexpected,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected(this);
    }
    return orElse();
  }
}

abstract class _Unexpected implements TodoFailure {
  const factory _Unexpected({required final Object error}) = _$UnexpectedImpl;

  Object get error;

  /// Create a copy of TodoFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnexpectedImplCopyWith<_$UnexpectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
