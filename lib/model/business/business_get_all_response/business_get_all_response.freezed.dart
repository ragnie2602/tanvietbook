// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_get_all_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BusinessGetAllResponse _$BusinessGetAllResponseFromJson(
    Map<String, dynamic> json) {
  return _BusinessGetAllResponse.fromJson(json);
}

/// @nodoc
mixin _$BusinessGetAllResponse {
  String? get id => throw _privateConstructorUsedError;
  String? get websiteName => throw _privateConstructorUsedError;
  String? get logo => throw _privateConstructorUsedError;
  dynamic get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BusinessGetAllResponseCopyWith<BusinessGetAllResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessGetAllResponseCopyWith<$Res> {
  factory $BusinessGetAllResponseCopyWith(BusinessGetAllResponse value,
          $Res Function(BusinessGetAllResponse) then) =
      _$BusinessGetAllResponseCopyWithImpl<$Res, BusinessGetAllResponse>;
  @useResult
  $Res call({String? id, String? websiteName, String? logo, dynamic error});
}

/// @nodoc
class _$BusinessGetAllResponseCopyWithImpl<$Res,
        $Val extends BusinessGetAllResponse>
    implements $BusinessGetAllResponseCopyWith<$Res> {
  _$BusinessGetAllResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? websiteName = freezed,
    Object? logo = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      websiteName: freezed == websiteName
          ? _value.websiteName
          : websiteName // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BusinessGetAllResponseImplCopyWith<$Res>
    implements $BusinessGetAllResponseCopyWith<$Res> {
  factory _$$BusinessGetAllResponseImplCopyWith(
          _$BusinessGetAllResponseImpl value,
          $Res Function(_$BusinessGetAllResponseImpl) then) =
      __$$BusinessGetAllResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? websiteName, String? logo, dynamic error});
}

/// @nodoc
class __$$BusinessGetAllResponseImplCopyWithImpl<$Res>
    extends _$BusinessGetAllResponseCopyWithImpl<$Res,
        _$BusinessGetAllResponseImpl>
    implements _$$BusinessGetAllResponseImplCopyWith<$Res> {
  __$$BusinessGetAllResponseImplCopyWithImpl(
      _$BusinessGetAllResponseImpl _value,
      $Res Function(_$BusinessGetAllResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? websiteName = freezed,
    Object? logo = freezed,
    Object? error = freezed,
  }) {
    return _then(_$BusinessGetAllResponseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      websiteName: freezed == websiteName
          ? _value.websiteName
          : websiteName // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BusinessGetAllResponseImpl implements _BusinessGetAllResponse {
  _$BusinessGetAllResponseImpl(
      {this.id, this.websiteName, this.logo, this.error});

  factory _$BusinessGetAllResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessGetAllResponseImplFromJson(json);

  @override
  final String? id;
  @override
  final String? websiteName;
  @override
  final String? logo;
  @override
  final dynamic error;

  @override
  String toString() {
    return 'BusinessGetAllResponse(id: $id, websiteName: $websiteName, logo: $logo, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessGetAllResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.websiteName, websiteName) ||
                other.websiteName == websiteName) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, websiteName, logo,
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessGetAllResponseImplCopyWith<_$BusinessGetAllResponseImpl>
      get copyWith => __$$BusinessGetAllResponseImplCopyWithImpl<
          _$BusinessGetAllResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessGetAllResponseImplToJson(
      this,
    );
  }
}

abstract class _BusinessGetAllResponse implements BusinessGetAllResponse {
  factory _BusinessGetAllResponse(
      {final String? id,
      final String? websiteName,
      final String? logo,
      final dynamic error}) = _$BusinessGetAllResponseImpl;

  factory _BusinessGetAllResponse.fromJson(Map<String, dynamic> json) =
      _$BusinessGetAllResponseImpl.fromJson;

  @override
  String? get id;
  @override
  String? get websiteName;
  @override
  String? get logo;
  @override
  dynamic get error;
  @override
  @JsonKey(ignore: true)
  _$$BusinessGetAllResponseImplCopyWith<_$BusinessGetAllResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
