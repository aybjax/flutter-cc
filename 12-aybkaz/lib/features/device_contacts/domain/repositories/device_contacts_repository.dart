import 'package:dartz/dartz.dart';

import '../../../../core/error/app_failure.dart';
import '../entities/device_contact_entity.dart';

abstract class DeviceContactsRepository {
  Future<Either<AppFailure, bool>> requestPermission();
  Future<Either<AppFailure, List<DeviceContactEntity>>> getContacts();
}
