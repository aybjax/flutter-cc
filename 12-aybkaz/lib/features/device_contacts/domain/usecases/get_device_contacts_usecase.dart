import 'package:dartz/dartz.dart';

import '../../../../core/error/app_failure.dart';
import '../entities/device_contact_entity.dart';
import '../repositories/device_contacts_repository.dart';

class GetDeviceContactsUseCase {
  const GetDeviceContactsUseCase(this._repository);

  final DeviceContactsRepository _repository;

  Future<Either<AppFailure, List<DeviceContactEntity>>> call() {
    return _repository.getContacts();
  }
}
