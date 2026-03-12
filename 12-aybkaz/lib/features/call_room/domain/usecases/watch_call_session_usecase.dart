import '../entities/call_session_entity.dart';
import '../repositories/call_room_repository.dart';

class WatchCallSessionUseCase {
  const WatchCallSessionUseCase(this._repository);

  final CallRoomRepository _repository;

  Stream<CallSessionEntity> call() {
    return _repository.watchSession();
  }
}
