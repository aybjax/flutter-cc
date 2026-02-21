// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ProductListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Product> products,
      List<Product> allProducts,
      String searchQuery,
      ProductCategory? selectedCategory,
    )
    loaded,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Product> products,
      List<Product> allProducts,
      String searchQuery,
      ProductCategory? selectedCategory,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Product> products,
      List<Product> allProducts,
      String searchQuery,
      ProductCategory? selectedCategory,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProductListInitial value) initial,
    required TResult Function(ProductListLoading value) loading,
    required TResult Function(ProductListLoaded value) loaded,
    required TResult Function(ProductListError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProductListInitial value)? initial,
    TResult? Function(ProductListLoading value)? loading,
    TResult? Function(ProductListLoaded value)? loaded,
    TResult? Function(ProductListError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProductListInitial value)? initial,
    TResult Function(ProductListLoading value)? loading,
    TResult Function(ProductListLoaded value)? loaded,
    TResult Function(ProductListError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductListStateCopyWith<$Res> {
  factory $ProductListStateCopyWith(
    ProductListState value,
    $Res Function(ProductListState) then,
  ) = _$ProductListStateCopyWithImpl<$Res, ProductListState>;
}

/// @nodoc
class _$ProductListStateCopyWithImpl<$Res, $Val extends ProductListState>
    implements $ProductListStateCopyWith<$Res> {
  _$ProductListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ProductListInitialImplCopyWith<$Res> {
  factory _$$ProductListInitialImplCopyWith(
    _$ProductListInitialImpl value,
    $Res Function(_$ProductListInitialImpl) then,
  ) = __$$ProductListInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProductListInitialImplCopyWithImpl<$Res>
    extends _$ProductListStateCopyWithImpl<$Res, _$ProductListInitialImpl>
    implements _$$ProductListInitialImplCopyWith<$Res> {
  __$$ProductListInitialImplCopyWithImpl(
    _$ProductListInitialImpl _value,
    $Res Function(_$ProductListInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ProductListInitialImpl implements ProductListInitial {
  const _$ProductListInitialImpl();

  @override
  String toString() {
    return 'ProductListState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ProductListInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Product> products,
      List<Product> allProducts,
      String searchQuery,
      ProductCategory? selectedCategory,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Product> products,
      List<Product> allProducts,
      String searchQuery,
      ProductCategory? selectedCategory,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Product> products,
      List<Product> allProducts,
      String searchQuery,
      ProductCategory? selectedCategory,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProductListInitial value) initial,
    required TResult Function(ProductListLoading value) loading,
    required TResult Function(ProductListLoaded value) loaded,
    required TResult Function(ProductListError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProductListInitial value)? initial,
    TResult? Function(ProductListLoading value)? loading,
    TResult? Function(ProductListLoaded value)? loaded,
    TResult? Function(ProductListError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProductListInitial value)? initial,
    TResult Function(ProductListLoading value)? loading,
    TResult Function(ProductListLoaded value)? loaded,
    TResult Function(ProductListError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ProductListInitial implements ProductListState {
  const factory ProductListInitial() = _$ProductListInitialImpl;
}

/// @nodoc
abstract class _$$ProductListLoadingImplCopyWith<$Res> {
  factory _$$ProductListLoadingImplCopyWith(
    _$ProductListLoadingImpl value,
    $Res Function(_$ProductListLoadingImpl) then,
  ) = __$$ProductListLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProductListLoadingImplCopyWithImpl<$Res>
    extends _$ProductListStateCopyWithImpl<$Res, _$ProductListLoadingImpl>
    implements _$$ProductListLoadingImplCopyWith<$Res> {
  __$$ProductListLoadingImplCopyWithImpl(
    _$ProductListLoadingImpl _value,
    $Res Function(_$ProductListLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ProductListLoadingImpl implements ProductListLoading {
  const _$ProductListLoadingImpl();

  @override
  String toString() {
    return 'ProductListState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ProductListLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Product> products,
      List<Product> allProducts,
      String searchQuery,
      ProductCategory? selectedCategory,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Product> products,
      List<Product> allProducts,
      String searchQuery,
      ProductCategory? selectedCategory,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Product> products,
      List<Product> allProducts,
      String searchQuery,
      ProductCategory? selectedCategory,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProductListInitial value) initial,
    required TResult Function(ProductListLoading value) loading,
    required TResult Function(ProductListLoaded value) loaded,
    required TResult Function(ProductListError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProductListInitial value)? initial,
    TResult? Function(ProductListLoading value)? loading,
    TResult? Function(ProductListLoaded value)? loaded,
    TResult? Function(ProductListError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProductListInitial value)? initial,
    TResult Function(ProductListLoading value)? loading,
    TResult Function(ProductListLoaded value)? loaded,
    TResult Function(ProductListError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ProductListLoading implements ProductListState {
  const factory ProductListLoading() = _$ProductListLoadingImpl;
}

/// @nodoc
abstract class _$$ProductListLoadedImplCopyWith<$Res> {
  factory _$$ProductListLoadedImplCopyWith(
    _$ProductListLoadedImpl value,
    $Res Function(_$ProductListLoadedImpl) then,
  ) = __$$ProductListLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<Product> products,
    List<Product> allProducts,
    String searchQuery,
    ProductCategory? selectedCategory,
  });
}

/// @nodoc
class __$$ProductListLoadedImplCopyWithImpl<$Res>
    extends _$ProductListStateCopyWithImpl<$Res, _$ProductListLoadedImpl>
    implements _$$ProductListLoadedImplCopyWith<$Res> {
  __$$ProductListLoadedImplCopyWithImpl(
    _$ProductListLoadedImpl _value,
    $Res Function(_$ProductListLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
    Object? allProducts = null,
    Object? searchQuery = null,
    Object? selectedCategory = freezed,
  }) {
    return _then(
      _$ProductListLoadedImpl(
        products: null == products
            ? _value._products
            : products // ignore: cast_nullable_to_non_nullable
                  as List<Product>,
        allProducts: null == allProducts
            ? _value._allProducts
            : allProducts // ignore: cast_nullable_to_non_nullable
                  as List<Product>,
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedCategory: freezed == selectedCategory
            ? _value.selectedCategory
            : selectedCategory // ignore: cast_nullable_to_non_nullable
                  as ProductCategory?,
      ),
    );
  }
}

/// @nodoc

class _$ProductListLoadedImpl implements ProductListLoaded {
  const _$ProductListLoadedImpl({
    required final List<Product> products,
    required final List<Product> allProducts,
    this.searchQuery = '',
    this.selectedCategory,
  }) : _products = products,
       _allProducts = allProducts;

  final List<Product> _products;
  @override
  List<Product> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  final List<Product> _allProducts;
  @override
  List<Product> get allProducts {
    if (_allProducts is EqualUnmodifiableListView) return _allProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allProducts);
  }

  @override
  @JsonKey()
  final String searchQuery;
  @override
  final ProductCategory? selectedCategory;

  @override
  String toString() {
    return 'ProductListState.loaded(products: $products, allProducts: $allProducts, searchQuery: $searchQuery, selectedCategory: $selectedCategory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductListLoadedImpl &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality().equals(
              other._allProducts,
              _allProducts,
            ) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_products),
    const DeepCollectionEquality().hash(_allProducts),
    searchQuery,
    selectedCategory,
  );

  /// Create a copy of ProductListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductListLoadedImplCopyWith<_$ProductListLoadedImpl> get copyWith =>
      __$$ProductListLoadedImplCopyWithImpl<_$ProductListLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Product> products,
      List<Product> allProducts,
      String searchQuery,
      ProductCategory? selectedCategory,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(products, allProducts, searchQuery, selectedCategory);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Product> products,
      List<Product> allProducts,
      String searchQuery,
      ProductCategory? selectedCategory,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(products, allProducts, searchQuery, selectedCategory);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Product> products,
      List<Product> allProducts,
      String searchQuery,
      ProductCategory? selectedCategory,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(products, allProducts, searchQuery, selectedCategory);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProductListInitial value) initial,
    required TResult Function(ProductListLoading value) loading,
    required TResult Function(ProductListLoaded value) loaded,
    required TResult Function(ProductListError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProductListInitial value)? initial,
    TResult? Function(ProductListLoading value)? loading,
    TResult? Function(ProductListLoaded value)? loaded,
    TResult? Function(ProductListError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProductListInitial value)? initial,
    TResult Function(ProductListLoading value)? loading,
    TResult Function(ProductListLoaded value)? loaded,
    TResult Function(ProductListError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ProductListLoaded implements ProductListState {
  const factory ProductListLoaded({
    required final List<Product> products,
    required final List<Product> allProducts,
    final String searchQuery,
    final ProductCategory? selectedCategory,
  }) = _$ProductListLoadedImpl;

  List<Product> get products;
  List<Product> get allProducts;
  String get searchQuery;
  ProductCategory? get selectedCategory;

  /// Create a copy of ProductListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductListLoadedImplCopyWith<_$ProductListLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProductListErrorImplCopyWith<$Res> {
  factory _$$ProductListErrorImplCopyWith(
    _$ProductListErrorImpl value,
    $Res Function(_$ProductListErrorImpl) then,
  ) = __$$ProductListErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ProductListErrorImplCopyWithImpl<$Res>
    extends _$ProductListStateCopyWithImpl<$Res, _$ProductListErrorImpl>
    implements _$$ProductListErrorImplCopyWith<$Res> {
  __$$ProductListErrorImplCopyWithImpl(
    _$ProductListErrorImpl _value,
    $Res Function(_$ProductListErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ProductListErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ProductListErrorImpl implements ProductListError {
  const _$ProductListErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ProductListState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductListErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ProductListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductListErrorImplCopyWith<_$ProductListErrorImpl> get copyWith =>
      __$$ProductListErrorImplCopyWithImpl<_$ProductListErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Product> products,
      List<Product> allProducts,
      String searchQuery,
      ProductCategory? selectedCategory,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Product> products,
      List<Product> allProducts,
      String searchQuery,
      ProductCategory? selectedCategory,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Product> products,
      List<Product> allProducts,
      String searchQuery,
      ProductCategory? selectedCategory,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProductListInitial value) initial,
    required TResult Function(ProductListLoading value) loading,
    required TResult Function(ProductListLoaded value) loaded,
    required TResult Function(ProductListError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProductListInitial value)? initial,
    TResult? Function(ProductListLoading value)? loading,
    TResult? Function(ProductListLoaded value)? loaded,
    TResult? Function(ProductListError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProductListInitial value)? initial,
    TResult Function(ProductListLoading value)? loading,
    TResult Function(ProductListLoaded value)? loaded,
    TResult Function(ProductListError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ProductListError implements ProductListState {
  const factory ProductListError(final String message) = _$ProductListErrorImpl;

  String get message;

  /// Create a copy of ProductListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductListErrorImplCopyWith<_$ProductListErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
