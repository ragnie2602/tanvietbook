// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_info_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BaseInfoResponse _$BaseInfoResponseFromJson(Map<String, dynamic> json) {
  return _BaseInfoResponse.fromJson(json);
}

/// @nodoc
mixin _$BaseInfoResponse {
  String? get id => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  bool? get hidden => throw _privateConstructorUsedError;
  dynamic get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BaseInfoResponseCopyWith<BaseInfoResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaseInfoResponseCopyWith<$Res> {
  factory $BaseInfoResponseCopyWith(
          BaseInfoResponse value, $Res Function(BaseInfoResponse) then) =
      _$BaseInfoResponseCopyWithImpl<$Res, BaseInfoResponse>;
  @useResult
  $Res call(
      {String? id, String? type, String? title, bool? hidden, dynamic error});
}

/// @nodoc
class _$BaseInfoResponseCopyWithImpl<$Res, $Val extends BaseInfoResponse>
    implements $BaseInfoResponseCopyWith<$Res> {
  _$BaseInfoResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? title = freezed,
    Object? hidden = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      hidden: freezed == hidden
          ? _value.hidden
          : hidden // ignore: cast_nullable_to_non_nullable
              as bool?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BaseInfoResponseImplCopyWith<$Res>
    implements $BaseInfoResponseCopyWith<$Res> {
  factory _$$BaseInfoResponseImplCopyWith(_$BaseInfoResponseImpl value,
          $Res Function(_$BaseInfoResponseImpl) then) =
      __$$BaseInfoResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id, String? type, String? title, bool? hidden, dynamic error});
}

/// @nodoc
class __$$BaseInfoResponseImplCopyWithImpl<$Res>
    extends _$BaseInfoResponseCopyWithImpl<$Res, _$BaseInfoResponseImpl>
    implements _$$BaseInfoResponseImplCopyWith<$Res> {
  __$$BaseInfoResponseImplCopyWithImpl(_$BaseInfoResponseImpl _value,
      $Res Function(_$BaseInfoResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? title = freezed,
    Object? hidden = freezed,
    Object? error = freezed,
  }) {
    return _then(_$BaseInfoResponseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      hidden: freezed == hidden
          ? _value.hidden
          : hidden // ignore: cast_nullable_to_non_nullable
              as bool?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BaseInfoResponseImpl implements _BaseInfoResponse {
  _$BaseInfoResponseImpl(
      {this.id, this.type, this.title, this.hidden, this.error});

  factory _$BaseInfoResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BaseInfoResponseImplFromJson(json);

  @override
  final String? id;
  @override
  final String? type;
  @override
  final String? title;
  @override
  final bool? hidden;
  @override
  final dynamic error;

  @override
  String toString() {
    return 'BaseInfoResponse(id: $id, type: $type, title: $title, hidden: $hidden, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BaseInfoResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.hidden, hidden) || other.hidden == hidden) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, title, hidden,
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BaseInfoResponseImplCopyWith<_$BaseInfoResponseImpl> get copyWith =>
      __$$BaseInfoResponseImplCopyWithImpl<_$BaseInfoResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BaseInfoResponseImplToJson(
      this,
    );
  }
}

abstract class _BaseInfoResponse implements BaseInfoResponse {
  factory _BaseInfoResponse(
      {final String? id,
      final String? type,
      final String? title,
      final bool? hidden,
      final dynamic error}) = _$BaseInfoResponseImpl;

  factory _BaseInfoResponse.fromJson(Map<String, dynamic> json) =
      _$BaseInfoResponseImpl.fromJson;

  @override
  String? get id;
  @override
  String? get type;
  @override
  String? get title;
  @override
  bool? get hidden;
  @override
  dynamic get error;
  @override
  @JsonKey(ignore: true)
  _$$BaseInfoResponseImplCopyWith<_$BaseInfoResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
