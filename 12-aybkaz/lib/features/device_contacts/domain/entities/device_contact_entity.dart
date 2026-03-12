import 'dart:typed_data';

class DeviceContactEntity {
  const DeviceContactEntity({
    required this.id,
    required this.displayName,
    required this.primaryPhone,
    required this.primaryEmail,
    required this.isFavorite,
    this.avatarBytes,
  });

  final String id;
  final String displayName;
  final String primaryPhone;
  final String primaryEmail;
  final bool isFavorite;
  final Uint8List? avatarBytes;

  String get firstName {
    final parts = displayName
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList(growable: false);
    if (parts.isEmpty) {
      return displayName;
    }
    return parts.first;
  }

  String get subtitle {
    if (primaryPhone.isNotEmpty) {
      return primaryPhone;
    }
    if (primaryEmail.isNotEmpty) {
      return primaryEmail;
    }
    return '';
  }

  bool matchesQuery(String query) {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) {
      return true;
    }

    return displayName.toLowerCase().contains(normalizedQuery) ||
        primaryPhone.toLowerCase().contains(normalizedQuery) ||
        primaryEmail.toLowerCase().contains(normalizedQuery);
  }
}
