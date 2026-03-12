import 'package:flutter_contacts/flutter_contacts.dart';

import '../models/device_contact_model.dart';
import 'device_contacts_datasource.dart';

class DeviceContactsDataSourceImpl implements DeviceContactsDataSource {
  const DeviceContactsDataSourceImpl();

  @override
  Future<List<DeviceContactModel>> getContacts() async {
    final contacts = await FlutterContacts.getContacts(
      withProperties: true,
      withThumbnail: true,
    );

    return contacts
        .map(DeviceContactModel.fromNative)
        .where((contact) => contact.displayName.isNotEmpty)
        .toList(growable: false);
  }

  @override
  Future<bool> requestPermission() {
    return FlutterContacts.requestPermission(readonly: true);
  }
}
