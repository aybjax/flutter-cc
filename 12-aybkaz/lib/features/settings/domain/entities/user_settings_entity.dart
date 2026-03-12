import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_settings_entity.freezed.dart';

@freezed
abstract class UserSettingsEntity with _$UserSettingsEntity {
  const factory UserSettingsEntity({
    @Default('Guest') String displayName,
    @Default('ws://localhost:3000') String signalingUrl,
    @Default(true) bool startWithVideo,
  }) = _UserSettingsEntity;
}
