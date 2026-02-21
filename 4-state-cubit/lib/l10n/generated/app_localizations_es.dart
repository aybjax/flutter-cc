// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Lista de Tareas';

  @override
  String todosCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tareas',
      one: '1 tarea',
      zero: 'Sin tareas',
    );
    return '$_temp0';
  }

  @override
  String get login => 'Iniciar Sesión';

  @override
  String get register => 'Registrarse';

  @override
  String get logout => 'Cerrar Sesión';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get noAccount => '¿No tienes cuenta? Regístrate';

  @override
  String get hasAccount => '¿Ya tienes cuenta? Inicia sesión';

  @override
  String get addTodo => 'Agregar Tarea';

  @override
  String get editTodo => 'Editar Tarea';

  @override
  String get deleteTodo => 'Eliminar Tarea';

  @override
  String confirmDelete(String title) {
    return '¿Estás seguro de que deseas eliminar \"$title\"?';
  }

  @override
  String get title => 'Título';

  @override
  String get description => 'Descripción';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get noTodosYet => 'No hay tareas. ¡Toca + para agregar una!';

  @override
  String get todoSaved => '¡Tarea guardada exitosamente!';

  @override
  String get todoDeleted => 'Tarea eliminada';

  @override
  String get errorRequired => 'Este campo es obligatorio';

  @override
  String get errorInvalidEmail => 'Por favor ingrese un correo válido';

  @override
  String get errorNetwork => 'Error de red. Verifique su conexión.';

  @override
  String get errorServer => 'Error del servidor. Intente más tarde.';

  @override
  String get errorUnauthorized => 'Sesión expirada. Inicie sesión nuevamente.';

  @override
  String get settings => 'Configuración';

  @override
  String get language => 'Idioma';

  @override
  String get retry => 'Reintentar';

  @override
  String get loading => 'Cargando...';

  @override
  String get todoDetail => 'Detalle de Tarea';

  @override
  String get checked => 'Completada';

  @override
  String get unchecked => 'Pendiente';
}
