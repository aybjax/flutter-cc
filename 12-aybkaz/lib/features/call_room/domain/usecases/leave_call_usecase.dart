import 'package:dartz/dartz.dart';

import '../../../../core/error/app_failure.dart';
import '../repositories/call_room_repository.dart';

class LeaveCallUseCase {
  const LeaveCallUseCase(this._repository);

  final CallRoomRepository _repository;

  Future<Either<AppFailure, Unit>> call() {
    return _repository.leave();
  }
}
