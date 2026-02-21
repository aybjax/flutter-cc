// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Rastreador Financiero';

  @override
  String get dashboard => 'Panel';

  @override
  String get expenses => 'Gastos';

  @override
  String get categories => 'Categorias';

  @override
  String get budgets => 'Presupuestos';

  @override
  String get settings => 'Configuracion';

  @override
  String get addExpense => 'Agregar Gasto';

  @override
  String get editExpense => 'Editar Gasto';

  @override
  String get deleteExpense => 'Eliminar Gasto';

  @override
  String get expenseTitle => 'Titulo';

  @override
  String get expenseAmount => 'Monto';

  @override
  String get expenseDate => 'Fecha';

  @override
  String get expenseCategory => 'Categoria';

  @override
  String get expenseNotes => 'Notas';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get confirmDelete => 'Esta seguro que desea eliminar esto?';

  @override
  String get totalExpenses => 'Gastos Totales';

  @override
  String get monthlyBudget => 'Presupuesto Mensual';

  @override
  String get remaining => 'Restante';

  @override
  String get spent => 'Gastado';

  @override
  String get currency => 'Moneda';

  @override
  String get theme => 'Tema';

  @override
  String get darkMode => 'Modo Oscuro';

  @override
  String get dateFormat => 'Formato de Fecha';

  @override
  String get language => 'Idioma';

  @override
  String get noExpenses => 'Sin gastos aun. Toca + para agregar uno!';

  @override
  String get noCategories => 'Sin categorias aun. Agrega una para comenzar!';

  @override
  String get addCategory => 'Agregar Categoria';

  @override
  String get editCategory => 'Editar Categoria';

  @override
  String get categoryName => 'Nombre de Categoria';

  @override
  String get categoryColor => 'Color';

  @override
  String get categoryIcon => 'Icono';

  @override
  String get budgetAmount => 'Monto del Presupuesto';

  @override
  String get budgetPeriod => 'Periodo del Presupuesto';

  @override
  String get monthly => 'Mensual';

  @override
  String get weekly => 'Semanal';

  @override
  String get yearly => 'Anual';

  @override
  String get overBudget => 'Sobre Presupuesto!';

  @override
  String get underBudget => 'Bajo Presupuesto';

  @override
  String expenseCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gastos',
      one: '1 gasto',
      zero: 'Sin gastos',
    );
    return '$_temp0';
  }

  @override
  String amountFormatted(String currency, String amount) {
    return '$currency$amount';
  }
}
