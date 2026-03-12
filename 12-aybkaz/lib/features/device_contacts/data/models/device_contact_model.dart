import 'dart:typed_data';

import 'package:flutter_contacts/flutter_contacts.dart';

import '../../domain/entities/device_contact_entity.dart';

class DeviceContactModel {
  const DeviceContactModel({
    required this.id,
    required this.displayName,
    required this.primaryPhone,
    required this.primaryEmail,
    required this.isFavorite,
    this.avatarBytes,
  });

  factory DeviceContactModel.fromNative(Contact contact) {
    return DeviceContactModel(
      id: contact.id,
      displayName: contact.displayName.trim(),
      primaryPhone: _resolvePrimaryPhone(contact),
      primaryEmail: _resolvePrimaryEmail(contact),
      isFavorite: contact.isStarred,
      avatarBytes: contact.photoOrThumbnail,
    );
  }

  final String id;
  final String displayName;
  final String primaryPhone;
  final String primaryEmail;
  final bool isFavorite;
  final Uint8List? avatarBytes;

  DeviceContactEntity toEntity() {
    return DeviceContactEntity(
      id: id,
      displayName: displayName,
      primaryPhone: primaryPhone,
      primaryEmail: primaryEmail,
      isFavorite: isFavorite,
      avatarBytes: avatarBytes,
    );
  }

  static String _resolvePrimaryPhone(Contact contact) {
    for (final phone in contact.phones) {
      if (phone.isPrimary && phone.number.trim().isNotEmpty) {
        return phone.number.trim();
      }
    }

    for (final phone in contact.phones) {
      if (phone.number.trim().isNotEmpty) {
        return phone.number.trim();
      }
    }

    return '';
  }

  static String _resolvePrimaryEmail(Contact contact) {
    for (final email in contact.emails) {
      if (email.isPrimary && email.address.trim().isNotEmpty) {
        return email.address.trim();
      }
    }

    for (final email in contact.emails) {
      if (email.address.trim().isNotEmpty) {
        return email.address.trim();
      }
    }

    return '';
  }
}
