// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'PeerLink';

  @override
  String get homeTitle => '1x1 звонки без лишнего';

  @override
  String get homeSubtitle =>
      'Сохрани профиль, проверь signaling сервер и заходи в прямой звонок с небольшим чатом.';

  @override
  String get displayNameLabel => 'Имя';

  @override
  String get displayNameHint => 'Как тебя увидит второй участник';

  @override
  String get serverUrlLabel => 'URL signaling сервера';

  @override
  String get serverUrlHint => 'ws://localhost:3000';

  @override
  String get serverUrlHelper =>
      'Для реального телефона укажи LAN IP ноутбука. Для Android Emulator обычно нужен ws://10.0.2.2:3000.';

  @override
  String get startWithVideoLabel => 'Заходить сразу с камерой';

  @override
  String get checkServerAction => 'Проверить сервер';

  @override
  String get joinCallAction => 'Войти в звонок';

  @override
  String get serverOnline => 'Сервер доступен';

  @override
  String get serverOffline => 'Сервер не ответил';

  @override
  String get saveSuccess => 'Настройки сохранены';

  @override
  String get validationDisplayName => 'Введи имя';

  @override
  String get validationServerUrl => 'Введи URL signaling сервера';

  @override
  String get howItWorksTitle => 'Бэкенд';

  @override
  String get howItWorksBody =>
      'Сейчас приложение подключено к легкому Node signaling серверу из webrtc-test/2clients. Позже можно просто заменить URL без переделки UI.';

  @override
  String get callTitle => 'Комната звонка';

  @override
  String get callSubtitleWaiting => 'Ждем второго участника';

  @override
  String get callSubtitleConnecting => 'Подготавливаем медиа и signaling';

  @override
  String get callSubtitleNegotiating => 'Согласовываем peer connection';

  @override
  String get callSubtitleInCall => 'Звонок активен';

  @override
  String get callSubtitleDisconnected => 'Участник отключился';

  @override
  String get callSubtitleRoomFull => 'Комната уже занята';

  @override
  String get callSubtitleFailure => 'Не удалось поднять звонок';

  @override
  String get localVideoLabel => 'Ты';

  @override
  String get remoteVideoLabel => 'Собеседник';

  @override
  String get videoOffLabel => 'Камера выключена';

  @override
  String get waitingPeerLabel => 'Ожидание второго участника';

  @override
  String get chatTitle => 'Чат';

  @override
  String get chatHint => 'Напиши сообщение';

  @override
  String get sendAction => 'Отправить';

  @override
  String get muteAction => 'Выключить микрофон';

  @override
  String get unmuteAction => 'Включить микрофон';

  @override
  String get cameraOffAction => 'Выключить камеру';

  @override
  String get cameraOnAction => 'Включить камеру';

  @override
  String get leaveAction => 'Выйти';

  @override
  String get systemSender => 'Система';

  @override
  String get emptyChat => 'Сообщения появятся здесь во время звонка.';

  @override
  String get backAction => 'Назад';

  @override
  String get retryAction => 'Повторить';

  @override
  String get peerLeftMessage => 'Второй участник покинул звонок.';

  @override
  String get callEmptyMessage => 'Сначала введи сообщение.';

  @override
  String get callNoSettings => 'Не удалось загрузить настройки.';

  @override
  String get statusIdle => 'Ожидание';

  @override
  String get statusConnecting => 'Подключение';

  @override
  String get statusWaitingPeer => 'Ждем';

  @override
  String get statusNegotiating => 'Согласование';

  @override
  String get statusInCall => 'В звонке';

  @override
  String get statusDisconnected => 'Отключено';

  @override
  String get statusRoomFull => 'Комната занята';

  @override
  String get statusFailure => 'Ошибка';
}
