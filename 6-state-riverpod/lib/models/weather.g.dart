// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherImpl _$$WeatherImplFromJson(Map<String, dynamic> json) =>
    _$WeatherImpl(
      cityId: json['cityId'] as String,
      temperatureCelsius: (json['temperatureCelsius'] as num).toDouble(),
      feelsLikeCelsius: (json['feelsLikeCelsius'] as num).toDouble(),
      humidity: (json['humidity'] as num).toInt(),
      windSpeedKmh: (json['windSpeedKmh'] as num).toDouble(),
      condition: $enumDecode(_$WeatherConditionEnumMap, json['condition']),
      description: json['description'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$WeatherImplToJson(_$WeatherImpl instance) =>
    <String, dynamic>{
      'cityId': instance.cityId,
      'temperatureCelsius': instance.temperatureCelsius,
      'feelsLikeCelsius': instance.feelsLikeCelsius,
      'humidity': instance.humidity,
      'windSpeedKmh': instance.windSpeedKmh,
      'condition': _$WeatherConditionEnumMap[instance.condition]!,
      'description': instance.description,
      'timestamp': instance.timestamp.toIso8601String(),
    };

const _$WeatherConditionEnumMap = {
  WeatherCondition.sunny: 'sunny',
  WeatherCondition.partlyCloudy: 'partlyCloudy',
  WeatherCondition.cloudy: 'cloudy',
  WeatherCondition.rainy: 'rainy',
  WeatherCondition.stormy: 'stormy',
  WeatherCondition.snowy: 'snowy',
  WeatherCondition.foggy: 'foggy',
};
