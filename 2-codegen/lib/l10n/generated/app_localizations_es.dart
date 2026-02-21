// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Agenda de Contactos';

  @override
  String contactsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count contactos',
      one: '1 contacto',
      zero: 'Sin contactos',
    );
    return '$_temp0';
  }

  @override
  String get addContact => 'Agregar Contacto';

  @override
  String get editContact => 'Editar Contacto';

  @override
  String get deleteContact => 'Eliminar Contacto';

  @override
  String confirmDelete(String name) {
    return '¿Estás seguro de que deseas eliminar a $name?';
  }

  @override
  String get name => 'Nombre';

  @override
  String get email => 'Correo electrónico';

  @override
  String get phone => 'Teléfono';

  @override
  String get notes => 'Notas';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get search => 'Buscar contactos...';

  @override
  String get noContactsYet => 'No hay contactos. ¡Toca + para agregar uno!';

  @override
  String get contactSaved => '¡Contacto guardado exitosamente!';

  @override
  String get contactDeleted => 'Contacto eliminado';

  @override
  String get errorRequired => 'Este campo es obligatorio';

  @override
  String get errorInvalidEmail => 'Por favor ingrese un correo válido';

  @override
  String get categoryFamily => 'Familia';

  @override
  String get categoryFriend => 'Amigo';

  @override
  String get categoryWork => 'Trabajo';

  @override
  String get categoryOther => 'Otro';

  @override
  String get language => 'Idioma';

  @override
  String get settings => 'Configuración';

  @override
  String get favorites => 'Favoritos';

  @override
  String get all => 'Todos';
}
