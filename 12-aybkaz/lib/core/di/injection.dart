import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/call_room/data/datasources/call_room_signaling_datasource.dart';
import '../../features/call_room/data/datasources/webrtc_datasource.dart';
import '../../features/call_room/data/repositories/call_room_repository_impl.dart';
import '../../features/call_room/domain/repositories/call_room_repository.dart';
import '../../features/call_room/domain/usecases/join_call_usecase.dart';
import '../../features/call_room/domain/usecases/leave_call_usecase.dart';
import '../../features/call_room/domain/usecases/send_chat_message_usecase.dart';
import '../../features/call_room/domain/usecases/toggle_camera_usecase.dart';
import '../../features/call_room/domain/usecases/toggle_microphone_usecase.dart';
import '../../features/call_room/domain/usecases/watch_call_session_usecase.dart';
import '../../features/call_room/presentation/cubit/call_room_cubit.dart';
import '../../features/device_contacts/data/datasources/device_contacts_datasource.dart';
import '../../features/device_contacts/data/datasources/device_contacts_datasource_impl.dart';
import '../../features/device_contacts/data/repositories/device_contacts_repository_impl.dart';
import '../../features/device_contacts/domain/repositories/device_contacts_repository.dart';
import '../../features/device_contacts/domain/usecases/get_device_contacts_usecase.dart';
import '../../features/device_contacts/domain/usecases/request_device_contacts_permission_usecase.dart';
import '../../features/device_contacts/presentation/cubit/device_contacts_cubit.dart';
import '../../features/settings/data/datasources/server_probe_remote_datasource.dart';
import '../../features/settings/data/datasources/settings_local_datasource.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/settings/domain/usecases/get_user_settings_usecase.dart';
import '../../features/settings/domain/usecases/probe_server_usecase.dart';
import '../../features/settings/domain/usecases/save_user_settings_usecase.dart';
import '../../features/settings/presentation/cubit/settings_cubit.dart';
import '../network/app_dio_client.dart';
import '../router/app_router.dart';
import '../storage/preferences_service.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  if (getIt.isRegistered<AppRouter>()) {
    return;
  }

  final sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<PreferencesService>(
    () => PreferencesService(getIt<SharedPreferences>()),
  );
  getIt.registerLazySingleton<AppDioClient>(AppDioClient.new);
  getIt.registerLazySingleton<AppRouter>(AppRouter.new);

  getIt.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(getIt<PreferencesService>()),
  );
  getIt.registerLazySingleton<ServerProbeRemoteDataSource>(
    () => ServerProbeRemoteDataSourceImpl(getIt<AppDioClient>()),
  );
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(
      localDataSource: getIt<SettingsLocalDataSource>(),
      remoteDataSource: getIt<ServerProbeRemoteDataSource>(),
    ),
  );

  getIt.registerFactory<GetUserSettingsUseCase>(
    () => GetUserSettingsUseCase(getIt<SettingsRepository>()),
  );
  getIt.registerFactory<SaveUserSettingsUseCase>(
    () => SaveUserSettingsUseCase(getIt<SettingsRepository>()),
  );
  getIt.registerFactory<ProbeServerUseCase>(
    () => ProbeServerUseCase(getIt<SettingsRepository>()),
  );
  getIt.registerFactory<SettingsCubit>(
    () => SettingsCubit(
      getUserSettingsUseCase: getIt<GetUserSettingsUseCase>(),
      saveUserSettingsUseCase: getIt<SaveUserSettingsUseCase>(),
      probeServerUseCase: getIt<ProbeServerUseCase>(),
    ),
  );

  getIt.registerLazySingleton<DeviceContactsDataSource>(
    DeviceContactsDataSourceImpl.new,
  );
  getIt.registerLazySingleton<DeviceContactsRepository>(
    () => DeviceContactsRepositoryImpl(
      dataSource: getIt<DeviceContactsDataSource>(),
    ),
  );
  getIt.registerFactory<RequestDeviceContactsPermissionUseCase>(
    () => RequestDeviceContactsPermissionUseCase(
      getIt<DeviceContactsRepository>(),
    ),
  );
  getIt.registerFactory<GetDeviceContactsUseCase>(
    () => GetDeviceContactsUseCase(getIt<DeviceContactsRepository>()),
  );
  getIt.registerFactory<DeviceContactsCubit>(
    () => DeviceContactsCubit(
      getDeviceContactsUseCase: getIt<GetDeviceContactsUseCase>(),
      requestDeviceContactsPermissionUseCase:
          getIt<RequestDeviceContactsPermissionUseCase>(),
    ),
  );

  getIt.registerLazySingleton<CallRoomSignalingDataSource>(
    CallRoomSignalingDataSource.new,
  );
  getIt.registerLazySingleton<WebRtcDataSource>(WebRtcDataSource.new);
  getIt.registerLazySingleton<CallRoomRepository>(
    () => CallRoomRepositoryImpl(
      signalingDataSource: getIt<CallRoomSignalingDataSource>(),
      webRtcDataSource: getIt<WebRtcDataSource>(),
    ),
  );

  getIt.registerFactory<WatchCallSessionUseCase>(
    () => WatchCallSessionUseCase(getIt<CallRoomRepository>()),
  );
  getIt.registerFactory<JoinCallUseCase>(
    () => JoinCallUseCase(getIt<CallRoomRepository>()),
  );
  getIt.registerFactory<LeaveCallUseCase>(
    () => LeaveCallUseCase(getIt<CallRoomRepository>()),
  );
  getIt.registerFactory<SendChatMessageUseCase>(
    () => SendChatMessageUseCase(getIt<CallRoomRepository>()),
  );
  getIt.registerFactory<ToggleMicrophoneUseCase>(
    () => ToggleMicrophoneUseCase(getIt<CallRoomRepository>()),
  );
  getIt.registerFactory<ToggleCameraUseCase>(
    () => ToggleCameraUseCase(getIt<CallRoomRepository>()),
  );
  getIt.registerFactory<CallRoomCubit>(
    () => CallRoomCubit(
      getUserSettingsUseCase: getIt<GetUserSettingsUseCase>(),
      watchCallSessionUseCase: getIt<WatchCallSessionUseCase>(),
      joinCallUseCase: getIt<JoinCallUseCase>(),
      leaveCallUseCase: getIt<LeaveCallUseCase>(),
      sendChatMessageUseCase: getIt<SendChatMessageUseCase>(),
      toggleMicrophoneUseCase: getIt<ToggleMicrophoneUseCase>(),
      toggleCameraUseCase: getIt<ToggleCameraUseCase>(),
      webRtcDataSource: getIt<WebRtcDataSource>(),
    ),
  );
}
