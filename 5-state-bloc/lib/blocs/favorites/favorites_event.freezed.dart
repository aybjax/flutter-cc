// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorites_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FavoritesEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Product product) toggleFavorite,
    required TResult Function(String productId) removeFavorite,
    required TResult Function() clearFavorites,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Product product)? toggleFavorite,
    TResult? Function(String productId)? removeFavorite,
    TResult? Function()? clearFavorites,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Product product)? toggleFavorite,
    TResult Function(String productId)? removeFavorite,
    TResult Function()? clearFavorites,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ToggleFavorite value) toggleFavorite,
    required TResult Function(RemoveFavorite value) removeFavorite,
    required TResult Function(ClearFavorites value) clearFavorites,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ToggleFavorite value)? toggleFavorite,
    TResult? Function(RemoveFavorite value)? removeFavorite,
    TResult? Function(ClearFavorites value)? clearFavorites,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ToggleFavorite value)? toggleFavorite,
    TResult Function(RemoveFavorite value)? removeFavorite,
    TResult Function(ClearFavorites value)? clearFavorites,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoritesEventCopyWith<$Res> {
  factory $FavoritesEventCopyWith(
    FavoritesEvent value,
    $Res Function(FavoritesEvent) then,
  ) = _$FavoritesEventCopyWithImpl<$Res, FavoritesEvent>;
}

/// @nodoc
class _$FavoritesEventCopyWithImpl<$Res, $Val extends FavoritesEvent>
    implements $FavoritesEventCopyWith<$Res> {
  _$FavoritesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ToggleFavoriteImplCopyWith<$Res> {
  factory _$$ToggleFavoriteImplCopyWith(
    _$ToggleFavoriteImpl value,
    $Res Function(_$ToggleFavoriteImpl) then,
  ) = __$$ToggleFavoriteImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Product product});

  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class __$$ToggleFavoriteImplCopyWithImpl<$Res>
    extends _$FavoritesEventCopyWithImpl<$Res, _$ToggleFavoriteImpl>
    implements _$$ToggleFavoriteImplCopyWith<$Res> {
  __$$ToggleFavoriteImplCopyWithImpl(
    _$ToggleFavoriteImpl _value,
    $Res Function(_$ToggleFavoriteImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? product = null}) {
    return _then(
      _$ToggleFavoriteImpl(
        null == product
            ? _value.product
            : product // ignore: cast_nullable_to_non_nullable
                  as Product,
      ),
    );
  }

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res> get product {
    return $ProductCopyWith<$Res>(_value.product, (value) {
      return _then(_value.copyWith(product: value));
    });
  }
}

/// @nodoc

class _$ToggleFavoriteImpl implements ToggleFavorite {
  const _$ToggleFavoriteImpl(this.product);

  @override
  final Product product;

  @override
  String toString() {
    return 'FavoritesEvent.toggleFavorite(product: $product)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToggleFavoriteImpl &&
            (identical(other.product, product) || other.product == product));
  }

  @override
  int get hashCode => Object.hash(runtimeType, product);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToggleFavoriteImplCopyWith<_$ToggleFavoriteImpl> get copyWith =>
      __$$ToggleFavoriteImplCopyWithImpl<_$ToggleFavoriteImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Product product) toggleFavorite,
    required TResult Function(String productId) removeFavorite,
    required TResult Function() clearFavorites,
  }) {
    return toggleFavorite(product);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Product product)? toggleFavorite,
    TResult? Function(String productId)? removeFavorite,
    TResult? Function()? clearFavorites,
  }) {
    return toggleFavorite?.call(product);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Product product)? toggleFavorite,
    TResult Function(String productId)? removeFavorite,
    TResult Function()? clearFavorites,
    required TResult orElse(),
  }) {
    if (toggleFavorite != null) {
      return toggleFavorite(product);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ToggleFavorite value) toggleFavorite,
    required TResult Function(RemoveFavorite value) removeFavorite,
    required TResult Function(ClearFavorites value) clearFavorites,
  }) {
    return toggleFavorite(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ToggleFavorite value)? toggleFavorite,
    TResult? Function(RemoveFavorite value)? removeFavorite,
    TResult? Function(ClearFavorites value)? clearFavorites,
  }) {
    return toggleFavorite?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ToggleFavorite value)? toggleFavorite,
    TResult Function(RemoveFavorite value)? removeFavorite,
    TResult Function(ClearFavorites value)? clearFavorites,
    required TResult orElse(),
  }) {
    if (toggleFavorite != null) {
      return toggleFavorite(this);
    }
    return orElse();
  }
}

abstract class ToggleFavorite implements FavoritesEvent {
  const factory ToggleFavorite(final Product product) = _$ToggleFavoriteImpl;

  Product get product;

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToggleFavoriteImplCopyWith<_$ToggleFavoriteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveFavoriteImplCopyWith<$Res> {
  factory _$$RemoveFavoriteImplCopyWith(
    _$RemoveFavoriteImpl value,
    $Res Function(_$RemoveFavoriteImpl) then,
  ) = __$$RemoveFavoriteImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String productId});
}

/// @nodoc
class __$$RemoveFavoriteImplCopyWithImpl<$Res>
    extends _$FavoritesEventCopyWithImpl<$Res, _$RemoveFavoriteImpl>
    implements _$$RemoveFavoriteImplCopyWith<$Res> {
  __$$RemoveFavoriteImplCopyWithImpl(
    _$RemoveFavoriteImpl _value,
    $Res Function(_$RemoveFavoriteImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? productId = null}) {
    return _then(
      _$RemoveFavoriteImpl(
        null == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RemoveFavoriteImpl implements RemoveFavorite {
  const _$RemoveFavoriteImpl(this.productId);

  @override
  final String productId;

  @override
  String toString() {
    return 'FavoritesEvent.removeFavorite(productId: $productId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveFavoriteImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, productId);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveFavoriteImplCopyWith<_$RemoveFavoriteImpl> get copyWith =>
      __$$RemoveFavoriteImplCopyWithImpl<_$RemoveFavoriteImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Product product) toggleFavorite,
    required TResult Function(String productId) removeFavorite,
    required TResult Function() clearFavorites,
  }) {
    return removeFavorite(productId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Product product)? toggleFavorite,
    TResult? Function(String productId)? removeFavorite,
    TResult? Function()? clearFavorites,
  }) {
    return removeFavorite?.call(productId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Product product)? toggleFavorite,
    TResult Function(String productId)? removeFavorite,
    TResult Function()? clearFavorites,
    required TResult orElse(),
  }) {
    if (removeFavorite != null) {
      return removeFavorite(productId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ToggleFavorite value) toggleFavorite,
    required TResult Function(RemoveFavorite value) removeFavorite,
    required TResult Function(ClearFavorites value) clearFavorites,
  }) {
    return removeFavorite(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ToggleFavorite value)? toggleFavorite,
    TResult? Function(RemoveFavorite value)? removeFavorite,
    TResult? Function(ClearFavorites value)? clearFavorites,
  }) {
    return removeFavorite?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ToggleFavorite value)? toggleFavorite,
    TResult Function(RemoveFavorite value)? removeFavorite,
    TResult Function(ClearFavorites value)? clearFavorites,
    required TResult orElse(),
  }) {
    if (removeFavorite != null) {
      return removeFavorite(this);
    }
    return orElse();
  }
}

abstract class RemoveFavorite implements FavoritesEvent {
  const factory RemoveFavorite(final String productId) = _$RemoveFavoriteImpl;

  String get productId;

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveFavoriteImplCopyWith<_$RemoveFavoriteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearFavoritesImplCopyWith<$Res> {
  factory _$$ClearFavoritesImplCopyWith(
    _$ClearFavoritesImpl value,
    $Res Function(_$ClearFavoritesImpl) then,
  ) = __$$ClearFavoritesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearFavoritesImplCopyWithImpl<$Res>
    extends _$FavoritesEventCopyWithImpl<$Res, _$ClearFavoritesImpl>
    implements _$$ClearFavoritesImplCopyWith<$Res> {
  __$$ClearFavoritesImplCopyWithImpl(
    _$ClearFavoritesImpl _value,
    $Res Function(_$ClearFavoritesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FavoritesEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearFavoritesImpl implements ClearFavorites {
  const _$ClearFavoritesImpl();

  @override
  String toString() {
    return 'FavoritesEvent.clearFavorites()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearFavoritesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Product product) toggleFavorite,
    required TResult Function(String productId) removeFavorite,
    required TResult Function() clearFavorites,
  }) {
    return clearFavorites();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Product product)? toggleFavorite,
    TResult? Function(String productId)? removeFavorite,
    TResult? Function()? clearFavorites,
  }) {
    return clearFavorites?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Product product)? toggleFavorite,
    TResult Function(String productId)? removeFavorite,
    TResult Function()? clearFavorites,
    required TResult orElse(),
  }) {
    if (clearFavorites != null) {
      return clearFavorites();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ToggleFavorite value) toggleFavorite,
    required TResult Function(RemoveFavorite value) removeFavorite,
    required TResult Function(ClearFavorites value) clearFavorites,
  }) {
    return clearFavorites(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ToggleFavorite value)? toggleFavorite,
    TResult? Function(RemoveFavorite value)? removeFavorite,
    TResult? Function(ClearFavorites value)? clearFavorites,
  }) {
    return clearFavorites?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ToggleFavorite value)? toggleFavorite,
    TResult Function(RemoveFavorite value)? removeFavorite,
    TResult Function(ClearFavorites value)? clearFavorites,
    required TResult orElse(),
  }) {
    if (clearFavorites != null) {
      return clearFavorites(this);
    }
    return orElse();
  }
}

abstract class ClearFavorites implements FavoritesEvent {
  const factory ClearFavorites() = _$ClearFavoritesImpl;
}
