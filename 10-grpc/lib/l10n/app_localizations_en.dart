// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Task Board';

  @override
  String get boardListTitle => 'My Boards';

  @override
  String get createCard => 'Create Card';

  @override
  String get editCard => 'Edit Card';

  @override
  String get cardTitle => 'Title';

  @override
  String get cardDescription => 'Description';

  @override
  String get selectColumn => 'Column';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get deleteConfirmation => 'Are you sure you want to delete this card?';

  @override
  String get errorLoading => 'Failed to load data';

  @override
  String get retry => 'Retry';

  @override
  String get noBoards => 'No boards available';

  @override
  String get noCards => 'No cards in this column';

  @override
  String get connectionError =>
      'Connection error. Check that the server is running.';

  @override
  String get watching => 'Live';

  @override
  String get cardCreated => 'Card created';

  @override
  String get cardMoved => 'Card moved';

  @override
  String get cardDeleted => 'Card deleted';

  @override
  String get titleRequired => 'Title is required';

  @override
  String get dragToMove => 'Drag to move between columns';
}
