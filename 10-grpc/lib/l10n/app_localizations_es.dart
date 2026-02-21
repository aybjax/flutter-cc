// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Tablero de Tareas';

  @override
  String get boardListTitle => 'Mis Tableros';

  @override
  String get createCard => 'Crear Tarjeta';

  @override
  String get editCard => 'Editar Tarjeta';

  @override
  String get cardTitle => 'Titulo';

  @override
  String get cardDescription => 'Descripcion';

  @override
  String get selectColumn => 'Columna';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get deleteConfirmation =>
      'Esta seguro de que desea eliminar esta tarjeta?';

  @override
  String get errorLoading => 'Error al cargar los datos';

  @override
  String get retry => 'Reintentar';

  @override
  String get noBoards => 'No hay tableros disponibles';

  @override
  String get noCards => 'No hay tarjetas en esta columna';

  @override
  String get connectionError =>
      'Error de conexion. Verifique que el servidor este en ejecucion.';

  @override
  String get watching => 'En vivo';

  @override
  String get cardCreated => 'Tarjeta creada';

  @override
  String get cardMoved => 'Tarjeta movida';

  @override
  String get cardDeleted => 'Tarjeta eliminada';

  @override
  String get titleRequired => 'El titulo es obligatorio';

  @override
  String get dragToMove => 'Arrastra para mover entre columnas';
}
