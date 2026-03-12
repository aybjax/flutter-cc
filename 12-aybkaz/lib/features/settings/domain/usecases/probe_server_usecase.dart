import 'package:dartz/dartz.dart';

import '../../../../core/error/app_failure.dart';
import '../repositories/settings_repository.dart';

class ProbeServerUseCase {
  const ProbeServerUseCase(this._repository);

  final SettingsRepository _repository;

  Future<Either<AppFailure, bool>> call(String signalingUrl) {
    return _repository.probeServer(signalingUrl);
  }
}
