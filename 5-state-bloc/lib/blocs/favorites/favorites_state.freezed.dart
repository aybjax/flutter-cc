// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorites_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FavoritesState _$FavoritesStateFromJson(Map<String, dynamic> json) {
  return _FavoritesState.fromJson(json);
}

/// @nodoc
mixin _$FavoritesState {
  List<Product> get favorites => throw _privateConstructorUsedError;

  /// Serializes this FavoritesState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FavoritesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FavoritesStateCopyWith<FavoritesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoritesStateCopyWith<$Res> {
  factory $FavoritesStateCopyWith(
    FavoritesState value,
    $Res Function(FavoritesState) then,
  ) = _$FavoritesStateCopyWithImpl<$Res, FavoritesState>;
  @useResult
  $Res call({List<Product> favorites});
}

/// @nodoc
class _$FavoritesStateCopyWithImpl<$Res, $Val extends FavoritesState>
    implements $FavoritesStateCopyWith<$Res> {
  _$FavoritesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoritesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? favorites = null}) {
    return _then(
      _value.copyWith(
            favorites: null == favorites
                ? _value.favorites
                : favorites // ignore: cast_nullable_to_non_nullable
                      as List<Product>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FavoritesStateImplCopyWith<$Res>
    implements $FavoritesStateCopyWith<$Res> {
  factory _$$FavoritesStateImplCopyWith(
    _$FavoritesStateImpl value,
    $Res Function(_$FavoritesStateImpl) then,
  ) = __$$FavoritesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Product> favorites});
}

/// @nodoc
class __$$FavoritesStateImplCopyWithImpl<$Res>
    extends _$FavoritesStateCopyWithImpl<$Res, _$FavoritesStateImpl>
    implements _$$FavoritesStateImplCopyWith<$Res> {
  __$$FavoritesStateImplCopyWithImpl(
    _$FavoritesStateImpl _value,
    $Res Function(_$FavoritesStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FavoritesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? favorites = null}) {
    return _then(
      _$FavoritesStateImpl(
        favorites: null == favorites
            ? _value._favorites
            : favorites // ignore: cast_nullable_to_non_nullable
                  as List<Product>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FavoritesStateImpl extends _FavoritesState {
  const _$FavoritesStateImpl({final List<Product> favorites = const []})
    : _favorites = favorites,
      super._();

  factory _$FavoritesStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$FavoritesStateImplFromJson(json);

  final List<Product> _favorites;
  @override
  @JsonKey()
  List<Product> get favorites {
    if (_favorites is EqualUnmodifiableListView) return _favorites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favorites);
  }

  @override
  String toString() {
    return 'FavoritesState(favorites: $favorites)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoritesStateImpl &&
            const DeepCollectionEquality().equals(
              other._favorites,
              _favorites,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_favorites));

  /// Create a copy of FavoritesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoritesStateImplCopyWith<_$FavoritesStateImpl> get copyWith =>
      __$$FavoritesStateImplCopyWithImpl<_$FavoritesStateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FavoritesStateImplToJson(this);
  }
}

abstract class _FavoritesState extends FavoritesState {
  const factory _FavoritesState({final List<Product> favorites}) =
      _$FavoritesStateImpl;
  const _FavoritesState._() : super._();

  factory _FavoritesState.fromJson(Map<String, dynamic> json) =
      _$FavoritesStateImpl.fromJson;

  @override
  List<Product> get favorites;

  /// Create a copy of FavoritesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoritesStateImplCopyWith<_$FavoritesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
