import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/app_failure.dart';
import '../../domain/entities/user_settings_entity.dart';
import '../../domain/params/save_user_settings_params.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/server_probe_remote_datasource.dart';
import '../datasources/settings_local_datasource.dart';
import '../models/user_settings_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final SettingsLocalDataSource localDataSource;
  final ServerProbeRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, UserSettingsEntity>> getSettings() async {
    try {
      final dto = await localDataSource.getSettings();
      final model = UserSettingsModel.fromDto(dto);
      return right(model.toEntity());
    } catch (error) {
      return left(
        AppFailure.cache(message: 'Unable to load saved settings: $error'),
      );
    }
  }

  @override
  Future<Either<AppFailure, Unit>> saveSettings(
    SaveUserSettingsParams params,
  ) async {
    try {
      final model = UserSettingsModel(
        displayName: params.displayName,
        signalingUrl: params.signalingUrl,
        startWithVideo: params.startWithVideo,
      );
      await localDataSource.saveSettings(model.toDto());
      return right(unit);
    } catch (error) {
      return left(AppFailure.cache(message: 'Unable to save settings: $error'));
    }
  }

  @override
  Future<Either<AppFailure, bool>> probeServer(String signalingUrl) async {
    try {
      final isReachable = await remoteDataSource.probe(signalingUrl);
      return right(isReachable);
    } on DioException catch (error) {
      return left(
        AppFailure.network(message: error.message ?? 'Server is unreachable.'),
      );
    } catch (error) {
      return left(AppFailure.server(message: 'Server probe failed: $error'));
    }
  }
}
