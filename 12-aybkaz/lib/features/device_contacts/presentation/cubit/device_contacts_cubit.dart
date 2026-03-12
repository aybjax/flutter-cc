import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_device_contacts_usecase.dart';
import '../../domain/usecases/request_device_contacts_permission_usecase.dart';
import 'device_contacts_state.dart';

class DeviceContactsCubit extends Cubit<DeviceContactsState> {
  DeviceContactsCubit({
    required GetDeviceContactsUseCase getDeviceContactsUseCase,
    required RequestDeviceContactsPermissionUseCase
    requestDeviceContactsPermissionUseCase,
  }) : _getDeviceContactsUseCase = getDeviceContactsUseCase,
       _requestDeviceContactsPermissionUseCase =
           requestDeviceContactsPermissionUseCase,
       super(DeviceContactsState.initial());

  final GetDeviceContactsUseCase _getDeviceContactsUseCase;
  final RequestDeviceContactsPermissionUseCase
  _requestDeviceContactsPermissionUseCase;

  Future<void> loadContacts({bool force = false}) async {
    if (!force && (state.isLoading || state.hasLoaded)) {
      return;
    }

    emit(
      state.copyWith(
        isLoading: true,
        permissionDenied: false,
        clearError: true,
      ),
    );

    final permissionResult = await _requestDeviceContactsPermissionUseCase();
    final isGranted = permissionResult.fold<bool?>(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            hasLoaded: true,
            errorMessage: failure.message,
          ),
        );
        return null;
      },
      (granted) => granted,
    );

    if (isGranted == null) {
      return;
    }

    if (!isGranted) {
      emit(
        state.copyWith(
          contacts: const [],
          isLoading: false,
          hasLoaded: true,
          permissionDenied: true,
          clearError: true,
        ),
      );
      return;
    }

    final contactsResult = await _getDeviceContactsUseCase();
    contactsResult.fold(
      (failure) => emit(
        state.copyWith(
          contacts: const [],
          isLoading: false,
          hasLoaded: true,
          permissionDenied: false,
          errorMessage: failure.message,
        ),
      ),
      (contacts) => emit(
        state.copyWith(
          contacts: contacts,
          isLoading: false,
          hasLoaded: true,
          permissionDenied: false,
          clearError: true,
        ),
      ),
    );
  }
}
