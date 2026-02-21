// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_list_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ProductListEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadProducts,
    required TResult Function(String query) searchProducts,
    required TResult Function(ProductCategory? category) filterByCategory,
    required TResult Function() clearFilters,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadProducts,
    TResult? Function(String query)? searchProducts,
    TResult? Function(ProductCategory? category)? filterByCategory,
    TResult? Function()? clearFilters,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadProducts,
    TResult Function(String query)? searchProducts,
    TResult Function(ProductCategory? category)? filterByCategory,
    TResult Function()? clearFilters,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadProducts value) loadProducts,
    required TResult Function(SearchProducts value) searchProducts,
    required TResult Function(FilterByCategory value) filterByCategory,
    required TResult Function(ClearFilters value) clearFilters,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadProducts value)? loadProducts,
    TResult? Function(SearchProducts value)? searchProducts,
    TResult? Function(FilterByCategory value)? filterByCategory,
    TResult? Function(ClearFilters value)? clearFilters,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadProducts value)? loadProducts,
    TResult Function(SearchProducts value)? searchProducts,
    TResult Function(FilterByCategory value)? filterByCategory,
    TResult Function(ClearFilters value)? clearFilters,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductListEventCopyWith<$Res> {
  factory $ProductListEventCopyWith(
    ProductListEvent value,
    $Res Function(ProductListEvent) then,
  ) = _$ProductListEventCopyWithImpl<$Res, ProductListEvent>;
}

/// @nodoc
class _$ProductListEventCopyWithImpl<$Res, $Val extends ProductListEvent>
    implements $ProductListEventCopyWith<$Res> {
  _$ProductListEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductListEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadProductsImplCopyWith<$Res> {
  factory _$$LoadProductsImplCopyWith(
    _$LoadProductsImpl value,
    $Res Function(_$LoadProductsImpl) then,
  ) = __$$LoadProductsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadProductsImplCopyWithImpl<$Res>
    extends _$ProductListEventCopyWithImpl<$Res, _$LoadProductsImpl>
    implements _$$LoadProductsImplCopyWith<$Res> {
  __$$LoadProductsImplCopyWithImpl(
    _$LoadProductsImpl _value,
    $Res Function(_$LoadProductsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductListEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadProductsImpl implements LoadProducts {
  const _$LoadProductsImpl();

  @override
  String toString() {
    return 'ProductListEvent.loadProducts()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadProductsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadProducts,
    required TResult Function(String query) searchProducts,
    required TResult Function(ProductCategory? category) filterByCategory,
    required TResult Function() clearFilters,
  }) {
    return loadProducts();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadProducts,
    TResult? Function(String query)? searchProducts,
    TResult? Function(ProductCategory? category)? filterByCategory,
    TResult? Function()? clearFilters,
  }) {
    return loadProducts?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadProducts,
    TResult Function(String query)? searchProducts,
    TResult Function(ProductCategory? category)? filterByCategory,
    TResult Function()? clearFilters,
    required TResult orElse(),
  }) {
    if (loadProducts != null) {
      return loadProducts();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadProducts value) loadProducts,
    required TResult Function(SearchProducts value) searchProducts,
    required TResult Function(FilterByCategory value) filterByCategory,
    required TResult Function(ClearFilters value) clearFilters,
  }) {
    return loadProducts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadProducts value)? loadProducts,
    TResult? Function(SearchProducts value)? searchProducts,
    TResult? Function(FilterByCategory value)? filterByCategory,
    TResult? Function(ClearFilters value)? clearFilters,
  }) {
    return loadProducts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadProducts value)? loadProducts,
    TResult Function(SearchProducts value)? searchProducts,
    TResult Function(FilterByCategory value)? filterByCategory,
    TResult Function(ClearFilters value)? clearFilters,
    required TResult orElse(),
  }) {
    if (loadProducts != null) {
      return loadProducts(this);
    }
    return orElse();
  }
}

abstract class LoadProducts implements ProductListEvent {
  const factory LoadProducts() = _$LoadProductsImpl;
}

/// @nodoc
abstract class _$$SearchProductsImplCopyWith<$Res> {
  factory _$$SearchProductsImplCopyWith(
    _$SearchProductsImpl value,
    $Res Function(_$SearchProductsImpl) then,
  ) = __$$SearchProductsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$SearchProductsImplCopyWithImpl<$Res>
    extends _$ProductListEventCopyWithImpl<$Res, _$SearchProductsImpl>
    implements _$$SearchProductsImplCopyWith<$Res> {
  __$$SearchProductsImplCopyWithImpl(
    _$SearchProductsImpl _value,
    $Res Function(_$SearchProductsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? query = null}) {
    return _then(
      _$SearchProductsImpl(
        null == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SearchProductsImpl implements SearchProducts {
  const _$SearchProductsImpl(this.query);

  @override
  final String query;

  @override
  String toString() {
    return 'ProductListEvent.searchProducts(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchProductsImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of ProductListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchProductsImplCopyWith<_$SearchProductsImpl> get copyWith =>
      __$$SearchProductsImplCopyWithImpl<_$SearchProductsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadProducts,
    required TResult Function(String query) searchProducts,
    required TResult Function(ProductCategory? category) filterByCategory,
    required TResult Function() clearFilters,
  }) {
    return searchProducts(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadProducts,
    TResult? Function(String query)? searchProducts,
    TResult? Function(ProductCategory? category)? filterByCategory,
    TResult? Function()? clearFilters,
  }) {
    return searchProducts?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadProducts,
    TResult Function(String query)? searchProducts,
    TResult Function(ProductCategory? category)? filterByCategory,
    TResult Function()? clearFilters,
    required TResult orElse(),
  }) {
    if (searchProducts != null) {
      return searchProducts(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadProducts value) loadProducts,
    required TResult Function(SearchProducts value) searchProducts,
    required TResult Function(FilterByCategory value) filterByCategory,
    required TResult Function(ClearFilters value) clearFilters,
  }) {
    return searchProducts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadProducts value)? loadProducts,
    TResult? Function(SearchProducts value)? searchProducts,
    TResult? Function(FilterByCategory value)? filterByCategory,
    TResult? Function(ClearFilters value)? clearFilters,
  }) {
    return searchProducts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadProducts value)? loadProducts,
    TResult Function(SearchProducts value)? searchProducts,
    TResult Function(FilterByCategory value)? filterByCategory,
    TResult Function(ClearFilters value)? clearFilters,
    required TResult orElse(),
  }) {
    if (searchProducts != null) {
      return searchProducts(this);
    }
    return orElse();
  }
}

abstract class SearchProducts implements ProductListEvent {
  const factory SearchProducts(final String query) = _$SearchProductsImpl;

  String get query;

  /// Create a copy of ProductListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchProductsImplCopyWith<_$SearchProductsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FilterByCategoryImplCopyWith<$Res> {
  factory _$$FilterByCategoryImplCopyWith(
    _$FilterByCategoryImpl value,
    $Res Function(_$FilterByCategoryImpl) then,
  ) = __$$FilterByCategoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ProductCategory? category});
}

/// @nodoc
class __$$FilterByCategoryImplCopyWithImpl<$Res>
    extends _$ProductListEventCopyWithImpl<$Res, _$FilterByCategoryImpl>
    implements _$$FilterByCategoryImplCopyWith<$Res> {
  __$$FilterByCategoryImplCopyWithImpl(
    _$FilterByCategoryImpl _value,
    $Res Function(_$FilterByCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? category = freezed}) {
    return _then(
      _$FilterByCategoryImpl(
        freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as ProductCategory?,
      ),
    );
  }
}

/// @nodoc

class _$FilterByCategoryImpl implements FilterByCategory {
  const _$FilterByCategoryImpl(this.category);

  @override
  final ProductCategory? category;

  @override
  String toString() {
    return 'ProductListEvent.filterByCategory(category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterByCategoryImpl &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category);

  /// Create a copy of ProductListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterByCategoryImplCopyWith<_$FilterByCategoryImpl> get copyWith =>
      __$$FilterByCategoryImplCopyWithImpl<_$FilterByCategoryImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadProducts,
    required TResult Function(String query) searchProducts,
    required TResult Function(ProductCategory? category) filterByCategory,
    required TResult Function() clearFilters,
  }) {
    return filterByCategory(category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadProducts,
    TResult? Function(String query)? searchProducts,
    TResult? Function(ProductCategory? category)? filterByCategory,
    TResult? Function()? clearFilters,
  }) {
    return filterByCategory?.call(category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadProducts,
    TResult Function(String query)? searchProducts,
    TResult Function(ProductCategory? category)? filterByCategory,
    TResult Function()? clearFilters,
    required TResult orElse(),
  }) {
    if (filterByCategory != null) {
      return filterByCategory(category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadProducts value) loadProducts,
    required TResult Function(SearchProducts value) searchProducts,
    required TResult Function(FilterByCategory value) filterByCategory,
    required TResult Function(ClearFilters value) clearFilters,
  }) {
    return filterByCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadProducts value)? loadProducts,
    TResult? Function(SearchProducts value)? searchProducts,
    TResult? Function(FilterByCategory value)? filterByCategory,
    TResult? Function(ClearFilters value)? clearFilters,
  }) {
    return filterByCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadProducts value)? loadProducts,
    TResult Function(SearchProducts value)? searchProducts,
    TResult Function(FilterByCategory value)? filterByCategory,
    TResult Function(ClearFilters value)? clearFilters,
    required TResult orElse(),
  }) {
    if (filterByCategory != null) {
      return filterByCategory(this);
    }
    return orElse();
  }
}

abstract class FilterByCategory implements ProductListEvent {
  const factory FilterByCategory(final ProductCategory? category) =
      _$FilterByCategoryImpl;

  ProductCategory? get category;

  /// Create a copy of ProductListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterByCategoryImplCopyWith<_$FilterByCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearFiltersImplCopyWith<$Res> {
  factory _$$ClearFiltersImplCopyWith(
    _$ClearFiltersImpl value,
    $Res Function(_$ClearFiltersImpl) then,
  ) = __$$ClearFiltersImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearFiltersImplCopyWithImpl<$Res>
    extends _$ProductListEventCopyWithImpl<$Res, _$ClearFiltersImpl>
    implements _$$ClearFiltersImplCopyWith<$Res> {
  __$$ClearFiltersImplCopyWithImpl(
    _$ClearFiltersImpl _value,
    $Res Function(_$ClearFiltersImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductListEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearFiltersImpl implements ClearFilters {
  const _$ClearFiltersImpl();

  @override
  String toString() {
    return 'ProductListEvent.clearFilters()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearFiltersImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadProducts,
    required TResult Function(String query) searchProducts,
    required TResult Function(ProductCategory? category) filterByCategory,
    required TResult Function() clearFilters,
  }) {
    return clearFilters();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadProducts,
    TResult? Function(String query)? searchProducts,
    TResult? Function(ProductCategory? category)? filterByCategory,
    TResult? Function()? clearFilters,
  }) {
    return clearFilters?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadProducts,
    TResult Function(String query)? searchProducts,
    TResult Function(ProductCategory? category)? filterByCategory,
    TResult Function()? clearFilters,
    required TResult orElse(),
  }) {
    if (clearFilters != null) {
      return clearFilters();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadProducts value) loadProducts,
    required TResult Function(SearchProducts value) searchProducts,
    required TResult Function(FilterByCategory value) filterByCategory,
    required TResult Function(ClearFilters value) clearFilters,
  }) {
    return clearFilters(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadProducts value)? loadProducts,
    TResult? Function(SearchProducts value)? searchProducts,
    TResult? Function(FilterByCategory value)? filterByCategory,
    TResult? Function(ClearFilters value)? clearFilters,
  }) {
    return clearFilters?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadProducts value)? loadProducts,
    TResult Function(SearchProducts value)? searchProducts,
    TResult Function(FilterByCategory value)? filterByCategory,
    TResult Function(ClearFilters value)? clearFilters,
    required TResult orElse(),
  }) {
    if (clearFilters != null) {
      return clearFilters(this);
    }
    return orElse();
  }
}

abstract class ClearFilters implements ProductListEvent {
  const factory ClearFilters() = _$ClearFiltersImpl;
}
