import 'package:dartz/dartz.dart';

import '../../../../core/error/app_failure.dart';
import '../../domain/entities/device_contact_entity.dart';
import '../../domain/repositories/device_contacts_repository.dart';
import '../datasources/device_contacts_datasource.dart';

class DeviceContactsRepositoryImpl implements DeviceContactsRepository {
  const DeviceContactsRepositoryImpl({required this.dataSource});

  final DeviceContactsDataSource dataSource;

  @override
  Future<Either<AppFailure, List<DeviceContactEntity>>> getContacts() async {
    try {
      final contacts = await dataSource.getContacts();
      return right(
        contacts.map((contact) => contact.toEntity()).toList(growable: false),
      );
    } catch (error) {
      return left(
        AppFailure.unknown(message: 'Unable to load device contacts: $error'),
      );
    }
  }

  @override
  Future<Either<AppFailure, bool>> requestPermission() async {
    try {
      final isGranted = await dataSource.requestPermission();
      return right(isGranted);
    } catch (error) {
      return left(
        AppFailure.unknown(
          message: 'Unable to request contacts permission: $error',
        ),
      );
    }
  }
}
