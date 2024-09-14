// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_contact_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SavedContactResponse _$SavedContactResponseFromJson(Map<String, dynamic> json) {
  return _SavedContactResponse.fromJson(json);
}

/// @nodoc
mixin _$SavedContactResponse {
  List<SavedContactResponseData>? get data =>
      throw _privateConstructorUsedError;
  int? get totalCount => throw _privateConstructorUsedError;
  int? get page => throw _privateConstructorUsedError;
  int? get pageSize => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SavedContactResponseCopyWith<SavedContactResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavedContactResponseCopyWith<$Res> {
  factory $SavedContactResponseCopyWith(SavedContactResponse value,
          $Res Function(SavedContactResponse) then) =
      _$SavedContactResponseCopyWithImpl<$Res, SavedContactResponse>;
  @useResult
  $Res call(
      {List<SavedContactResponseData>? data,
      int? totalCount,
      int? page,
      int? pageSize});
}

/// @nodoc
class _$SavedContactResponseCopyWithImpl<$Res,
        $Val extends SavedContactResponse>
    implements $SavedContactResponseCopyWith<$Res> {
  _$SavedContactResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? totalCount = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<SavedContactResponseData>?,
      totalCount: freezed == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int?,
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SavedContactResponseImplCopyWith<$Res>
    implements $SavedContactResponseCopyWith<$Res> {
  factory _$$SavedContactResponseImplCopyWith(_$SavedContactResponseImpl value,
          $Res Function(_$SavedContactResponseImpl) then) =
      __$$SavedContactResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<SavedContactResponseData>? data,
      int? totalCount,
      int? page,
      int? pageSize});
}

/// @nodoc
class __$$SavedContactResponseImplCopyWithImpl<$Res>
    extends _$SavedContactResponseCopyWithImpl<$Res, _$SavedContactResponseImpl>
    implements _$$SavedContactResponseImplCopyWith<$Res> {
  __$$SavedContactResponseImplCopyWithImpl(_$SavedContactResponseImpl _value,
      $Res Function(_$SavedContactResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? totalCount = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(_$SavedContactResponseImpl(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<SavedContactResponseData>?,
      totalCount: freezed == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int?,
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      pageSize: freezed == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SavedContactResponseImpl implements _SavedContactResponse {
  _$SavedContactResponseImpl(
      {final List<SavedContactResponseData>? data,
      this.totalCount,
      this.page,
      this.pageSize})
      : _data = data;

  factory _$SavedContactResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SavedContactResponseImplFromJson(json);

  final List<SavedContactResponseData>? _data;
  @override
  List<SavedContactResponseData>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? totalCount;
  @override
  final int? page;
  @override
  final int? pageSize;

  @override
  String toString() {
    return 'SavedContactResponse(data: $data, totalCount: $totalCount, page: $page, pageSize: $pageSize)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedContactResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_data), totalCount, page, pageSize);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SavedContactResponseImplCopyWith<_$SavedContactResponseImpl>
      get copyWith =>
          __$$SavedContactResponseImplCopyWithImpl<_$SavedContactResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SavedContactResponseImplToJson(
      this,
    );
  }
}

abstract class _SavedContactResponse implements SavedContactResponse {
  factory _SavedContactResponse(
      {final List<SavedContactResponseData>? data,
      final int? totalCount,
      final int? page,
      final int? pageSize}) = _$SavedContactResponseImpl;

  factory _SavedContactResponse.fromJson(Map<String, dynamic> json) =
      _$SavedContactResponseImpl.fromJson;

  @override
  List<SavedContactResponseData>? get data;
  @override
  int? get totalCount;
  @override
  int? get page;
  @override
  int? get pageSize;
  @override
  @JsonKey(ignore: true)
  _$$SavedContactResponseImplCopyWith<_$SavedContactResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SavedContactResponseData _$SavedContactResponseDataFromJson(
    Map<String, dynamic> json) {
  return _SavedContactResponseData.fromJson(json);
}

/// @nodoc
mixin _$SavedContactResponseData {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  String? get displayname => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get memberId => throw _privateConstructorUsedError;
  dynamic get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SavedContactResponseDataCopyWith<SavedContactResponseData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavedContactResponseDataCopyWith<$Res> {
  factory $SavedContactResponseDataCopyWith(SavedContactResponseData value,
          $Res Function(SavedContactResponseData) then) =
      _$SavedContactResponseDataCopyWithImpl<$Res, SavedContactResponseData>;
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? avatar,
      String? displayname,
      String? phoneNumber,
      String? memberId,
      dynamic error});
}

/// @nodoc
class _$SavedContactResponseDataCopyWithImpl<$Res,
        $Val extends SavedContactResponseData>
    implements $SavedContactResponseDataCopyWith<$Res> {
  _$SavedContactResponseDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? avatar = freezed,
    Object? displayname = freezed,
    Object? phoneNumber = freezed,
    Object? memberId = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      displayname: freezed == displayname
          ? _value.displayname
          : displayname // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      memberId: freezed == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SavedContactResponseDataImplCopyWith<$Res>
    implements $SavedContactResponseDataCopyWith<$Res> {
  factory _$$SavedContactResponseDataImplCopyWith(
          _$SavedContactResponseDataImpl value,
          $Res Function(_$SavedContactResponseDataImpl) then) =
      __$$SavedContactResponseDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? avatar,
      String? displayname,
      String? phoneNumber,
      String? memberId,
      dynamic error});
}

/// @nodoc
class __$$SavedContactResponseDataImplCopyWithImpl<$Res>
    extends _$SavedContactResponseDataCopyWithImpl<$Res,
        _$SavedContactResponseDataImpl>
    implements _$$SavedContactResponseDataImplCopyWith<$Res> {
  __$$SavedContactResponseDataImplCopyWithImpl(
      _$SavedContactResponseDataImpl _value,
      $Res Function(_$SavedContactResponseDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? avatar = freezed,
    Object? displayname = freezed,
    Object? phoneNumber = freezed,
    Object? memberId = freezed,
    Object? error = freezed,
  }) {
    return _then(_$SavedContactResponseDataImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      displayname: freezed == displayname
          ? _value.displayname
          : displayname // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      memberId: freezed == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
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
class _$SavedContactResponseDataImpl implements _SavedContactResponseData {
  _$SavedContactResponseDataImpl(
      {this.id,
      this.name,
      this.avatar,
      this.displayname,
      this.phoneNumber,
      this.memberId,
      this.error});

  factory _$SavedContactResponseDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$SavedContactResponseDataImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? avatar;
  @override
  final String? displayname;
  @override
  final String? phoneNumber;
  @override
  final String? memberId;
  @override
  final dynamic error;

  @override
  String toString() {
    return 'SavedContactResponseData(id: $id, name: $name, avatar: $avatar, displayname: $displayname, phoneNumber: $phoneNumber, memberId: $memberId, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedContactResponseDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.displayname, displayname) ||
                other.displayname == displayname) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, avatar, displayname,
      phoneNumber, memberId, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SavedContactResponseDataImplCopyWith<_$SavedContactResponseDataImpl>
      get copyWith => __$$SavedContactResponseDataImplCopyWithImpl<
          _$SavedContactResponseDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SavedContactResponseDataImplToJson(
      this,
    );
  }
}

abstract class _SavedContactResponseData implements SavedContactResponseData {
  factory _SavedContactResponseData(
      {final String? id,
      final String? name,
      final String? avatar,
      final String? displayname,
      final String? phoneNumber,
      final String? memberId,
      final dynamic error}) = _$SavedContactResponseDataImpl;

  factory _SavedContactResponseData.fromJson(Map<String, dynamic> json) =
      _$SavedContactResponseDataImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get avatar;
  @override
  String? get displayname;
  @override
  String? get phoneNumber;
  @override
  String? get memberId;
  @override
  dynamic get error;
  @override
  @JsonKey(ignore: true)
  _$$SavedContactResponseDataImplCopyWith<_$SavedContactResponseDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
