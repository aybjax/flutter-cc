import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../settings/domain/entities/user_settings_entity.dart';
import '../../domain/entities/call_session_entity.dart';

part 'call_room_state.freezed.dart';

@freezed
abstract class CallRoomState with _$CallRoomState {
  const factory CallRoomState({
    @Default(false) bool isJoining,
    @Default(CallSessionEntity()) CallSessionEntity session,
    UserSettingsEntity? settings,
    String? errorMessage,
  }) = _CallRoomState;

  factory CallRoomState.initial() => const CallRoomState(isJoining: true);
}
