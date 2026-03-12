import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user_settings_entity.dart';
import '../dtos/user_settings_dto.dart';

part 'user_settings_model.freezed.dart';

@freezed
abstract class UserSettingsModel with _$UserSettingsModel {
  const UserSettingsModel._();

  const factory UserSettingsModel({
    @Default('Guest') String displayName,
    @Default('ws://localhost:3000') String signalingUrl,
    @Default(true) bool startWithVideo,
  }) = _UserSettingsModel;

  factory UserSettingsModel.fromDto(UserSettingsDto dto) {
    return UserSettingsModel(
      displayName: dto.displayName,
      signalingUrl: dto.signalingUrl,
      startWithVideo: dto.startWithVideo,
    );
  }

  factory UserSettingsModel.fromEntity(UserSettingsEntity entity) {
    return UserSettingsModel(
      displayName: entity.displayName,
      signalingUrl: entity.signalingUrl,
      startWithVideo: entity.startWithVideo,
    );
  }

  UserSettingsEntity toEntity() {
    return UserSettingsEntity(
      displayName: displayName,
      signalingUrl: signalingUrl,
      startWithVideo: startWithVideo,
    );
  }

  UserSettingsDto toDto() {
    return UserSettingsDto(
      displayName: displayName,
      signalingUrl: signalingUrl,
      startWithVideo: startWithVideo,
    );
  }
}
