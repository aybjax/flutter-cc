import '../models/device_contact_model.dart';

abstract class DeviceContactsDataSource {
  Future<bool> requestPermission();
  Future<List<DeviceContactModel>> getContacts();
}
