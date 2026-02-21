// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppSettingsAdapter extends TypeAdapter<AppSettings> {
  @override
  final int typeId = 0;

  @override
  AppSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppSettings(
      currencySymbol: fields[0] as String,
      isDarkMode: fields[1] as bool,
      dateFormat: fields[2] as String,
      localeCode: fields[3] as String,
      showDecimals: fields[4] == null ? true : fields[4] as bool,
      defaultCategoryId: fields[5] as int?,
      budgetWarningThreshold: fields[6] == null ? 0.8 : fields[6] as double,
    );
  }

  @override
  void write(BinaryWriter writer, AppSettings obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.currencySymbol)
      ..writeByte(1)
      ..write(obj.isDarkMode)
      ..writeByte(2)
      ..write(obj.dateFormat)
      ..writeByte(3)
      ..write(obj.localeCode)
      ..writeByte(4)
      ..write(obj.showDecimals)
      ..writeByte(5)
      ..write(obj.defaultCategoryId)
      ..writeByte(6)
      ..write(obj.budgetWarningThreshold);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
