// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return _Weather.fromJson(json);
}

/// @nodoc
mixin _$Weather {
  /// The city ID this weather belongs to.
  String get cityId => throw _privateConstructorUsedError;

  /// Temperature in Celsius.
  double get temperatureCelsius => throw _privateConstructorUsedError;

  /// "Feels like" temperature in Celsius.
  double get feelsLikeCelsius => throw _privateConstructorUsedError;

  /// Relative humidity as a percentage (0-100).
  int get humidity => throw _privateConstructorUsedError;

  /// Wind speed in km/h.
  double get windSpeedKmh => throw _privateConstructorUsedError;

  /// General weather condition.
  WeatherCondition get condition => throw _privateConstructorUsedError;

  /// Short human-readable description (e.g. "Partly cloudy").
  String get description => throw _privateConstructorUsedError;

  /// Timestamp when this data was "fetched".
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this Weather to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Weather
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeatherCopyWith<Weather> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherCopyWith<$Res> {
  factory $WeatherCopyWith(Weather value, $Res Function(Weather) then) =
      _$WeatherCopyWithImpl<$Res, Weather>;
  @useResult
  $Res call({
    String cityId,
    double temperatureCelsius,
    double feelsLikeCelsius,
    int humidity,
    double windSpeedKmh,
    WeatherCondition condition,
    String description,
    DateTime timestamp,
  });
}

/// @nodoc
class _$WeatherCopyWithImpl<$Res, $Val extends Weather>
    implements $WeatherCopyWith<$Res> {
  _$WeatherCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Weather
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cityId = null,
    Object? temperatureCelsius = null,
    Object? feelsLikeCelsius = null,
    Object? humidity = null,
    Object? windSpeedKmh = null,
    Object? condition = null,
    Object? description = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            cityId: null == cityId
                ? _value.cityId
                : cityId // ignore: cast_nullable_to_non_nullable
                      as String,
            temperatureCelsius: null == temperatureCelsius
                ? _value.temperatureCelsius
                : temperatureCelsius // ignore: cast_nullable_to_non_nullable
                      as double,
            feelsLikeCelsius: null == feelsLikeCelsius
                ? _value.feelsLikeCelsius
                : feelsLikeCelsius // ignore: cast_nullable_to_non_nullable
                      as double,
            humidity: null == humidity
                ? _value.humidity
                : humidity // ignore: cast_nullable_to_non_nullable
                      as int,
            windSpeedKmh: null == windSpeedKmh
                ? _value.windSpeedKmh
                : windSpeedKmh // ignore: cast_nullable_to_non_nullable
                      as double,
            condition: null == condition
                ? _value.condition
                : condition // ignore: cast_nullable_to_non_nullable
                      as WeatherCondition,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WeatherImplCopyWith<$Res> implements $WeatherCopyWith<$Res> {
  factory _$$WeatherImplCopyWith(
    _$WeatherImpl value,
    $Res Function(_$WeatherImpl) then,
  ) = __$$WeatherImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String cityId,
    double temperatureCelsius,
    double feelsLikeCelsius,
    int humidity,
    double windSpeedKmh,
    WeatherCondition condition,
    String description,
    DateTime timestamp,
  });
}

/// @nodoc
class __$$WeatherImplCopyWithImpl<$Res>
    extends _$WeatherCopyWithImpl<$Res, _$WeatherImpl>
    implements _$$WeatherImplCopyWith<$Res> {
  __$$WeatherImplCopyWithImpl(
    _$WeatherImpl _value,
    $Res Function(_$WeatherImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Weather
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cityId = null,
    Object? temperatureCelsius = null,
    Object? feelsLikeCelsius = null,
    Object? humidity = null,
    Object? windSpeedKmh = null,
    Object? condition = null,
    Object? description = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$WeatherImpl(
        cityId: null == cityId
            ? _value.cityId
            : cityId // ignore: cast_nullable_to_non_nullable
                  as String,
        temperatureCelsius: null == temperatureCelsius
            ? _value.temperatureCelsius
            : temperatureCelsius // ignore: cast_nullable_to_non_nullable
                  as double,
        feelsLikeCelsius: null == feelsLikeCelsius
            ? _value.feelsLikeCelsius
            : feelsLikeCelsius // ignore: cast_nullable_to_non_nullable
                  as double,
        humidity: null == humidity
            ? _value.humidity
            : humidity // ignore: cast_nullable_to_non_nullable
                  as int,
        windSpeedKmh: null == windSpeedKmh
            ? _value.windSpeedKmh
            : windSpeedKmh // ignore: cast_nullable_to_non_nullable
                  as double,
        condition: null == condition
            ? _value.condition
            : condition // ignore: cast_nullable_to_non_nullable
                  as WeatherCondition,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WeatherImpl implements _Weather {
  const _$WeatherImpl({
    required this.cityId,
    required this.temperatureCelsius,
    required this.feelsLikeCelsius,
    required this.humidity,
    required this.windSpeedKmh,
    required this.condition,
    required this.description,
    required this.timestamp,
  });

  factory _$WeatherImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeatherImplFromJson(json);

  /// The city ID this weather belongs to.
  @override
  final String cityId;

  /// Temperature in Celsius.
  @override
  final double temperatureCelsius;

  /// "Feels like" temperature in Celsius.
  @override
  final double feelsLikeCelsius;

  /// Relative humidity as a percentage (0-100).
  @override
  final int humidity;

  /// Wind speed in km/h.
  @override
  final double windSpeedKmh;

  /// General weather condition.
  @override
  final WeatherCondition condition;

  /// Short human-readable description (e.g. "Partly cloudy").
  @override
  final String description;

  /// Timestamp when this data was "fetched".
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'Weather(cityId: $cityId, temperatureCelsius: $temperatureCelsius, feelsLikeCelsius: $feelsLikeCelsius, humidity: $humidity, windSpeedKmh: $windSpeedKmh, condition: $condition, description: $description, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherImpl &&
            (identical(other.cityId, cityId) || other.cityId == cityId) &&
            (identical(other.temperatureCelsius, temperatureCelsius) ||
                other.temperatureCelsius == temperatureCelsius) &&
            (identical(other.feelsLikeCelsius, feelsLikeCelsius) ||
                other.feelsLikeCelsius == feelsLikeCelsius) &&
            (identical(other.humidity, humidity) ||
                other.humidity == humidity) &&
            (identical(other.windSpeedKmh, windSpeedKmh) ||
                other.windSpeedKmh == windSpeedKmh) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    cityId,
    temperatureCelsius,
    feelsLikeCelsius,
    humidity,
    windSpeedKmh,
    condition,
    description,
    timestamp,
  );

  /// Create a copy of Weather
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherImplCopyWith<_$WeatherImpl> get copyWith =>
      __$$WeatherImplCopyWithImpl<_$WeatherImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeatherImplToJson(this);
  }
}

abstract class _Weather implements Weather {
  const factory _Weather({
    required final String cityId,
    required final double temperatureCelsius,
    required final double feelsLikeCelsius,
    required final int humidity,
    required final double windSpeedKmh,
    required final WeatherCondition condition,
    required final String description,
    required final DateTime timestamp,
  }) = _$WeatherImpl;

  factory _Weather.fromJson(Map<String, dynamic> json) = _$WeatherImpl.fromJson;

  /// The city ID this weather belongs to.
  @override
  String get cityId;

  /// Temperature in Celsius.
  @override
  double get temperatureCelsius;

  /// "Feels like" temperature in Celsius.
  @override
  double get feelsLikeCelsius;

  /// Relative humidity as a percentage (0-100).
  @override
  int get humidity;

  /// Wind speed in km/h.
  @override
  double get windSpeedKmh;

  /// General weather condition.
  @override
  WeatherCondition get condition;

  /// Short human-readable description (e.g. "Partly cloudy").
  @override
  String get description;

  /// Timestamp when this data was "fetched".
  @override
  DateTime get timestamp;

  /// Create a copy of Weather
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeatherImplCopyWith<_$WeatherImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
