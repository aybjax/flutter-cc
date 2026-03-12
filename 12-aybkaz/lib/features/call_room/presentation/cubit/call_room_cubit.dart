import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../../settings/domain/entities/user_settings_entity.dart';
import '../../../settings/domain/usecases/get_user_settings_usecase.dart';
import '../../data/datasources/webrtc_datasource.dart';
import '../../domain/entities/call_session_entity.dart';
import '../../domain/params/join_call_params.dart';
import '../../domain/params/send_chat_message_params.dart';
import '../../domain/usecases/join_call_usecase.dart';
import '../../domain/usecases/leave_call_usecase.dart';
import '../../domain/usecases/send_chat_message_usecase.dart';
import '../../domain/usecases/toggle_camera_usecase.dart';
import '../../domain/usecases/toggle_microphone_usecase.dart';
import '../../domain/usecases/watch_call_session_usecase.dart';
import 'call_room_state.dart';

class CallRoomCubit extends Cubit<CallRoomState> {
  CallRoomCubit({
    required GetUserSettingsUseCase getUserSettingsUseCase,
    required WatchCallSessionUseCase watchCallSessionUseCase,
    required JoinCallUseCase joinCallUseCase,
    required LeaveCallUseCase leaveCallUseCase,
    required SendChatMessageUseCase sendChatMessageUseCase,
    required ToggleMicrophoneUseCase toggleMicrophoneUseCase,
    required ToggleCameraUseCase toggleCameraUseCase,
    required WebRtcDataSource webRtcDataSource,
  }) : _getUserSettingsUseCase = getUserSettingsUseCase,
       _watchCallSessionUseCase = watchCallSessionUseCase,
       _joinCallUseCase = joinCallUseCase,
       _leaveCallUseCase = leaveCallUseCase,
       _sendChatMessageUseCase = sendChatMessageUseCase,
       _toggleMicrophoneUseCase = toggleMicrophoneUseCase,
       _toggleCameraUseCase = toggleCameraUseCase,
       _webRtcDataSource = webRtcDataSource,
       super(CallRoomState.initial()) {
    _sessionSubscription = _watchCallSessionUseCase().listen(
      (session) => emit(state.copyWith(session: session, isJoining: false)),
      onError: (Object error, StackTrace stackTrace) => emit(
        state.copyWith(isJoining: false, errorMessage: error.toString()),
      ),
    );
  }

  final GetUserSettingsUseCase _getUserSettingsUseCase;
  final WatchCallSessionUseCase _watchCallSessionUseCase;
  final JoinCallUseCase _joinCallUseCase;
  final LeaveCallUseCase _leaveCallUseCase;
  final SendChatMessageUseCase _sendChatMessageUseCase;
  final ToggleMicrophoneUseCase _toggleMicrophoneUseCase;
  final ToggleCameraUseCase _toggleCameraUseCase;
  final WebRtcDataSource _webRtcDataSource;

  StreamSubscription<CallSessionEntity>? _sessionSubscription;
  bool _initialized = false;

  RTCVideoRenderer get localRenderer => _webRtcDataSource.localRenderer;

  RTCVideoRenderer get remoteRenderer => _webRtcDataSource.remoteRenderer;

  Future<void> initialize() async {
    if (_initialized) {
      return;
    }
    _initialized = true;

    emit(state.copyWith(isJoining: true, errorMessage: null));

    final settingsResult = await _getUserSettingsUseCase();
    await settingsResult.fold(
      (failure) async {
        emit(state.copyWith(isJoining: false, errorMessage: failure.message));
      },
      (settings) async {
        emit(state.copyWith(settings: settings, errorMessage: null));
        await _join(settings);
      },
    );
  }

  Future<void> retry() async {
    final settings = state.settings;
    if (settings == null) {
      emit(state.copyWith(errorMessage: 'Saved settings are unavailable.'));
      return;
    }

    emit(state.copyWith(isJoining: true, errorMessage: null));
    await _join(settings);
  }

  Future<void> sendMessage(String text) async {
    final result = await _sendChatMessageUseCase(
      SendChatMessageParams(text: text),
    );
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (_) {},
    );
  }

  Future<void> toggleMicrophone() async {
    final result = await _toggleMicrophoneUseCase();
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (_) {},
    );
  }

  Future<void> toggleCamera() async {
    final result = await _toggleCameraUseCase();
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (_) {},
    );
  }

  Future<void> leave() async {
    final result = await _leaveCallUseCase();
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (_) {},
    );
  }

  void clearError() {
    if (state.errorMessage == null) {
      return;
    }

    emit(state.copyWith(errorMessage: null));
  }

  Future<void> _join(UserSettingsEntity settings) async {
    final result = await _joinCallUseCase(
      JoinCallParams(
        displayName: settings.displayName,
        signalingUrl: settings.signalingUrl,
        startWithVideo: settings.startWithVideo,
      ),
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isJoining: false, errorMessage: failure.message)),
      (_) => emit(state.copyWith(isJoining: false, settings: settings)),
    );
  }

  @override
  Future<void> close() async {
    await _sessionSubscription?.cancel();
    await _leaveCallUseCase();
    await _webRtcDataSource.dispose();
    return super.close();
  }
}
