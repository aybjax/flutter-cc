import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_settings_dto.freezed.dart';
part 'user_settings_dto.g.dart';

@freezed
abstract class UserSettingsDto with _$UserSettingsDto {
  const factory UserSettingsDto({
    @Default('Guest') String displayName,
    @Default('ws://localhost:3000') String signalingUrl,
    @Default(true) bool startWithVideo,
  }) = _UserSettingsDto;

  factory UserSettingsDto.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsDtoFromJson(json);
}
