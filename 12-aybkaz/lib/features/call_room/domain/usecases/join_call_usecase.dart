import 'package:dartz/dartz.dart';

import '../../../../core/error/app_failure.dart';
import '../params/join_call_params.dart';
import '../repositories/call_room_repository.dart';

class JoinCallUseCase {
  const JoinCallUseCase(this._repository);

  final CallRoomRepository _repository;

  Future<Either<AppFailure, Unit>> call(JoinCallParams params) {
    return _repository.join(params);
  }
}
