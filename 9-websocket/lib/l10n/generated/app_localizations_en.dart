// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Live Chat';

  @override
  String get enterUsername => 'Enter your username';

  @override
  String get usernameHint => 'Username';

  @override
  String get joinChat => 'Join Chat';

  @override
  String get chatRooms => 'Chat Rooms';

  @override
  String get onlineUsers => 'Online Users';

  @override
  String get typeMessage => 'Type a message...';

  @override
  String get send => 'Send';

  @override
  String typing(String user) {
    return '$user is typing...';
  }

  @override
  String userJoined(String user) {
    return '$user joined the room';
  }

  @override
  String userLeft(String user) {
    return '$user left the room';
  }

  @override
  String get connecting => 'Connecting...';

  @override
  String get connected => 'Connected';

  @override
  String get disconnected => 'Disconnected';

  @override
  String get reconnecting => 'Reconnecting...';

  @override
  String get usernameRequired => 'Username is required';

  @override
  String members(int count) {
    return '$count members';
  }
}
