// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Architecture Tutorial';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get todos => 'Todos';

  @override
  String get addTodo => 'Add Todo';

  @override
  String get editTodo => 'Edit Todo';

  @override
  String get title => 'Title';

  @override
  String get description => 'Description';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get logout => 'Logout';

  @override
  String get noTodos => 'No todos yet. Add one!';

  @override
  String get confirmDelete => 'Are you sure you want to delete this todo?';

  @override
  String get cancel => 'Cancel';

  @override
  String get errorOccurred => 'An error occurred';

  @override
  String get networkError => 'Network error. Please check your connection.';

  @override
  String get noAccount => 'Don\'t have an account? Register';

  @override
  String get hasAccount => 'Already have an account? Login';

  @override
  String todoCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count todos',
      one: '1 todo',
      zero: 'No todos',
    );
    return '$_temp0';
  }
}
