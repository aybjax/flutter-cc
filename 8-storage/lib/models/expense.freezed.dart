// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Expense _$ExpenseFromJson(Map<String, dynamic> json) {
  return _Expense.fromJson(json);
}

/// @nodoc
mixin _$Expense {
// SQLite auto-increment primary key -- null for new records
  int? get id => throw _privateConstructorUsedError;

  /// Display title for the expense
  String get title => throw _privateConstructorUsedError;

  /// Amount in the user's selected currency
  double get amount => throw _privateConstructorUsedError;

  /// When the expense occurred (stored as ISO8601 string in SQLite)
  DateTime get date => throw _privateConstructorUsedError;

  /// Foreign key to category (stored in Isar, referenced by ID here)
  int? get categoryId => throw _privateConstructorUsedError;

  /// Optional name cached from category for display without JOIN
  String? get categoryName => throw _privateConstructorUsedError;

  /// Free-form notes about the expense
  String get notes =>
      throw _privateConstructorUsedError; // ---------------------------------------------------------------------------
// v2 migration fields -- added in database version 2
// ---------------------------------------------------------------------------
  /// Whether this is a recurring expense (added in v2 migration)
  bool get isRecurring => throw _privateConstructorUsedError;

  /// Tags for filtering, stored as comma-separated string in SQLite
  /// Alternative: use a separate tags table with many-to-many relationship
  String get tags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExpenseCopyWith<Expense> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseCopyWith<$Res> {
  factory $ExpenseCopyWith(Expense value, $Res Function(Expense) then) =
      _$ExpenseCopyWithImpl<$Res, Expense>;
  @useResult
  $Res call(
      {int? id,
      String title,
      double amount,
      DateTime date,
      int? categoryId,
      String? categoryName,
      String notes,
      bool isRecurring,
      String tags});
}

/// @nodoc
class _$ExpenseCopyWithImpl<$Res, $Val extends Expense>
    implements $ExpenseCopyWith<$Res> {
  _$ExpenseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? amount = null,
    Object? date = null,
    Object? categoryId = freezed,
    Object? categoryName = freezed,
    Object? notes = null,
    Object? isRecurring = null,
    Object? tags = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      isRecurring: null == isRecurring
          ? _value.isRecurring
          : isRecurring // ignore: cast_nullable_to_non_nullable
              as bool,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExpenseImplCopyWith<$Res> implements $ExpenseCopyWith<$Res> {
  factory _$$ExpenseImplCopyWith(
          _$ExpenseImpl value, $Res Function(_$ExpenseImpl) then) =
      __$$ExpenseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String title,
      double amount,
      DateTime date,
      int? categoryId,
      String? categoryName,
      String notes,
      bool isRecurring,
      String tags});
}

/// @nodoc
class __$$ExpenseImplCopyWithImpl<$Res>
    extends _$ExpenseCopyWithImpl<$Res, _$ExpenseImpl>
    implements _$$ExpenseImplCopyWith<$Res> {
  __$$ExpenseImplCopyWithImpl(
      _$ExpenseImpl _value, $Res Function(_$ExpenseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? amount = null,
    Object? date = null,
    Object? categoryId = freezed,
    Object? categoryName = freezed,
    Object? notes = null,
    Object? isRecurring = null,
    Object? tags = null,
  }) {
    return _then(_$ExpenseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      isRecurring: null == isRecurring
          ? _value.isRecurring
          : isRecurring // ignore: cast_nullable_to_non_nullable
              as bool,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpenseImpl implements _Expense {
  const _$ExpenseImpl(
      {this.id,
      required this.title,
      required this.amount,
      required this.date,
      this.categoryId,
      this.categoryName,
      this.notes = '',
      this.isRecurring = false,
      this.tags = ''});

  factory _$ExpenseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpenseImplFromJson(json);

// SQLite auto-increment primary key -- null for new records
  @override
  final int? id;

  /// Display title for the expense
  @override
  final String title;

  /// Amount in the user's selected currency
  @override
  final double amount;

  /// When the expense occurred (stored as ISO8601 string in SQLite)
  @override
  final DateTime date;

  /// Foreign key to category (stored in Isar, referenced by ID here)
  @override
  final int? categoryId;

  /// Optional name cached from category for display without JOIN
  @override
  final String? categoryName;

  /// Free-form notes about the expense
  @override
  @JsonKey()
  final String notes;
// ---------------------------------------------------------------------------
// v2 migration fields -- added in database version 2
// ---------------------------------------------------------------------------
  /// Whether this is a recurring expense (added in v2 migration)
  @override
  @JsonKey()
  final bool isRecurring;

  /// Tags for filtering, stored as comma-separated string in SQLite
  /// Alternative: use a separate tags table with many-to-many relationship
  @override
  @JsonKey()
  final String tags;

  @override
  String toString() {
    return 'Expense(id: $id, title: $title, amount: $amount, date: $date, categoryId: $categoryId, categoryName: $categoryName, notes: $notes, isRecurring: $isRecurring, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.isRecurring, isRecurring) ||
                other.isRecurring == isRecurring) &&
            (identical(other.tags, tags) || other.tags == tags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, amount, date,
      categoryId, categoryName, notes, isRecurring, tags);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseImplCopyWith<_$ExpenseImpl> get copyWith =>
      __$$ExpenseImplCopyWithImpl<_$ExpenseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpenseImplToJson(
      this,
    );
  }
}

abstract class _Expense implements Expense {
  const factory _Expense(
      {final int? id,
      required final String title,
      required final double amount,
      required final DateTime date,
      final int? categoryId,
      final String? categoryName,
      final String notes,
      final bool isRecurring,
      final String tags}) = _$ExpenseImpl;

  factory _Expense.fromJson(Map<String, dynamic> json) = _$ExpenseImpl.fromJson;

  @override // SQLite auto-increment primary key -- null for new records
  int? get id;
  @override

  /// Display title for the expense
  String get title;
  @override

  /// Amount in the user's selected currency
  double get amount;
  @override

  /// When the expense occurred (stored as ISO8601 string in SQLite)
  DateTime get date;
  @override

  /// Foreign key to category (stored in Isar, referenced by ID here)
  int? get categoryId;
  @override

  /// Optional name cached from category for display without JOIN
  String? get categoryName;
  @override

  /// Free-form notes about the expense
  String get notes;
  @override // ---------------------------------------------------------------------------
// v2 migration fields -- added in database version 2
// ---------------------------------------------------------------------------
  /// Whether this is a recurring expense (added in v2 migration)
  bool get isRecurring;
  @override

  /// Tags for filtering, stored as comma-separated string in SQLite
  /// Alternative: use a separate tags table with many-to-many relationship
  String get tags;
  @override
  @JsonKey(ignore: true)
  _$$ExpenseImplCopyWith<_$ExpenseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
