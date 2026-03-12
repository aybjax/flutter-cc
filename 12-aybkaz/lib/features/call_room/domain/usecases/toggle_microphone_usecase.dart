import 'package:dartz/dartz.dart';

import '../../../../core/error/app_failure.dart';
import '../repositories/call_room_repository.dart';

class ToggleMicrophoneUseCase {
  const ToggleMicrophoneUseCase(this._repository);

  final CallRoomRepository _repository;

  Future<Either<AppFailure, bool>> call() {
    return _repository.toggleMicrophone();
  }
}
