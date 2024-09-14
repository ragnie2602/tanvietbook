// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sso_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SsoState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(UserSettingsResponse user)
        getUserInfoSuccessState,
    required TResult Function() getUserInfoFailedState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(UserSettingsResponse user)? getUserInfoSuccessState,
    TResult? Function()? getUserInfoFailedState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(UserSettingsResponse user)? getUserInfoSuccessState,
    TResult Function()? getUserInfoFailedState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(SsoGetUserInfoSuccess value)
        getUserInfoSuccessState,
    required TResult Function(SsoGetUserInfoFailed value)
        getUserInfoFailedState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(SsoGetUserInfoSuccess value)? getUserInfoSuccessState,
    TResult? Function(SsoGetUserInfoFailed value)? getUserInfoFailedState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(SsoGetUserInfoSuccess value)? getUserInfoSuccessState,
    TResult Function(SsoGetUserInfoFailed value)? getUserInfoFailedState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SsoStateCopyWith<$Res> {
  factory $SsoStateCopyWith(SsoState value, $Res Function(SsoState) then) =
      _$SsoStateCopyWithImpl<$Res, SsoState>;
}

/// @nodoc
class _$SsoStateCopyWithImpl<$Res, $Val extends SsoState>
    implements $SsoStateCopyWith<$Res> {
  _$SsoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$SsoStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'SsoState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(UserSettingsResponse user)
        getUserInfoSuccessState,
    required TResult Function() getUserInfoFailedState,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(UserSettingsResponse user)? getUserInfoSuccessState,
    TResult? Function()? getUserInfoFailedState,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(UserSettingsResponse user)? getUserInfoSuccessState,
    TResult Function()? getUserInfoFailedState,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(SsoGetUserInfoSuccess value)
        getUserInfoSuccessState,
    required TResult Function(SsoGetUserInfoFailed value)
        getUserInfoFailedState,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(SsoGetUserInfoSuccess value)? getUserInfoSuccessState,
    TResult? Function(SsoGetUserInfoFailed value)? getUserInfoFailedState,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(SsoGetUserInfoSuccess value)? getUserInfoSuccessState,
    TResult Function(SsoGetUserInfoFailed value)? getUserInfoFailedState,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements SsoState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$SsoGetUserInfoSuccessImplCopyWith<$Res> {
  factory _$$SsoGetUserInfoSuccessImplCopyWith(
          _$SsoGetUserInfoSuccessImpl value,
          $Res Function(_$SsoGetUserInfoSuccessImpl) then) =
      __$$SsoGetUserInfoSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserSettingsResponse user});

  $UserSettingsResponseCopyWith<$Res> get user;
}

/// @nodoc
class __$$SsoGetUserInfoSuccessImplCopyWithImpl<$Res>
    extends _$SsoStateCopyWithImpl<$Res, _$SsoGetUserInfoSuccessImpl>
    implements _$$SsoGetUserInfoSuccessImplCopyWith<$Res> {
  __$$SsoGetUserInfoSuccessImplCopyWithImpl(_$SsoGetUserInfoSuccessImpl _value,
      $Res Function(_$SsoGetUserInfoSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$SsoGetUserInfoSuccessImpl(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserSettingsResponse,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $UserSettingsResponseCopyWith<$Res> get user {
    return $UserSettingsResponseCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$SsoGetUserInfoSuccessImpl implements SsoGetUserInfoSuccess {
  _$SsoGetUserInfoSuccessImpl(this.user);

  @override
  final UserSettingsResponse user;

  @override
  String toString() {
    return 'SsoState.getUserInfoSuccessState(user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SsoGetUserInfoSuccessImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SsoGetUserInfoSuccessImplCopyWith<_$SsoGetUserInfoSuccessImpl>
      get copyWith => __$$SsoGetUserInfoSuccessImplCopyWithImpl<
          _$SsoGetUserInfoSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(UserSettingsResponse user)
        getUserInfoSuccessState,
    required TResult Function() getUserInfoFailedState,
  }) {
    return getUserInfoSuccessState(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(UserSettingsResponse user)? getUserInfoSuccessState,
    TResult? Function()? getUserInfoFailedState,
  }) {
    return getUserInfoSuccessState?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(UserSettingsResponse user)? getUserInfoSuccessState,
    TResult Function()? getUserInfoFailedState,
    required TResult orElse(),
  }) {
    if (getUserInfoSuccessState != null) {
      return getUserInfoSuccessState(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(SsoGetUserInfoSuccess value)
        getUserInfoSuccessState,
    required TResult Function(SsoGetUserInfoFailed value)
        getUserInfoFailedState,
  }) {
    return getUserInfoSuccessState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(SsoGetUserInfoSuccess value)? getUserInfoSuccessState,
    TResult? Function(SsoGetUserInfoFailed value)? getUserInfoFailedState,
  }) {
    return getUserInfoSuccessState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(SsoGetUserInfoSuccess value)? getUserInfoSuccessState,
    TResult Function(SsoGetUserInfoFailed value)? getUserInfoFailedState,
    required TResult orElse(),
  }) {
    if (getUserInfoSuccessState != null) {
      return getUserInfoSuccessState(this);
    }
    return orElse();
  }
}

abstract class SsoGetUserInfoSuccess implements SsoState {
  factory SsoGetUserInfoSuccess(final UserSettingsResponse user) =
      _$SsoGetUserInfoSuccessImpl;

  UserSettingsResponse get user;
  @JsonKey(ignore: true)
  _$$SsoGetUserInfoSuccessImplCopyWith<_$SsoGetUserInfoSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SsoGetUserInfoFailedImplCopyWith<$Res> {
  factory _$$SsoGetUserInfoFailedImplCopyWith(_$SsoGetUserInfoFailedImpl value,
          $Res Function(_$SsoGetUserInfoFailedImpl) then) =
      __$$SsoGetUserInfoFailedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SsoGetUserInfoFailedImplCopyWithImpl<$Res>
    extends _$SsoStateCopyWithImpl<$Res, _$SsoGetUserInfoFailedImpl>
    implements _$$SsoGetUserInfoFailedImplCopyWith<$Res> {
  __$$SsoGetUserInfoFailedImplCopyWithImpl(_$SsoGetUserInfoFailedImpl _value,
      $Res Function(_$SsoGetUserInfoFailedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SsoGetUserInfoFailedImpl implements SsoGetUserInfoFailed {
  _$SsoGetUserInfoFailedImpl();

  @override
  String toString() {
    return 'SsoState.getUserInfoFailedState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SsoGetUserInfoFailedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(UserSettingsResponse user)
        getUserInfoSuccessState,
    required TResult Function() getUserInfoFailedState,
  }) {
    return getUserInfoFailedState();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(UserSettingsResponse user)? getUserInfoSuccessState,
    TResult? Function()? getUserInfoFailedState,
  }) {
    return getUserInfoFailedState?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(UserSettingsResponse user)? getUserInfoSuccessState,
    TResult Function()? getUserInfoFailedState,
    required TResult orElse(),
  }) {
    if (getUserInfoFailedState != null) {
      return getUserInfoFailedState();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(SsoGetUserInfoSuccess value)
        getUserInfoSuccessState,
    required TResult Function(SsoGetUserInfoFailed value)
        getUserInfoFailedState,
  }) {
    return getUserInfoFailedState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(SsoGetUserInfoSuccess value)? getUserInfoSuccessState,
    TResult? Function(SsoGetUserInfoFailed value)? getUserInfoFailedState,
  }) {
    return getUserInfoFailedState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(SsoGetUserInfoSuccess value)? getUserInfoSuccessState,
    TResult Function(SsoGetUserInfoFailed value)? getUserInfoFailedState,
    required TResult orElse(),
  }) {
    if (getUserInfoFailedState != null) {
      return getUserInfoFailedState(this);
    }
    return orElse();
  }
}

abstract class SsoGetUserInfoFailed implements SsoState {
  factory SsoGetUserInfoFailed() = _$SsoGetUserInfoFailedImpl;
}
