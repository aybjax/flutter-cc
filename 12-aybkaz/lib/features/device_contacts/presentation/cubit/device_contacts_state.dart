import 'package:flutter/foundation.dart';

import '../../domain/entities/device_contact_entity.dart';

@immutable
class DeviceContactsState {
  const DeviceContactsState({
    this.contacts = const [],
    this.isLoading = false,
    this.hasLoaded = false,
    this.permissionDenied = false,
    this.errorMessage,
  });

  final List<DeviceContactEntity> contacts;
  final bool isLoading;
  final bool hasLoaded;
  final bool permissionDenied;
  final String? errorMessage;

  factory DeviceContactsState.initial() => const DeviceContactsState();

  DeviceContactsState copyWith({
    List<DeviceContactEntity>? contacts,
    bool? isLoading,
    bool? hasLoaded,
    bool? permissionDenied,
    String? errorMessage,
    bool clearError = false,
  }) {
    return DeviceContactsState(
      contacts: contacts ?? this.contacts,
      isLoading: isLoading ?? this.isLoading,
      hasLoaded: hasLoaded ?? this.hasLoaded,
      permissionDenied: permissionDenied ?? this.permissionDenied,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
