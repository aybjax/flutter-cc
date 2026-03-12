import 'package:dartz/dartz.dart';

import '../../../../core/error/app_failure.dart';
import '../params/save_user_settings_params.dart';
import '../repositories/settings_repository.dart';

class SaveUserSettingsUseCase {
  const SaveUserSettingsUseCase(this._repository);

  final SettingsRepository _repository;

  Future<Either<AppFailure, Unit>> call(SaveUserSettingsParams params) {
    return _repository.saveSettings(params);
  }
}
