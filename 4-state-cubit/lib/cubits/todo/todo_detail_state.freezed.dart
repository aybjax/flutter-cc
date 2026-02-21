// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TodoDetailState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TodoDetail todo) loaded,
    required TResult Function(TodoDetail todo) saved,
    required TResult Function(TodoFailure failure) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TodoDetail todo)? loaded,
    TResult? Function(TodoDetail todo)? saved,
    TResult? Function(TodoFailure failure)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TodoDetail todo)? loaded,
    TResult Function(TodoDetail todo)? saved,
    TResult Function(TodoFailure failure)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TodoDetailInitial value) initial,
    required TResult Function(TodoDetailLoading value) loading,
    required TResult Function(TodoDetailLoaded value) loaded,
    required TResult Function(TodoDetailSaved value) saved,
    required TResult Function(TodoDetailError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TodoDetailInitial value)? initial,
    TResult? Function(TodoDetailLoading value)? loading,
    TResult? Function(TodoDetailLoaded value)? loaded,
    TResult? Function(TodoDetailSaved value)? saved,
    TResult? Function(TodoDetailError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TodoDetailInitial value)? initial,
    TResult Function(TodoDetailLoading value)? loading,
    TResult Function(TodoDetailLoaded value)? loaded,
    TResult Function(TodoDetailSaved value)? saved,
    TResult Function(TodoDetailError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoDetailStateCopyWith<$Res> {
  factory $TodoDetailStateCopyWith(
    TodoDetailState value,
    $Res Function(TodoDetailState) then,
  ) = _$TodoDetailStateCopyWithImpl<$Res, TodoDetailState>;
}

/// @nodoc
class _$TodoDetailStateCopyWithImpl<$Res, $Val extends TodoDetailState>
    implements $TodoDetailStateCopyWith<$Res> {
  _$TodoDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodoDetailState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TodoDetailInitialImplCopyWith<$Res> {
  factory _$$TodoDetailInitialImplCopyWith(
    _$TodoDetailInitialImpl value,
    $Res Function(_$TodoDetailInitialImpl) then,
  ) = __$$TodoDetailInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TodoDetailInitialImplCopyWithImpl<$Res>
    extends _$TodoDetailStateCopyWithImpl<$Res, _$TodoDetailInitialImpl>
    implements _$$TodoDetailInitialImplCopyWith<$Res> {
  __$$TodoDetailInitialImplCopyWithImpl(
    _$TodoDetailInitialImpl _value,
    $Res Function(_$TodoDetailInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoDetailState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TodoDetailInitialImpl implements TodoDetailInitial {
  const _$TodoDetailInitialImpl();

  @override
  String toString() {
    return 'TodoDetailState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TodoDetailInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TodoDetail todo) loaded,
    required TResult Function(TodoDetail todo) saved,
    required TResult Function(TodoFailure failure) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TodoDetail todo)? loaded,
    TResult? Function(TodoDetail todo)? saved,
    TResult? Function(TodoFailure failure)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TodoDetail todo)? loaded,
    TResult Function(TodoDetail todo)? saved,
    TResult Function(TodoFailure failure)? error,
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
    required TResult Function(TodoDetailInitial value) initial,
    required TResult Function(TodoDetailLoading value) loading,
    required TResult Function(TodoDetailLoaded value) loaded,
    required TResult Function(TodoDetailSaved value) saved,
    required TResult Function(TodoDetailError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TodoDetailInitial value)? initial,
    TResult? Function(TodoDetailLoading value)? loading,
    TResult? Function(TodoDetailLoaded value)? loaded,
    TResult? Function(TodoDetailSaved value)? saved,
    TResult? Function(TodoDetailError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TodoDetailInitial value)? initial,
    TResult Function(TodoDetailLoading value)? loading,
    TResult Function(TodoDetailLoaded value)? loaded,
    TResult Function(TodoDetailSaved value)? saved,
    TResult Function(TodoDetailError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class TodoDetailInitial implements TodoDetailState {
  const factory TodoDetailInitial() = _$TodoDetailInitialImpl;
}

/// @nodoc
abstract class _$$TodoDetailLoadingImplCopyWith<$Res> {
  factory _$$TodoDetailLoadingImplCopyWith(
    _$TodoDetailLoadingImpl value,
    $Res Function(_$TodoDetailLoadingImpl) then,
  ) = __$$TodoDetailLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TodoDetailLoadingImplCopyWithImpl<$Res>
    extends _$TodoDetailStateCopyWithImpl<$Res, _$TodoDetailLoadingImpl>
    implements _$$TodoDetailLoadingImplCopyWith<$Res> {
  __$$TodoDetailLoadingImplCopyWithImpl(
    _$TodoDetailLoadingImpl _value,
    $Res Function(_$TodoDetailLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoDetailState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TodoDetailLoadingImpl implements TodoDetailLoading {
  const _$TodoDetailLoadingImpl();

  @override
  String toString() {
    return 'TodoDetailState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TodoDetailLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TodoDetail todo) loaded,
    required TResult Function(TodoDetail todo) saved,
    required TResult Function(TodoFailure failure) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TodoDetail todo)? loaded,
    TResult? Function(TodoDetail todo)? saved,
    TResult? Function(TodoFailure failure)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TodoDetail todo)? loaded,
    TResult Function(TodoDetail todo)? saved,
    TResult Function(TodoFailure failure)? error,
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
    required TResult Function(TodoDetailInitial value) initial,
    required TResult Function(TodoDetailLoading value) loading,
    required TResult Function(TodoDetailLoaded value) loaded,
    required TResult Function(TodoDetailSaved value) saved,
    required TResult Function(TodoDetailError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TodoDetailInitial value)? initial,
    TResult? Function(TodoDetailLoading value)? loading,
    TResult? Function(TodoDetailLoaded value)? loaded,
    TResult? Function(TodoDetailSaved value)? saved,
    TResult? Function(TodoDetailError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TodoDetailInitial value)? initial,
    TResult Function(TodoDetailLoading value)? loading,
    TResult Function(TodoDetailLoaded value)? loaded,
    TResult Function(TodoDetailSaved value)? saved,
    TResult Function(TodoDetailError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class TodoDetailLoading implements TodoDetailState {
  const factory TodoDetailLoading() = _$TodoDetailLoadingImpl;
}

/// @nodoc
abstract class _$$TodoDetailLoadedImplCopyWith<$Res> {
  factory _$$TodoDetailLoadedImplCopyWith(
    _$TodoDetailLoadedImpl value,
    $Res Function(_$TodoDetailLoadedImpl) then,
  ) = __$$TodoDetailLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TodoDetail todo});

  $TodoDetailCopyWith<$Res> get todo;
}

/// @nodoc
class __$$TodoDetailLoadedImplCopyWithImpl<$Res>
    extends _$TodoDetailStateCopyWithImpl<$Res, _$TodoDetailLoadedImpl>
    implements _$$TodoDetailLoadedImplCopyWith<$Res> {
  __$$TodoDetailLoadedImplCopyWithImpl(
    _$TodoDetailLoadedImpl _value,
    $Res Function(_$TodoDetailLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? todo = null}) {
    return _then(
      _$TodoDetailLoadedImpl(
        null == todo
            ? _value.todo
            : todo // ignore: cast_nullable_to_non_nullable
                  as TodoDetail,
      ),
    );
  }

  /// Create a copy of TodoDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TodoDetailCopyWith<$Res> get todo {
    return $TodoDetailCopyWith<$Res>(_value.todo, (value) {
      return _then(_value.copyWith(todo: value));
    });
  }
}

/// @nodoc

class _$TodoDetailLoadedImpl implements TodoDetailLoaded {
  const _$TodoDetailLoadedImpl(this.todo);

  @override
  final TodoDetail todo;

  @override
  String toString() {
    return 'TodoDetailState.loaded(todo: $todo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoDetailLoadedImpl &&
            (identical(other.todo, todo) || other.todo == todo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, todo);

  /// Create a copy of TodoDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoDetailLoadedImplCopyWith<_$TodoDetailLoadedImpl> get copyWith =>
      __$$TodoDetailLoadedImplCopyWithImpl<_$TodoDetailLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TodoDetail todo) loaded,
    required TResult Function(TodoDetail todo) saved,
    required TResult Function(TodoFailure failure) error,
  }) {
    return loaded(todo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TodoDetail todo)? loaded,
    TResult? Function(TodoDetail todo)? saved,
    TResult? Function(TodoFailure failure)? error,
  }) {
    return loaded?.call(todo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TodoDetail todo)? loaded,
    TResult Function(TodoDetail todo)? saved,
    TResult Function(TodoFailure failure)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(todo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TodoDetailInitial value) initial,
    required TResult Function(TodoDetailLoading value) loading,
    required TResult Function(TodoDetailLoaded value) loaded,
    required TResult Function(TodoDetailSaved value) saved,
    required TResult Function(TodoDetailError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TodoDetailInitial value)? initial,
    TResult? Function(TodoDetailLoading value)? loading,
    TResult? Function(TodoDetailLoaded value)? loaded,
    TResult? Function(TodoDetailSaved value)? saved,
    TResult? Function(TodoDetailError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TodoDetailInitial value)? initial,
    TResult Function(TodoDetailLoading value)? loading,
    TResult Function(TodoDetailLoaded value)? loaded,
    TResult Function(TodoDetailSaved value)? saved,
    TResult Function(TodoDetailError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class TodoDetailLoaded implements TodoDetailState {
  const factory TodoDetailLoaded(final TodoDetail todo) =
      _$TodoDetailLoadedImpl;

  TodoDetail get todo;

  /// Create a copy of TodoDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodoDetailLoadedImplCopyWith<_$TodoDetailLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TodoDetailSavedImplCopyWith<$Res> {
  factory _$$TodoDetailSavedImplCopyWith(
    _$TodoDetailSavedImpl value,
    $Res Function(_$TodoDetailSavedImpl) then,
  ) = __$$TodoDetailSavedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TodoDetail todo});

  $TodoDetailCopyWith<$Res> get todo;
}

/// @nodoc
class __$$TodoDetailSavedImplCopyWithImpl<$Res>
    extends _$TodoDetailStateCopyWithImpl<$Res, _$TodoDetailSavedImpl>
    implements _$$TodoDetailSavedImplCopyWith<$Res> {
  __$$TodoDetailSavedImplCopyWithImpl(
    _$TodoDetailSavedImpl _value,
    $Res Function(_$TodoDetailSavedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? todo = null}) {
    return _then(
      _$TodoDetailSavedImpl(
        null == todo
            ? _value.todo
            : todo // ignore: cast_nullable_to_non_nullable
                  as TodoDetail,
      ),
    );
  }

  /// Create a copy of TodoDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TodoDetailCopyWith<$Res> get todo {
    return $TodoDetailCopyWith<$Res>(_value.todo, (value) {
      return _then(_value.copyWith(todo: value));
    });
  }
}

/// @nodoc

class _$TodoDetailSavedImpl implements TodoDetailSaved {
  const _$TodoDetailSavedImpl(this.todo);

  @override
  final TodoDetail todo;

  @override
  String toString() {
    return 'TodoDetailState.saved(todo: $todo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoDetailSavedImpl &&
            (identical(other.todo, todo) || other.todo == todo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, todo);

  /// Create a copy of TodoDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoDetailSavedImplCopyWith<_$TodoDetailSavedImpl> get copyWith =>
      __$$TodoDetailSavedImplCopyWithImpl<_$TodoDetailSavedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TodoDetail todo) loaded,
    required TResult Function(TodoDetail todo) saved,
    required TResult Function(TodoFailure failure) error,
  }) {
    return saved(todo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TodoDetail todo)? loaded,
    TResult? Function(TodoDetail todo)? saved,
    TResult? Function(TodoFailure failure)? error,
  }) {
    return saved?.call(todo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TodoDetail todo)? loaded,
    TResult Function(TodoDetail todo)? saved,
    TResult Function(TodoFailure failure)? error,
    required TResult orElse(),
  }) {
    if (saved != null) {
      return saved(todo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TodoDetailInitial value) initial,
    required TResult Function(TodoDetailLoading value) loading,
    required TResult Function(TodoDetailLoaded value) loaded,
    required TResult Function(TodoDetailSaved value) saved,
    required TResult Function(TodoDetailError value) error,
  }) {
    return saved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TodoDetailInitial value)? initial,
    TResult? Function(TodoDetailLoading value)? loading,
    TResult? Function(TodoDetailLoaded value)? loaded,
    TResult? Function(TodoDetailSaved value)? saved,
    TResult? Function(TodoDetailError value)? error,
  }) {
    return saved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TodoDetailInitial value)? initial,
    TResult Function(TodoDetailLoading value)? loading,
    TResult Function(TodoDetailLoaded value)? loaded,
    TResult Function(TodoDetailSaved value)? saved,
    TResult Function(TodoDetailError value)? error,
    required TResult orElse(),
  }) {
    if (saved != null) {
      return saved(this);
    }
    return orElse();
  }
}

abstract class TodoDetailSaved implements TodoDetailState {
  const factory TodoDetailSaved(final TodoDetail todo) = _$TodoDetailSavedImpl;

  TodoDetail get todo;

  /// Create a copy of TodoDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodoDetailSavedImplCopyWith<_$TodoDetailSavedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TodoDetailErrorImplCopyWith<$Res> {
  factory _$$TodoDetailErrorImplCopyWith(
    _$TodoDetailErrorImpl value,
    $Res Function(_$TodoDetailErrorImpl) then,
  ) = __$$TodoDetailErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TodoFailure failure});

  $TodoFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$TodoDetailErrorImplCopyWithImpl<$Res>
    extends _$TodoDetailStateCopyWithImpl<$Res, _$TodoDetailErrorImpl>
    implements _$$TodoDetailErrorImplCopyWith<$Res> {
  __$$TodoDetailErrorImplCopyWithImpl(
    _$TodoDetailErrorImpl _value,
    $Res Function(_$TodoDetailErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodoDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? failure = null}) {
    return _then(
      _$TodoDetailErrorImpl(
        null == failure
            ? _value.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as TodoFailure,
      ),
    );
  }

  /// Create a copy of TodoDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TodoFailureCopyWith<$Res> get failure {
    return $TodoFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$TodoDetailErrorImpl implements TodoDetailError {
  const _$TodoDetailErrorImpl(this.failure);

  @override
  final TodoFailure failure;

  @override
  String toString() {
    return 'TodoDetailState.error(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoDetailErrorImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of TodoDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoDetailErrorImplCopyWith<_$TodoDetailErrorImpl> get copyWith =>
      __$$TodoDetailErrorImplCopyWithImpl<_$TodoDetailErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TodoDetail todo) loaded,
    required TResult Function(TodoDetail todo) saved,
    required TResult Function(TodoFailure failure) error,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TodoDetail todo)? loaded,
    TResult? Function(TodoDetail todo)? saved,
    TResult? Function(TodoFailure failure)? error,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TodoDetail todo)? loaded,
    TResult Function(TodoDetail todo)? saved,
    TResult Function(TodoFailure failure)? error,
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
    required TResult Function(TodoDetailInitial value) initial,
    required TResult Function(TodoDetailLoading value) loading,
    required TResult Function(TodoDetailLoaded value) loaded,
    required TResult Function(TodoDetailSaved value) saved,
    required TResult Function(TodoDetailError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TodoDetailInitial value)? initial,
    TResult? Function(TodoDetailLoading value)? loading,
    TResult? Function(TodoDetailLoaded value)? loaded,
    TResult? Function(TodoDetailSaved value)? saved,
    TResult? Function(TodoDetailError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TodoDetailInitial value)? initial,
    TResult Function(TodoDetailLoading value)? loading,
    TResult Function(TodoDetailLoaded value)? loaded,
    TResult Function(TodoDetailSaved value)? saved,
    TResult Function(TodoDetailError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class TodoDetailError implements TodoDetailState {
  const factory TodoDetailError(final TodoFailure failure) =
      _$TodoDetailErrorImpl;

  TodoFailure get failure;

  /// Create a copy of TodoDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodoDetailErrorImplCopyWith<_$TodoDetailErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
