import 'package:dartz/dartz.dart';

import '../../../../core/error/app_failure.dart';
import '../entities/user_settings_entity.dart';
import '../params/save_user_settings_params.dart';

abstract class SettingsRepository {
  Future<Either<AppFailure, UserSettingsEntity>> getSettings();

  Future<Either<AppFailure, Unit>> saveSettings(SaveUserSettingsParams params);

  Future<Either<AppFailure, bool>> probeServer(String signalingUrl);
}
