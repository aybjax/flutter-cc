// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Contact Book';

  @override
  String contactsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count contacts',
      one: '1 contact',
      zero: 'No contacts',
    );
    return '$_temp0';
  }

  @override
  String get addContact => 'Add Contact';

  @override
  String get editContact => 'Edit Contact';

  @override
  String get deleteContact => 'Delete Contact';

  @override
  String confirmDelete(String name) {
    return 'Are you sure you want to delete $name?';
  }

  @override
  String get name => 'Name';

  @override
  String get email => 'Email';

  @override
  String get phone => 'Phone';

  @override
  String get notes => 'Notes';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get search => 'Search contacts...';

  @override
  String get noContactsYet => 'No contacts yet. Tap + to add one!';

  @override
  String get contactSaved => 'Contact saved successfully!';

  @override
  String get contactDeleted => 'Contact deleted';

  @override
  String get errorRequired => 'This field is required';

  @override
  String get errorInvalidEmail => 'Please enter a valid email';

  @override
  String get categoryFamily => 'Family';

  @override
  String get categoryFriend => 'Friend';

  @override
  String get categoryWork => 'Work';

  @override
  String get categoryOther => 'Other';

  @override
  String get language => 'Language';

  @override
  String get settings => 'Settings';

  @override
  String get favorites => 'Favorites';

  @override
  String get all => 'All';
}
