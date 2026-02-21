// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyForecastImpl _$$DailyForecastImplFromJson(Map<String, dynamic> json) =>
    _$DailyForecastImpl(
      date: DateTime.parse(json['date'] as String),
      highCelsius: (json['highCelsius'] as num).toDouble(),
      lowCelsius: (json['lowCelsius'] as num).toDouble(),
      condition: $enumDecode(_$WeatherConditionEnumMap, json['condition']),
      description: json['description'] as String,
      precipitationChance: (json['precipitationChance'] as num).toInt(),
    );

Map<String, dynamic> _$$DailyForecastImplToJson(_$DailyForecastImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'highCelsius': instance.highCelsius,
      'lowCelsius': instance.lowCelsius,
      'condition': _$WeatherConditionEnumMap[instance.condition]!,
      'description': instance.description,
      'precipitationChance': instance.precipitationChance,
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
