// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Chat en Vivo';

  @override
  String get enterUsername => 'Ingresa tu nombre de usuario';

  @override
  String get usernameHint => 'Nombre de usuario';

  @override
  String get joinChat => 'Unirse al Chat';

  @override
  String get chatRooms => 'Salas de Chat';

  @override
  String get onlineUsers => 'Usuarios en Linea';

  @override
  String get typeMessage => 'Escribe un mensaje...';

  @override
  String get send => 'Enviar';

  @override
  String typing(String user) {
    return '$user esta escribiendo...';
  }

  @override
  String userJoined(String user) {
    return '$user se unio a la sala';
  }

  @override
  String userLeft(String user) {
    return '$user salio de la sala';
  }

  @override
  String get connecting => 'Conectando...';

  @override
  String get connected => 'Conectado';

  @override
  String get disconnected => 'Desconectado';

  @override
  String get reconnecting => 'Reconectando...';

  @override
  String get usernameRequired => 'El nombre de usuario es obligatorio';

  @override
  String members(int count) {
    return '$count miembros';
  }
}
