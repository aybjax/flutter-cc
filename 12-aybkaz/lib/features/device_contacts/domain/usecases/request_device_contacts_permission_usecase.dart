import 'package:dartz/dartz.dart';

import '../../../../core/error/app_failure.dart';
import '../repositories/device_contacts_repository.dart';

class RequestDeviceContactsPermissionUseCase {
  const RequestDeviceContactsPermissionUseCase(this._repository);

  final DeviceContactsRepository _repository;

  Future<Either<AppFailure, bool>> call() {
    return _repository.requestPermission();
  }
}
