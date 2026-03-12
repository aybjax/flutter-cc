import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/url_utils.dart';
import '../../domain/entities/user_settings_entity.dart';
import '../../domain/params/save_user_settings_params.dart';
import '../../domain/usecases/get_user_settings_usecase.dart';
import '../../domain/usecases/probe_server_usecase.dart';
import '../../domain/usecases/save_user_settings_usecase.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    required GetUserSettingsUseCase getUserSettingsUseCase,
    required SaveUserSettingsUseCase saveUserSettingsUseCase,
    required ProbeServerUseCase probeServerUseCase,
  }) : _getUserSettingsUseCase = getUserSettingsUseCase,
       _saveUserSettingsUseCase = saveUserSettingsUseCase,
       _probeServerUseCase = probeServerUseCase,
       super(SettingsState.initial());

  final GetUserSettingsUseCase _getUserSettingsUseCase;
  final SaveUserSettingsUseCase _saveUserSettingsUseCase;
  final ProbeServerUseCase _probeServerUseCase;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getUserSettingsUseCase();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (settings) => emit(
        state.copyWith(
          isLoading: false,
          settings: settings,
          errorMessage: null,
        ),
      ),
    );
  }

  Future<bool> saveSettings({
    required String displayName,
    required String signalingUrl,
    required bool startWithVideo,
  }) async {
    final validated = _validate(
      displayName: displayName,
      signalingUrl: signalingUrl,
      startWithVideo: startWithVideo,
    );

    if (validated == null) {
      return false;
    }

    emit(
      state.copyWith(isSaving: true, errorMessage: null, settings: validated),
    );

    final result = await _saveUserSettingsUseCase(
      SaveUserSettingsParams(
        displayName: validated.displayName,
        signalingUrl: validated.signalingUrl,
        startWithVideo: validated.startWithVideo,
      ),
    );

    return result.fold(
      (failure) {
        emit(state.copyWith(isSaving: false, errorMessage: failure.message));
        return false;
      },
      (_) {
        emit(state.copyWith(isSaving: false, settings: validated));
        return true;
      },
    );
  }

  Future<void> checkServer(String signalingUrl) async {
    final normalizedUrl = normalizeSocketUrl(signalingUrl);

    if (normalizedUrl.isEmpty) {
      emit(state.copyWith(errorMessage: 'Signaling server URL is required.'));
      return;
    }

    emit(
      state.copyWith(
        isCheckingServer: true,
        errorMessage: null,
        serverReachable: null,
      ),
    );

    final result = await _probeServerUseCase(normalizedUrl);
    result.fold(
      (failure) => emit(
        state.copyWith(
          isCheckingServer: false,
          errorMessage: failure.message,
          serverReachable: false,
        ),
      ),
      (isReachable) => emit(
        state.copyWith(isCheckingServer: false, serverReachable: isReachable),
      ),
    );
  }

  void clearError() {
    if (state.errorMessage == null) {
      return;
    }

    emit(state.copyWith(errorMessage: null));
  }

  UserSettingsEntity? _validate({
    required String displayName,
    required String signalingUrl,
    required bool startWithVideo,
  }) {
    final trimmedDisplayName = displayName.trim();
    final normalizedUrl = normalizeSocketUrl(signalingUrl);

    if (trimmedDisplayName.isEmpty) {
      emit(state.copyWith(errorMessage: 'Display name is required.'));
      return null;
    }

    if (normalizedUrl.isEmpty) {
      emit(state.copyWith(errorMessage: 'Signaling server URL is required.'));
      return null;
    }

    return UserSettingsEntity(
      displayName: trimmedDisplayName,
      signalingUrl: normalizedUrl,
      startWithVideo: startWithVideo,
    );
  }
}
