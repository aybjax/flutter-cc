// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WeatherFailure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String cityName) cityNotFound,
    required TResult Function(String message) networkError,
    required TResult Function(int statusCode) serverError,
    required TResult Function(String message) unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName)? cityNotFound,
    TResult? Function(String message)? networkError,
    TResult? Function(int statusCode)? serverError,
    TResult? Function(String message)? unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName)? cityNotFound,
    TResult Function(String message)? networkError,
    TResult Function(int statusCode)? serverError,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CityNotFound value) cityNotFound,
    required TResult Function(NetworkError value) networkError,
    required TResult Function(ServerError value) serverError,
    required TResult Function(UnknownFailure value) unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CityNotFound value)? cityNotFound,
    TResult? Function(NetworkError value)? networkError,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(UnknownFailure value)? unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CityNotFound value)? cityNotFound,
    TResult Function(NetworkError value)? networkError,
    TResult Function(ServerError value)? serverError,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherFailureCopyWith<$Res> {
  factory $WeatherFailureCopyWith(
    WeatherFailure value,
    $Res Function(WeatherFailure) then,
  ) = _$WeatherFailureCopyWithImpl<$Res, WeatherFailure>;
}

/// @nodoc
class _$WeatherFailureCopyWithImpl<$Res, $Val extends WeatherFailure>
    implements $WeatherFailureCopyWith<$Res> {
  _$WeatherFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeatherFailure
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CityNotFoundImplCopyWith<$Res> {
  factory _$$CityNotFoundImplCopyWith(
    _$CityNotFoundImpl value,
    $Res Function(_$CityNotFoundImpl) then,
  ) = __$$CityNotFoundImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String cityName});
}

/// @nodoc
class __$$CityNotFoundImplCopyWithImpl<$Res>
    extends _$WeatherFailureCopyWithImpl<$Res, _$CityNotFoundImpl>
    implements _$$CityNotFoundImplCopyWith<$Res> {
  __$$CityNotFoundImplCopyWithImpl(
    _$CityNotFoundImpl _value,
    $Res Function(_$CityNotFoundImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WeatherFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? cityName = null}) {
    return _then(
      _$CityNotFoundImpl(
        cityName: null == cityName
            ? _value.cityName
            : cityName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$CityNotFoundImpl implements CityNotFound {
  const _$CityNotFoundImpl({required this.cityName});

  @override
  final String cityName;

  @override
  String toString() {
    return 'WeatherFailure.cityNotFound(cityName: $cityName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CityNotFoundImpl &&
            (identical(other.cityName, cityName) ||
                other.cityName == cityName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cityName);

  /// Create a copy of WeatherFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CityNotFoundImplCopyWith<_$CityNotFoundImpl> get copyWith =>
      __$$CityNotFoundImplCopyWithImpl<_$CityNotFoundImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String cityName) cityNotFound,
    required TResult Function(String message) networkError,
    required TResult Function(int statusCode) serverError,
    required TResult Function(String message) unknown,
  }) {
    return cityNotFound(cityName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName)? cityNotFound,
    TResult? Function(String message)? networkError,
    TResult? Function(int statusCode)? serverError,
    TResult? Function(String message)? unknown,
  }) {
    return cityNotFound?.call(cityName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName)? cityNotFound,
    TResult Function(String message)? networkError,
    TResult Function(int statusCode)? serverError,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (cityNotFound != null) {
      return cityNotFound(cityName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CityNotFound value) cityNotFound,
    required TResult Function(NetworkError value) networkError,
    required TResult Function(ServerError value) serverError,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return cityNotFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CityNotFound value)? cityNotFound,
    TResult? Function(NetworkError value)? networkError,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return cityNotFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CityNotFound value)? cityNotFound,
    TResult Function(NetworkError value)? networkError,
    TResult Function(ServerError value)? serverError,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (cityNotFound != null) {
      return cityNotFound(this);
    }
    return orElse();
  }
}

abstract class CityNotFound implements WeatherFailure {
  const factory CityNotFound({required final String cityName}) =
      _$CityNotFoundImpl;

  String get cityName;

  /// Create a copy of WeatherFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CityNotFoundImplCopyWith<_$CityNotFoundImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NetworkErrorImplCopyWith<$Res> {
  factory _$$NetworkErrorImplCopyWith(
    _$NetworkErrorImpl value,
    $Res Function(_$NetworkErrorImpl) then,
  ) = __$$NetworkErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$NetworkErrorImplCopyWithImpl<$Res>
    extends _$WeatherFailureCopyWithImpl<$Res, _$NetworkErrorImpl>
    implements _$$NetworkErrorImplCopyWith<$Res> {
  __$$NetworkErrorImplCopyWithImpl(
    _$NetworkErrorImpl _value,
    $Res Function(_$NetworkErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WeatherFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$NetworkErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$NetworkErrorImpl implements NetworkError {
  const _$NetworkErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'WeatherFailure.networkError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of WeatherFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkErrorImplCopyWith<_$NetworkErrorImpl> get copyWith =>
      __$$NetworkErrorImplCopyWithImpl<_$NetworkErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String cityName) cityNotFound,
    required TResult Function(String message) networkError,
    required TResult Function(int statusCode) serverError,
    required TResult Function(String message) unknown,
  }) {
    return networkError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName)? cityNotFound,
    TResult? Function(String message)? networkError,
    TResult? Function(int statusCode)? serverError,
    TResult? Function(String message)? unknown,
  }) {
    return networkError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName)? cityNotFound,
    TResult Function(String message)? networkError,
    TResult Function(int statusCode)? serverError,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (networkError != null) {
      return networkError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CityNotFound value) cityNotFound,
    required TResult Function(NetworkError value) networkError,
    required TResult Function(ServerError value) serverError,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return networkError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CityNotFound value)? cityNotFound,
    TResult? Function(NetworkError value)? networkError,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return networkError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CityNotFound value)? cityNotFound,
    TResult Function(NetworkError value)? networkError,
    TResult Function(ServerError value)? serverError,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (networkError != null) {
      return networkError(this);
    }
    return orElse();
  }
}

abstract class NetworkError implements WeatherFailure {
  const factory NetworkError({required final String message}) =
      _$NetworkErrorImpl;

  String get message;

  /// Create a copy of WeatherFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkErrorImplCopyWith<_$NetworkErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ServerErrorImplCopyWith<$Res> {
  factory _$$ServerErrorImplCopyWith(
    _$ServerErrorImpl value,
    $Res Function(_$ServerErrorImpl) then,
  ) = __$$ServerErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int statusCode});
}

/// @nodoc
class __$$ServerErrorImplCopyWithImpl<$Res>
    extends _$WeatherFailureCopyWithImpl<$Res, _$ServerErrorImpl>
    implements _$$ServerErrorImplCopyWith<$Res> {
  __$$ServerErrorImplCopyWithImpl(
    _$ServerErrorImpl _value,
    $Res Function(_$ServerErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WeatherFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? statusCode = null}) {
    return _then(
      _$ServerErrorImpl(
        statusCode: null == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$ServerErrorImpl implements ServerError {
  const _$ServerErrorImpl({required this.statusCode});

  @override
  final int statusCode;

  @override
  String toString() {
    return 'WeatherFailure.serverError(statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerErrorImpl &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, statusCode);

  /// Create a copy of WeatherFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerErrorImplCopyWith<_$ServerErrorImpl> get copyWith =>
      __$$ServerErrorImplCopyWithImpl<_$ServerErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String cityName) cityNotFound,
    required TResult Function(String message) networkError,
    required TResult Function(int statusCode) serverError,
    required TResult Function(String message) unknown,
  }) {
    return serverError(statusCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName)? cityNotFound,
    TResult? Function(String message)? networkError,
    TResult? Function(int statusCode)? serverError,
    TResult? Function(String message)? unknown,
  }) {
    return serverError?.call(statusCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName)? cityNotFound,
    TResult Function(String message)? networkError,
    TResult Function(int statusCode)? serverError,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(statusCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CityNotFound value) cityNotFound,
    required TResult Function(NetworkError value) networkError,
    required TResult Function(ServerError value) serverError,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return serverError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CityNotFound value)? cityNotFound,
    TResult? Function(NetworkError value)? networkError,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return serverError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CityNotFound value)? cityNotFound,
    TResult Function(NetworkError value)? networkError,
    TResult Function(ServerError value)? serverError,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(this);
    }
    return orElse();
  }
}

abstract class ServerError implements WeatherFailure {
  const factory ServerError({required final int statusCode}) =
      _$ServerErrorImpl;

  int get statusCode;

  /// Create a copy of WeatherFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerErrorImplCopyWith<_$ServerErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownFailureImplCopyWith<$Res> {
  factory _$$UnknownFailureImplCopyWith(
    _$UnknownFailureImpl value,
    $Res Function(_$UnknownFailureImpl) then,
  ) = __$$UnknownFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UnknownFailureImplCopyWithImpl<$Res>
    extends _$WeatherFailureCopyWithImpl<$Res, _$UnknownFailureImpl>
    implements _$$UnknownFailureImplCopyWith<$Res> {
  __$$UnknownFailureImplCopyWithImpl(
    _$UnknownFailureImpl _value,
    $Res Function(_$UnknownFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WeatherFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$UnknownFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UnknownFailureImpl implements UnknownFailure {
  const _$UnknownFailureImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'WeatherFailure.unknown(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of WeatherFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      __$$UnknownFailureImplCopyWithImpl<_$UnknownFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String cityName) cityNotFound,
    required TResult Function(String message) networkError,
    required TResult Function(int statusCode) serverError,
    required TResult Function(String message) unknown,
  }) {
    return unknown(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName)? cityNotFound,
    TResult? Function(String message)? networkError,
    TResult? Function(int statusCode)? serverError,
    TResult? Function(String message)? unknown,
  }) {
    return unknown?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName)? cityNotFound,
    TResult Function(String message)? networkError,
    TResult Function(int statusCode)? serverError,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CityNotFound value) cityNotFound,
    required TResult Function(NetworkError value) networkError,
    required TResult Function(ServerError value) serverError,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CityNotFound value)? cityNotFound,
    TResult? Function(NetworkError value)? networkError,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CityNotFound value)? cityNotFound,
    TResult Function(NetworkError value)? networkError,
    TResult Function(ServerError value)? serverError,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class UnknownFailure implements WeatherFailure {
  const factory UnknownFailure({required final String message}) =
      _$UnknownFailureImpl;

  String get message;

  /// Create a copy of WeatherFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
