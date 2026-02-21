// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forecast.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DailyForecast _$DailyForecastFromJson(Map<String, dynamic> json) {
  return _DailyForecast.fromJson(json);
}

/// @nodoc
mixin _$DailyForecast {
  /// The date this forecast is for.
  DateTime get date => throw _privateConstructorUsedError;

  /// High temperature in Celsius.
  double get highCelsius => throw _privateConstructorUsedError;

  /// Low temperature in Celsius.
  double get lowCelsius => throw _privateConstructorUsedError;

  /// Dominant weather condition for the day.
  WeatherCondition get condition => throw _privateConstructorUsedError;

  /// Short description (e.g. "Sunny with light breeze").
  String get description => throw _privateConstructorUsedError;

  /// Probability of precipitation as a percentage (0-100).
  int get precipitationChance => throw _privateConstructorUsedError;

  /// Serializes this DailyForecast to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyForecast
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyForecastCopyWith<DailyForecast> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyForecastCopyWith<$Res> {
  factory $DailyForecastCopyWith(
    DailyForecast value,
    $Res Function(DailyForecast) then,
  ) = _$DailyForecastCopyWithImpl<$Res, DailyForecast>;
  @useResult
  $Res call({
    DateTime date,
    double highCelsius,
    double lowCelsius,
    WeatherCondition condition,
    String description,
    int precipitationChance,
  });
}

/// @nodoc
class _$DailyForecastCopyWithImpl<$Res, $Val extends DailyForecast>
    implements $DailyForecastCopyWith<$Res> {
  _$DailyForecastCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyForecast
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? highCelsius = null,
    Object? lowCelsius = null,
    Object? condition = null,
    Object? description = null,
    Object? precipitationChance = null,
  }) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            highCelsius: null == highCelsius
                ? _value.highCelsius
                : highCelsius // ignore: cast_nullable_to_non_nullable
                      as double,
            lowCelsius: null == lowCelsius
                ? _value.lowCelsius
                : lowCelsius // ignore: cast_nullable_to_non_nullable
                      as double,
            condition: null == condition
                ? _value.condition
                : condition // ignore: cast_nullable_to_non_nullable
                      as WeatherCondition,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            precipitationChance: null == precipitationChance
                ? _value.precipitationChance
                : precipitationChance // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DailyForecastImplCopyWith<$Res>
    implements $DailyForecastCopyWith<$Res> {
  factory _$$DailyForecastImplCopyWith(
    _$DailyForecastImpl value,
    $Res Function(_$DailyForecastImpl) then,
  ) = __$$DailyForecastImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime date,
    double highCelsius,
    double lowCelsius,
    WeatherCondition condition,
    String description,
    int precipitationChance,
  });
}

/// @nodoc
class __$$DailyForecastImplCopyWithImpl<$Res>
    extends _$DailyForecastCopyWithImpl<$Res, _$DailyForecastImpl>
    implements _$$DailyForecastImplCopyWith<$Res> {
  __$$DailyForecastImplCopyWithImpl(
    _$DailyForecastImpl _value,
    $Res Function(_$DailyForecastImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DailyForecast
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? highCelsius = null,
    Object? lowCelsius = null,
    Object? condition = null,
    Object? description = null,
    Object? precipitationChance = null,
  }) {
    return _then(
      _$DailyForecastImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        highCelsius: null == highCelsius
            ? _value.highCelsius
            : highCelsius // ignore: cast_nullable_to_non_nullable
                  as double,
        lowCelsius: null == lowCelsius
            ? _value.lowCelsius
            : lowCelsius // ignore: cast_nullable_to_non_nullable
                  as double,
        condition: null == condition
            ? _value.condition
            : condition // ignore: cast_nullable_to_non_nullable
                  as WeatherCondition,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        precipitationChance: null == precipitationChance
            ? _value.precipitationChance
            : precipitationChance // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyForecastImpl implements _DailyForecast {
  const _$DailyForecastImpl({
    required this.date,
    required this.highCelsius,
    required this.lowCelsius,
    required this.condition,
    required this.description,
    required this.precipitationChance,
  });

  factory _$DailyForecastImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyForecastImplFromJson(json);

  /// The date this forecast is for.
  @override
  final DateTime date;

  /// High temperature in Celsius.
  @override
  final double highCelsius;

  /// Low temperature in Celsius.
  @override
  final double lowCelsius;

  /// Dominant weather condition for the day.
  @override
  final WeatherCondition condition;

  /// Short description (e.g. "Sunny with light breeze").
  @override
  final String description;

  /// Probability of precipitation as a percentage (0-100).
  @override
  final int precipitationChance;

  @override
  String toString() {
    return 'DailyForecast(date: $date, highCelsius: $highCelsius, lowCelsius: $lowCelsius, condition: $condition, description: $description, precipitationChance: $precipitationChance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyForecastImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.highCelsius, highCelsius) ||
                other.highCelsius == highCelsius) &&
            (identical(other.lowCelsius, lowCelsius) ||
                other.lowCelsius == lowCelsius) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.precipitationChance, precipitationChance) ||
                other.precipitationChance == precipitationChance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    highCelsius,
    lowCelsius,
    condition,
    description,
    precipitationChance,
  );

  /// Create a copy of DailyForecast
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyForecastImplCopyWith<_$DailyForecastImpl> get copyWith =>
      __$$DailyForecastImplCopyWithImpl<_$DailyForecastImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyForecastImplToJson(this);
  }
}

abstract class _DailyForecast implements DailyForecast {
  const factory _DailyForecast({
    required final DateTime date,
    required final double highCelsius,
    required final double lowCelsius,
    required final WeatherCondition condition,
    required final String description,
    required final int precipitationChance,
  }) = _$DailyForecastImpl;

  factory _DailyForecast.fromJson(Map<String, dynamic> json) =
      _$DailyForecastImpl.fromJson;

  /// The date this forecast is for.
  @override
  DateTime get date;

  /// High temperature in Celsius.
  @override
  double get highCelsius;

  /// Low temperature in Celsius.
  @override
  double get lowCelsius;

  /// Dominant weather condition for the day.
  @override
  WeatherCondition get condition;

  /// Short description (e.g. "Sunny with light breeze").
  @override
  String get description;

  /// Probability of precipitation as a percentage (0-100).
  @override
  int get precipitationChance;

  /// Create a copy of DailyForecast
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyForecastImplCopyWith<_$DailyForecastImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
