// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserSettingsDto _$UserSettingsDtoFromJson(Map<String, dynamic> json) =>
    _UserSettingsDto(
      displayName: json['displayName'] as String? ?? 'Guest',
      signalingUrl: json['signalingUrl'] as String? ?? 'ws://localhost:3000',
      startWithVideo: json['startWithVideo'] as bool? ?? true,
    );

Map<String, dynamic> _$UserSettingsDtoToJson(_UserSettingsDto instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'signalingUrl': instance.signalingUrl,
      'startWithVideo': instance.startWithVideo,
    };
