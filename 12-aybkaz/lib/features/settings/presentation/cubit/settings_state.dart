import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user_settings_entity.dart';

part 'settings_state.freezed.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(UserSettingsEntity()) UserSettingsEntity settings,
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isCheckingServer,
    bool? serverReachable,
    String? errorMessage,
  }) = _SettingsState;

  factory SettingsState.initial() => const SettingsState(isLoading: true);
}
