import 'package:dartz/dartz.dart';

import '../../../../core/error/app_failure.dart';
import '../entities/call_session_entity.dart';
import '../params/join_call_params.dart';
import '../params/send_chat_message_params.dart';

abstract class CallRoomRepository {
  Stream<CallSessionEntity> watchSession();

  Future<Either<AppFailure, Unit>> join(JoinCallParams params);

  Future<Either<AppFailure, Unit>> leave();

  Future<Either<AppFailure, Unit>> sendChatMessage(
    SendChatMessageParams params,
  );

  Future<Either<AppFailure, bool>> toggleMicrophone();

  Future<Either<AppFailure, bool>> toggleCamera();
}
