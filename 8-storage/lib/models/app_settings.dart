// =============================================================================
// App Settings Model - Hive Type
// =============================================================================
//
// This model demonstrates Hive's @HiveType annotation for type adapters.
// Hive stores data in binary format and needs adapters to serialize/deserialize
// custom objects.
//
// WHY Hive for settings?
// - Key-value storage is perfect for settings (no relations needed)
// - Extremely fast reads -- settings are accessed frequently
// - box.watch() for reactive theme/currency changes
// - Lazy boxes for large settings that aren't always needed
// - Encrypted boxes for sensitive settings (API keys, etc.)
//
// Hive Type Adapter Rules:
// 1. Each class needs a unique typeId (0, 1, 2, ...)
// 2. Each field needs a unique fieldId within its class
// 3. NEVER change typeId or fieldId after release (breaks existing data)
// 4. You CAN add new fields with new fieldIds
// 5. You CAN remove fields (old data is just ignored)
// =============================================================================

import 'package:hive/hive.dart';

part 'app_settings.g.dart';

// ---------------------------------------------------------------------------
// App Settings Hive Type
// ---------------------------------------------------------------------------

/// Application settings stored in Hive.
///
/// Each field annotated with @HiveField must have a unique index.
/// These indices are permanent -- changing them breaks existing data.
///
/// The typeId (0) must be unique across all HiveTypes in the app.
/// Register this adapter during Hive initialization:
/// ```dart
/// Hive.registerAdapter(AppSettingsAdapter());
/// ```
@HiveType(typeId: 0)
class AppSettings extends HiveObject {
  // HiveObject provides box, key, save(), delete() methods
  // Alternative: Don't extend HiveObject if you don't need those helpers

  /// Currency symbol for displaying amounts (e.g., "\$", "EUR", "GBP")
  @HiveField(0)
  String currencySymbol;

  /// Whether dark mode is enabled
  @HiveField(1)
  bool isDarkMode;

  /// Date format string (e.g., "yyyy-MM-dd", "MM/dd/yyyy", "dd.MM.yyyy")
  @HiveField(2)
  String dateFormat;

  /// Locale code for internationalization (e.g., "en", "es")
  @HiveField(3)
  String localeCode;

  // ---------------------------------------------------------------------------
  // Fields added in later versions (safe to add, never reuse old fieldIds)
  // ---------------------------------------------------------------------------

  /// Whether to show decimal places in amounts
  @HiveField(4, defaultValue: true)
  bool showDecimals;

  /// Default category ID for new expenses
  @HiveField(5, defaultValue: null)
  int? defaultCategoryId;

  /// Monthly budget warning threshold (0.0 - 1.0)
  /// When spending reaches this percentage of budget, show warning
  @HiveField(6, defaultValue: 0.8)
  double budgetWarningThreshold;

  // ---------------------------------------------------------------------------
  // Constructor
  // ---------------------------------------------------------------------------

  /// Creates [AppSettings] with sensible defaults.
  ///
  /// Hive requires a default constructor for the type adapter.
  AppSettings({
    this.currencySymbol = '\$',
    this.isDarkMode = false,
    this.dateFormat = 'yyyy-MM-dd',
    this.localeCode = 'en',
    this.showDecimals = true,
    this.defaultCategoryId,
    this.budgetWarningThreshold = 0.8,
  });

  /// Creates a copy with modified fields.
  ///
  /// Since Hive objects are mutable (unlike freezed), we provide
  /// our own copyWith for convenience.
  AppSettings copyWith({
    String? currencySymbol,
    bool? isDarkMode,
    String? dateFormat,
    String? localeCode,
    bool? showDecimals,
    int? defaultCategoryId,
    double? budgetWarningThreshold,
  }) {
    return AppSettings(
      currencySymbol: currencySymbol ?? this.currencySymbol,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      dateFormat: dateFormat ?? this.dateFormat,
      localeCode: localeCode ?? this.localeCode,
      showDecimals: showDecimals ?? this.showDecimals,
      defaultCategoryId: defaultCategoryId ?? this.defaultCategoryId,
      budgetWarningThreshold:
          budgetWarningThreshold ?? this.budgetWarningThreshold,
    );
  }

  @override
  String toString() =>
      'AppSettings(currency: $currencySymbol, dark: $isDarkMode, '
      'dateFormat: $dateFormat, locale: $localeCode)';
}

// ---------------------------------------------------------------------------
// Hive Box Usage Examples
// ---------------------------------------------------------------------------
//
// // Open a regular box
// final box = await Hive.openBox<AppSettings>('settings');
//
// // Store settings
// await box.put('current', AppSettings(currencySymbol: '€'));
//
// // Read settings
// final settings = box.get('current', defaultValue: AppSettings());
//
// // Watch for changes (reactive)
// box.watch(key: 'current').listen((event) {
//   final newSettings = event.value as AppSettings?;
//   // Update UI theme, currency display, etc.
// });
//
// // Alternative: Open a lazy box (loads values on demand)
// final lazyBox = await Hive.openLazyBox<AppSettings>('settings');
// final settings = await lazyBox.get('current'); // async get
//
// // Alternative: Open an encrypted box
// final encryptedBox = await Hive.openBox(
//   'secure_settings',
//   encryptionCipher: HiveAesCipher(encryptionKey),
// );
