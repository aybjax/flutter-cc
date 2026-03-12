import 'package:dartz/dartz.dart';

import '../../../../core/error/app_failure.dart';
import '../repositories/call_room_repository.dart';

class ToggleCameraUseCase {
  const ToggleCameraUseCase(this._repository);

  final CallRoomRepository _repository;

  Future<Either<AppFailure, bool>> call() {
    return _repository.toggleCamera();
  }
}
