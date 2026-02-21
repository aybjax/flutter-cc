// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Todo App';

  @override
  String todosCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count todos',
      one: '1 todo',
      zero: 'No todos',
    );
    return '$_temp0';
  }

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get logout => 'Logout';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get noAccount => 'Don\'t have an account? Register';

  @override
  String get hasAccount => 'Already have an account? Login';

  @override
  String get addTodo => 'Add Todo';

  @override
  String get editTodo => 'Edit Todo';

  @override
  String get deleteTodo => 'Delete Todo';

  @override
  String confirmDelete(String title) {
    return 'Are you sure you want to delete \"$title\"?';
  }

  @override
  String get title => 'Title';

  @override
  String get description => 'Description';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get noTodosYet => 'No todos yet. Tap + to add one!';

  @override
  String get todoSaved => 'Todo saved successfully!';

  @override
  String get todoDeleted => 'Todo deleted';

  @override
  String get errorRequired => 'This field is required';

  @override
  String get errorInvalidEmail => 'Please enter a valid email';

  @override
  String get errorNetwork => 'Network error. Please check your connection.';

  @override
  String get errorServer => 'Server error. Please try again later.';

  @override
  String get errorUnauthorized => 'Session expired. Please login again.';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get retry => 'Retry';

  @override
  String get loading => 'Loading...';

  @override
  String get todoDetail => 'Todo Detail';

  @override
  String get checked => 'Completed';

  @override
  String get unchecked => 'Pending';
}
