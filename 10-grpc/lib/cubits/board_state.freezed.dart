// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'board_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BoardListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Board> boards) loaded,
    required TResult Function(BoardFailure failure) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Board> boards)? loaded,
    TResult? Function(BoardFailure failure)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Board> boards)? loaded,
    TResult Function(BoardFailure failure)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BoardListInitial value) initial,
    required TResult Function(BoardListLoading value) loading,
    required TResult Function(BoardListLoaded value) loaded,
    required TResult Function(BoardListError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BoardListInitial value)? initial,
    TResult? Function(BoardListLoading value)? loading,
    TResult? Function(BoardListLoaded value)? loaded,
    TResult? Function(BoardListError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BoardListInitial value)? initial,
    TResult Function(BoardListLoading value)? loading,
    TResult Function(BoardListLoaded value)? loaded,
    TResult Function(BoardListError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoardListStateCopyWith<$Res> {
  factory $BoardListStateCopyWith(
    BoardListState value,
    $Res Function(BoardListState) then,
  ) = _$BoardListStateCopyWithImpl<$Res, BoardListState>;
}

/// @nodoc
class _$BoardListStateCopyWithImpl<$Res, $Val extends BoardListState>
    implements $BoardListStateCopyWith<$Res> {
  _$BoardListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BoardListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$BoardListInitialImplCopyWith<$Res> {
  factory _$$BoardListInitialImplCopyWith(
    _$BoardListInitialImpl value,
    $Res Function(_$BoardListInitialImpl) then,
  ) = __$$BoardListInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BoardListInitialImplCopyWithImpl<$Res>
    extends _$BoardListStateCopyWithImpl<$Res, _$BoardListInitialImpl>
    implements _$$BoardListInitialImplCopyWith<$Res> {
  __$$BoardListInitialImplCopyWithImpl(
    _$BoardListInitialImpl _value,
    $Res Function(_$BoardListInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BoardListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BoardListInitialImpl implements BoardListInitial {
  const _$BoardListInitialImpl();

  @override
  String toString() {
    return 'BoardListState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BoardListInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Board> boards) loaded,
    required TResult Function(BoardFailure failure) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Board> boards)? loaded,
    TResult? Function(BoardFailure failure)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Board> boards)? loaded,
    TResult Function(BoardFailure failure)? error,
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
    required TResult Function(BoardListInitial value) initial,
    required TResult Function(BoardListLoading value) loading,
    required TResult Function(BoardListLoaded value) loaded,
    required TResult Function(BoardListError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BoardListInitial value)? initial,
    TResult? Function(BoardListLoading value)? loading,
    TResult? Function(BoardListLoaded value)? loaded,
    TResult? Function(BoardListError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BoardListInitial value)? initial,
    TResult Function(BoardListLoading value)? loading,
    TResult Function(BoardListLoaded value)? loaded,
    TResult Function(BoardListError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class BoardListInitial implements BoardListState {
  const factory BoardListInitial() = _$BoardListInitialImpl;
}

/// @nodoc
abstract class _$$BoardListLoadingImplCopyWith<$Res> {
  factory _$$BoardListLoadingImplCopyWith(
    _$BoardListLoadingImpl value,
    $Res Function(_$BoardListLoadingImpl) then,
  ) = __$$BoardListLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BoardListLoadingImplCopyWithImpl<$Res>
    extends _$BoardListStateCopyWithImpl<$Res, _$BoardListLoadingImpl>
    implements _$$BoardListLoadingImplCopyWith<$Res> {
  __$$BoardListLoadingImplCopyWithImpl(
    _$BoardListLoadingImpl _value,
    $Res Function(_$BoardListLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BoardListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BoardListLoadingImpl implements BoardListLoading {
  const _$BoardListLoadingImpl();

  @override
  String toString() {
    return 'BoardListState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BoardListLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Board> boards) loaded,
    required TResult Function(BoardFailure failure) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Board> boards)? loaded,
    TResult? Function(BoardFailure failure)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Board> boards)? loaded,
    TResult Function(BoardFailure failure)? error,
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
    required TResult Function(BoardListInitial value) initial,
    required TResult Function(BoardListLoading value) loading,
    required TResult Function(BoardListLoaded value) loaded,
    required TResult Function(BoardListError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BoardListInitial value)? initial,
    TResult? Function(BoardListLoading value)? loading,
    TResult? Function(BoardListLoaded value)? loaded,
    TResult? Function(BoardListError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BoardListInitial value)? initial,
    TResult Function(BoardListLoading value)? loading,
    TResult Function(BoardListLoaded value)? loaded,
    TResult Function(BoardListError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class BoardListLoading implements BoardListState {
  const factory BoardListLoading() = _$BoardListLoadingImpl;
}

/// @nodoc
abstract class _$$BoardListLoadedImplCopyWith<$Res> {
  factory _$$BoardListLoadedImplCopyWith(
    _$BoardListLoadedImpl value,
    $Res Function(_$BoardListLoadedImpl) then,
  ) = __$$BoardListLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Board> boards});
}

/// @nodoc
class __$$BoardListLoadedImplCopyWithImpl<$Res>
    extends _$BoardListStateCopyWithImpl<$Res, _$BoardListLoadedImpl>
    implements _$$BoardListLoadedImplCopyWith<$Res> {
  __$$BoardListLoadedImplCopyWithImpl(
    _$BoardListLoadedImpl _value,
    $Res Function(_$BoardListLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BoardListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? boards = null}) {
    return _then(
      _$BoardListLoadedImpl(
        null == boards
            ? _value._boards
            : boards // ignore: cast_nullable_to_non_nullable
                  as List<Board>,
      ),
    );
  }
}

/// @nodoc

class _$BoardListLoadedImpl implements BoardListLoaded {
  const _$BoardListLoadedImpl(final List<Board> boards) : _boards = boards;

  final List<Board> _boards;
  @override
  List<Board> get boards {
    if (_boards is EqualUnmodifiableListView) return _boards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_boards);
  }

  @override
  String toString() {
    return 'BoardListState.loaded(boards: $boards)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoardListLoadedImpl &&
            const DeepCollectionEquality().equals(other._boards, _boards));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_boards));

  /// Create a copy of BoardListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BoardListLoadedImplCopyWith<_$BoardListLoadedImpl> get copyWith =>
      __$$BoardListLoadedImplCopyWithImpl<_$BoardListLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Board> boards) loaded,
    required TResult Function(BoardFailure failure) error,
  }) {
    return loaded(boards);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Board> boards)? loaded,
    TResult? Function(BoardFailure failure)? error,
  }) {
    return loaded?.call(boards);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Board> boards)? loaded,
    TResult Function(BoardFailure failure)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(boards);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BoardListInitial value) initial,
    required TResult Function(BoardListLoading value) loading,
    required TResult Function(BoardListLoaded value) loaded,
    required TResult Function(BoardListError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BoardListInitial value)? initial,
    TResult? Function(BoardListLoading value)? loading,
    TResult? Function(BoardListLoaded value)? loaded,
    TResult? Function(BoardListError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BoardListInitial value)? initial,
    TResult Function(BoardListLoading value)? loading,
    TResult Function(BoardListLoaded value)? loaded,
    TResult Function(BoardListError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class BoardListLoaded implements BoardListState {
  const factory BoardListLoaded(final List<Board> boards) =
      _$BoardListLoadedImpl;

  List<Board> get boards;

  /// Create a copy of BoardListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BoardListLoadedImplCopyWith<_$BoardListLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BoardListErrorImplCopyWith<$Res> {
  factory _$$BoardListErrorImplCopyWith(
    _$BoardListErrorImpl value,
    $Res Function(_$BoardListErrorImpl) then,
  ) = __$$BoardListErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BoardFailure failure});

  $BoardFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$BoardListErrorImplCopyWithImpl<$Res>
    extends _$BoardListStateCopyWithImpl<$Res, _$BoardListErrorImpl>
    implements _$$BoardListErrorImplCopyWith<$Res> {
  __$$BoardListErrorImplCopyWithImpl(
    _$BoardListErrorImpl _value,
    $Res Function(_$BoardListErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BoardListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? failure = null}) {
    return _then(
      _$BoardListErrorImpl(
        null == failure
            ? _value.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as BoardFailure,
      ),
    );
  }

  /// Create a copy of BoardListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BoardFailureCopyWith<$Res> get failure {
    return $BoardFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$BoardListErrorImpl implements BoardListError {
  const _$BoardListErrorImpl(this.failure);

  @override
  final BoardFailure failure;

  @override
  String toString() {
    return 'BoardListState.error(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoardListErrorImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of BoardListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BoardListErrorImplCopyWith<_$BoardListErrorImpl> get copyWith =>
      __$$BoardListErrorImplCopyWithImpl<_$BoardListErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Board> boards) loaded,
    required TResult Function(BoardFailure failure) error,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Board> boards)? loaded,
    TResult? Function(BoardFailure failure)? error,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Board> boards)? loaded,
    TResult Function(BoardFailure failure)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BoardListInitial value) initial,
    required TResult Function(BoardListLoading value) loading,
    required TResult Function(BoardListLoaded value) loaded,
    required TResult Function(BoardListError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BoardListInitial value)? initial,
    TResult? Function(BoardListLoading value)? loading,
    TResult? Function(BoardListLoaded value)? loaded,
    TResult? Function(BoardListError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BoardListInitial value)? initial,
    TResult Function(BoardListLoading value)? loading,
    TResult Function(BoardListLoaded value)? loaded,
    TResult Function(BoardListError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class BoardListError implements BoardListState {
  const factory BoardListError(final BoardFailure failure) =
      _$BoardListErrorImpl;

  BoardFailure get failure;

  /// Create a copy of BoardListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BoardListErrorImplCopyWith<_$BoardListErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BoardDetailState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Board board, bool isWatching) loaded,
    required TResult Function(BoardFailure failure) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Board board, bool isWatching)? loaded,
    TResult? Function(BoardFailure failure)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Board board, bool isWatching)? loaded,
    TResult Function(BoardFailure failure)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BoardDetailInitial value) initial,
    required TResult Function(BoardDetailLoading value) loading,
    required TResult Function(BoardDetailLoaded value) loaded,
    required TResult Function(BoardDetailError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BoardDetailInitial value)? initial,
    TResult? Function(BoardDetailLoading value)? loading,
    TResult? Function(BoardDetailLoaded value)? loaded,
    TResult? Function(BoardDetailError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BoardDetailInitial value)? initial,
    TResult Function(BoardDetailLoading value)? loading,
    TResult Function(BoardDetailLoaded value)? loaded,
    TResult Function(BoardDetailError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoardDetailStateCopyWith<$Res> {
  factory $BoardDetailStateCopyWith(
    BoardDetailState value,
    $Res Function(BoardDetailState) then,
  ) = _$BoardDetailStateCopyWithImpl<$Res, BoardDetailState>;
}

/// @nodoc
class _$BoardDetailStateCopyWithImpl<$Res, $Val extends BoardDetailState>
    implements $BoardDetailStateCopyWith<$Res> {
  _$BoardDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BoardDetailState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$BoardDetailInitialImplCopyWith<$Res> {
  factory _$$BoardDetailInitialImplCopyWith(
    _$BoardDetailInitialImpl value,
    $Res Function(_$BoardDetailInitialImpl) then,
  ) = __$$BoardDetailInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BoardDetailInitialImplCopyWithImpl<$Res>
    extends _$BoardDetailStateCopyWithImpl<$Res, _$BoardDetailInitialImpl>
    implements _$$BoardDetailInitialImplCopyWith<$Res> {
  __$$BoardDetailInitialImplCopyWithImpl(
    _$BoardDetailInitialImpl _value,
    $Res Function(_$BoardDetailInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BoardDetailState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BoardDetailInitialImpl implements BoardDetailInitial {
  const _$BoardDetailInitialImpl();

  @override
  String toString() {
    return 'BoardDetailState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BoardDetailInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Board board, bool isWatching) loaded,
    required TResult Function(BoardFailure failure) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Board board, bool isWatching)? loaded,
    TResult? Function(BoardFailure failure)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Board board, bool isWatching)? loaded,
    TResult Function(BoardFailure failure)? error,
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
    required TResult Function(BoardDetailInitial value) initial,
    required TResult Function(BoardDetailLoading value) loading,
    required TResult Function(BoardDetailLoaded value) loaded,
    required TResult Function(BoardDetailError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BoardDetailInitial value)? initial,
    TResult? Function(BoardDetailLoading value)? loading,
    TResult? Function(BoardDetailLoaded value)? loaded,
    TResult? Function(BoardDetailError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BoardDetailInitial value)? initial,
    TResult Function(BoardDetailLoading value)? loading,
    TResult Function(BoardDetailLoaded value)? loaded,
    TResult Function(BoardDetailError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class BoardDetailInitial implements BoardDetailState {
  const factory BoardDetailInitial() = _$BoardDetailInitialImpl;
}

/// @nodoc
abstract class _$$BoardDetailLoadingImplCopyWith<$Res> {
  factory _$$BoardDetailLoadingImplCopyWith(
    _$BoardDetailLoadingImpl value,
    $Res Function(_$BoardDetailLoadingImpl) then,
  ) = __$$BoardDetailLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BoardDetailLoadingImplCopyWithImpl<$Res>
    extends _$BoardDetailStateCopyWithImpl<$Res, _$BoardDetailLoadingImpl>
    implements _$$BoardDetailLoadingImplCopyWith<$Res> {
  __$$BoardDetailLoadingImplCopyWithImpl(
    _$BoardDetailLoadingImpl _value,
    $Res Function(_$BoardDetailLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BoardDetailState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BoardDetailLoadingImpl implements BoardDetailLoading {
  const _$BoardDetailLoadingImpl();

  @override
  String toString() {
    return 'BoardDetailState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BoardDetailLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Board board, bool isWatching) loaded,
    required TResult Function(BoardFailure failure) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Board board, bool isWatching)? loaded,
    TResult? Function(BoardFailure failure)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Board board, bool isWatching)? loaded,
    TResult Function(BoardFailure failure)? error,
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
    required TResult Function(BoardDetailInitial value) initial,
    required TResult Function(BoardDetailLoading value) loading,
    required TResult Function(BoardDetailLoaded value) loaded,
    required TResult Function(BoardDetailError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BoardDetailInitial value)? initial,
    TResult? Function(BoardDetailLoading value)? loading,
    TResult? Function(BoardDetailLoaded value)? loaded,
    TResult? Function(BoardDetailError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BoardDetailInitial value)? initial,
    TResult Function(BoardDetailLoading value)? loading,
    TResult Function(BoardDetailLoaded value)? loaded,
    TResult Function(BoardDetailError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class BoardDetailLoading implements BoardDetailState {
  const factory BoardDetailLoading() = _$BoardDetailLoadingImpl;
}

/// @nodoc
abstract class _$$BoardDetailLoadedImplCopyWith<$Res> {
  factory _$$BoardDetailLoadedImplCopyWith(
    _$BoardDetailLoadedImpl value,
    $Res Function(_$BoardDetailLoadedImpl) then,
  ) = __$$BoardDetailLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Board board, bool isWatching});

  $BoardCopyWith<$Res> get board;
}

/// @nodoc
class __$$BoardDetailLoadedImplCopyWithImpl<$Res>
    extends _$BoardDetailStateCopyWithImpl<$Res, _$BoardDetailLoadedImpl>
    implements _$$BoardDetailLoadedImplCopyWith<$Res> {
  __$$BoardDetailLoadedImplCopyWithImpl(
    _$BoardDetailLoadedImpl _value,
    $Res Function(_$BoardDetailLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BoardDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? board = null, Object? isWatching = null}) {
    return _then(
      _$BoardDetailLoadedImpl(
        null == board
            ? _value.board
            : board // ignore: cast_nullable_to_non_nullable
                  as Board,
        isWatching: null == isWatching
            ? _value.isWatching
            : isWatching // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }

  /// Create a copy of BoardDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BoardCopyWith<$Res> get board {
    return $BoardCopyWith<$Res>(_value.board, (value) {
      return _then(_value.copyWith(board: value));
    });
  }
}

/// @nodoc

class _$BoardDetailLoadedImpl implements BoardDetailLoaded {
  const _$BoardDetailLoadedImpl(this.board, {this.isWatching = false});

  @override
  final Board board;
  @override
  @JsonKey()
  final bool isWatching;

  @override
  String toString() {
    return 'BoardDetailState.loaded(board: $board, isWatching: $isWatching)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoardDetailLoadedImpl &&
            (identical(other.board, board) || other.board == board) &&
            (identical(other.isWatching, isWatching) ||
                other.isWatching == isWatching));
  }

  @override
  int get hashCode => Object.hash(runtimeType, board, isWatching);

  /// Create a copy of BoardDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BoardDetailLoadedImplCopyWith<_$BoardDetailLoadedImpl> get copyWith =>
      __$$BoardDetailLoadedImplCopyWithImpl<_$BoardDetailLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Board board, bool isWatching) loaded,
    required TResult Function(BoardFailure failure) error,
  }) {
    return loaded(board, isWatching);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Board board, bool isWatching)? loaded,
    TResult? Function(BoardFailure failure)? error,
  }) {
    return loaded?.call(board, isWatching);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Board board, bool isWatching)? loaded,
    TResult Function(BoardFailure failure)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(board, isWatching);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BoardDetailInitial value) initial,
    required TResult Function(BoardDetailLoading value) loading,
    required TResult Function(BoardDetailLoaded value) loaded,
    required TResult Function(BoardDetailError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BoardDetailInitial value)? initial,
    TResult? Function(BoardDetailLoading value)? loading,
    TResult? Function(BoardDetailLoaded value)? loaded,
    TResult? Function(BoardDetailError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BoardDetailInitial value)? initial,
    TResult Function(BoardDetailLoading value)? loading,
    TResult Function(BoardDetailLoaded value)? loaded,
    TResult Function(BoardDetailError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class BoardDetailLoaded implements BoardDetailState {
  const factory BoardDetailLoaded(final Board board, {final bool isWatching}) =
      _$BoardDetailLoadedImpl;

  Board get board;
  bool get isWatching;

  /// Create a copy of BoardDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BoardDetailLoadedImplCopyWith<_$BoardDetailLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BoardDetailErrorImplCopyWith<$Res> {
  factory _$$BoardDetailErrorImplCopyWith(
    _$BoardDetailErrorImpl value,
    $Res Function(_$BoardDetailErrorImpl) then,
  ) = __$$BoardDetailErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BoardFailure failure});

  $BoardFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$BoardDetailErrorImplCopyWithImpl<$Res>
    extends _$BoardDetailStateCopyWithImpl<$Res, _$BoardDetailErrorImpl>
    implements _$$BoardDetailErrorImplCopyWith<$Res> {
  __$$BoardDetailErrorImplCopyWithImpl(
    _$BoardDetailErrorImpl _value,
    $Res Function(_$BoardDetailErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BoardDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? failure = null}) {
    return _then(
      _$BoardDetailErrorImpl(
        null == failure
            ? _value.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as BoardFailure,
      ),
    );
  }

  /// Create a copy of BoardDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BoardFailureCopyWith<$Res> get failure {
    return $BoardFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$BoardDetailErrorImpl implements BoardDetailError {
  const _$BoardDetailErrorImpl(this.failure);

  @override
  final BoardFailure failure;

  @override
  String toString() {
    return 'BoardDetailState.error(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoardDetailErrorImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of BoardDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BoardDetailErrorImplCopyWith<_$BoardDetailErrorImpl> get copyWith =>
      __$$BoardDetailErrorImplCopyWithImpl<_$BoardDetailErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Board board, bool isWatching) loaded,
    required TResult Function(BoardFailure failure) error,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Board board, bool isWatching)? loaded,
    TResult? Function(BoardFailure failure)? error,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Board board, bool isWatching)? loaded,
    TResult Function(BoardFailure failure)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BoardDetailInitial value) initial,
    required TResult Function(BoardDetailLoading value) loading,
    required TResult Function(BoardDetailLoaded value) loaded,
    required TResult Function(BoardDetailError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BoardDetailInitial value)? initial,
    TResult? Function(BoardDetailLoading value)? loading,
    TResult? Function(BoardDetailLoaded value)? loaded,
    TResult? Function(BoardDetailError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BoardDetailInitial value)? initial,
    TResult Function(BoardDetailLoading value)? loading,
    TResult Function(BoardDetailLoaded value)? loaded,
    TResult Function(BoardDetailError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class BoardDetailError implements BoardDetailState {
  const factory BoardDetailError(final BoardFailure failure) =
      _$BoardDetailErrorImpl;

  BoardFailure get failure;

  /// Create a copy of BoardDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BoardDetailErrorImplCopyWith<_$BoardDetailErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
