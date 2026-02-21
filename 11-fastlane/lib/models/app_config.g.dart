// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppConfigImpl _$$AppConfigImplFromJson(Map<String, dynamic> json) =>
    _$AppConfigImpl(
      appName: json['appName'] as String,
      environment: json['environment'] as String,
      apiUrl: json['apiUrl'] as String,
      version: json['version'] as String,
      buildMode: json['buildMode'] as String,
    );

Map<String, dynamic> _$$AppConfigImplToJson(_$AppConfigImpl instance) =>
    <String, dynamic>{
      'appName': instance.appName,
      'environment': instance.environment,
      'apiUrl': instance.apiUrl,
      'version': instance.version,
      'buildMode': instance.buildMode,
    };
