import 'package:dartz/dartz.dart';

import '../../../../core/error/app_failure.dart';
import '../params/send_chat_message_params.dart';
import '../repositories/call_room_repository.dart';

class SendChatMessageUseCase {
  const SendChatMessageUseCase(this._repository);

  final CallRoomRepository _repository;

  Future<Either<AppFailure, Unit>> call(SendChatMessageParams params) {
    return _repository.sendChatMessage(params);
  }
}
