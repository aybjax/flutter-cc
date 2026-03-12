import 'dart:convert';

import '../../../../core/storage/preferences_service.dart';
import '../dtos/user_settings_dto.dart';

abstract class SettingsLocalDataSource {
  Future<UserSettingsDto> getSettings();

  Future<void> saveSettings(UserSettingsDto dto);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  SettingsLocalDataSourceImpl(this._preferencesService);

  static const _settingsKey = 'peer_link_user_settings';

  final PreferencesService _preferencesService;

  @override
  Future<UserSettingsDto> getSettings() async {
    final rawValue = _preferencesService.getString(_settingsKey);

    if (rawValue == null || rawValue.isEmpty) {
      return const UserSettingsDto();
    }

    return UserSettingsDto.fromJson(
      jsonDecode(rawValue) as Map<String, dynamic>,
    );
  }

  @override
  Future<void> saveSettings(UserSettingsDto dto) async {
    final saved = await _preferencesService.setString(
      _settingsKey,
      jsonEncode(dto.toJson()),
    );

    if (!saved) {
      throw StateError('Unable to persist user settings.');
    }
  }
}
