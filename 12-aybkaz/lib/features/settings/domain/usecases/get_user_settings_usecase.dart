import 'package:dartz/dartz.dart';

import '../../../../core/error/app_failure.dart';
import '../entities/user_settings_entity.dart';
import '../repositories/settings_repository.dart';

class GetUserSettingsUseCase {
  const GetUserSettingsUseCase(this._repository);

  final SettingsRepository _repository;

  Future<Either<AppFailure, UserSettingsEntity>> call() {
    return _repository.getSettings();
  }
}
