// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Tutorial de Arquitectura';

  @override
  String get login => 'Iniciar Sesion';

  @override
  String get register => 'Registrarse';

  @override
  String get email => 'Correo electronico';

  @override
  String get password => 'Contrasena';

  @override
  String get todos => 'Tareas';

  @override
  String get addTodo => 'Agregar Tarea';

  @override
  String get editTodo => 'Editar Tarea';

  @override
  String get title => 'Titulo';

  @override
  String get description => 'Descripcion';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Eliminar';

  @override
  String get logout => 'Cerrar Sesion';

  @override
  String get noTodos => 'No hay tareas aun. Agrega una!';

  @override
  String get confirmDelete =>
      'Estas seguro de que quieres eliminar esta tarea?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get errorOccurred => 'Ocurrio un error';

  @override
  String get networkError => 'Error de red. Por favor verifica tu conexion.';

  @override
  String get noAccount => 'No tienes cuenta? Registrate';

  @override
  String get hasAccount => 'Ya tienes cuenta? Inicia Sesion';

  @override
  String todoCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tareas',
      one: '1 tarea',
      zero: 'Sin tareas',
    );
    return '$_temp0';
  }
}
