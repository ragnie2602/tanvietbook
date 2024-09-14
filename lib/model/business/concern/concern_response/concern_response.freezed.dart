// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'concern_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ConcernResponsePaging _$ConcernResponsePagingFromJson(
    Map<String, dynamic> json) {
  return _ConcernResponsePaging.fromJson(json);
}

/// @nodoc
mixin _$ConcernResponsePaging {
  @JsonKey(name: 'data')
  List<ConcernResponse>? get data => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalCount')
  int? get totalCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'page')
  int? get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'pageSize')
  int? get pageSize => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConcernResponsePagingCopyWith<ConcernResponsePaging> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConcernResponsePagingCopyWith<$Res> {
  factory $ConcernResponsePagingCopyWith(ConcernResponsePaging value,
          $Res Function(ConcernResponsePaging) then) =
      _$ConcernResponsePagingCopyWithImpl<$Res, ConcernResponsePaging>;
  @useResult
  $Res call(
      {@JsonKey(name: 'data') List<ConcernResponse>? data,
      @JsonKey(name: 'totalCount') int? totalCount,
      @JsonKey(name: 'page') int? page,
      @JsonKey(name: 'pageSize') int? pageSize});
}

/// @nodoc
class _$ConcernResponsePagingCopyWithImpl<$Res,
        $Val extends ConcernResponsePaging>
    implements $ConcernResponsePagingCopyWith<$Res> {
  _$ConcernResponsePagingCopyWithImpl(this._value, this._then);

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
              as List<ConcernResponse>?,
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
abstract class _$$ConcernResponsePagingImplCopyWith<$Res>
    implements $ConcernResponsePagingCopyWith<$Res> {
  factory _$$ConcernResponsePagingImplCopyWith(
          _$ConcernResponsePagingImpl value,
          $Res Function(_$ConcernResponsePagingImpl) then) =
      __$$ConcernResponsePagingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'data') List<ConcernResponse>? data,
      @JsonKey(name: 'totalCount') int? totalCount,
      @JsonKey(name: 'page') int? page,
      @JsonKey(name: 'pageSize') int? pageSize});
}

/// @nodoc
class __$$ConcernResponsePagingImplCopyWithImpl<$Res>
    extends _$ConcernResponsePagingCopyWithImpl<$Res,
        _$ConcernResponsePagingImpl>
    implements _$$ConcernResponsePagingImplCopyWith<$Res> {
  __$$ConcernResponsePagingImplCopyWithImpl(_$ConcernResponsePagingImpl _value,
      $Res Function(_$ConcernResponsePagingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? totalCount = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(_$ConcernResponsePagingImpl(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ConcernResponse>?,
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
class _$ConcernResponsePagingImpl implements _ConcernResponsePaging {
  const _$ConcernResponsePagingImpl(
      {@JsonKey(name: 'data') final List<ConcernResponse>? data,
      @JsonKey(name: 'totalCount') this.totalCount,
      @JsonKey(name: 'page') this.page,
      @JsonKey(name: 'pageSize') this.pageSize})
      : _data = data;

  factory _$ConcernResponsePagingImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConcernResponsePagingImplFromJson(json);

  final List<ConcernResponse>? _data;
  @override
  @JsonKey(name: 'data')
  List<ConcernResponse>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'totalCount')
  final int? totalCount;
  @override
  @JsonKey(name: 'page')
  final int? page;
  @override
  @JsonKey(name: 'pageSize')
  final int? pageSize;

  @override
  String toString() {
    return 'ConcernResponsePaging(data: $data, totalCount: $totalCount, page: $page, pageSize: $pageSize)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConcernResponsePagingImpl &&
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
  _$$ConcernResponsePagingImplCopyWith<_$ConcernResponsePagingImpl>
      get copyWith => __$$ConcernResponsePagingImplCopyWithImpl<
          _$ConcernResponsePagingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConcernResponsePagingImplToJson(
      this,
    );
  }
}

abstract class _ConcernResponsePaging implements ConcernResponsePaging {
  const factory _ConcernResponsePaging(
          {@JsonKey(name: 'data') final List<ConcernResponse>? data,
          @JsonKey(name: 'totalCount') final int? totalCount,
          @JsonKey(name: 'page') final int? page,
          @JsonKey(name: 'pageSize') final int? pageSize}) =
      _$ConcernResponsePagingImpl;

  factory _ConcernResponsePaging.fromJson(Map<String, dynamic> json) =
      _$ConcernResponsePagingImpl.fromJson;

  @override
  @JsonKey(name: 'data')
  List<ConcernResponse>? get data;
  @override
  @JsonKey(name: 'totalCount')
  int? get totalCount;
  @override
  @JsonKey(name: 'page')
  int? get page;
  @override
  @JsonKey(name: 'pageSize')
  int? get pageSize;
  @override
  @JsonKey(ignore: true)
  _$$ConcernResponsePagingImplCopyWith<_$ConcernResponsePagingImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ConcernResponse _$ConcernResponseFromJson(Map<String, dynamic> json) {
  return _ConcernResponse.fromJson(json);
}

/// @nodoc
mixin _$ConcernResponse {
  String? get id => throw _privateConstructorUsedError;
  String? get memberId => throw _privateConstructorUsedError;
  String? get concernId => throw _privateConstructorUsedError;
  String? get phonenumber => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get fullName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  int? get status => throw _privateConstructorUsedError;
  bool? get enable => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get concernName => throw _privateConstructorUsedError;
  List<String>? get concernImage => throw _privateConstructorUsedError;
  String? get createdDate => throw _privateConstructorUsedError;
  String? get lastModifiedDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConcernResponseCopyWith<ConcernResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConcernResponseCopyWith<$Res> {
  factory $ConcernResponseCopyWith(
          ConcernResponse value, $Res Function(ConcernResponse) then) =
      _$ConcernResponseCopyWithImpl<$Res, ConcernResponse>;
  @useResult
  $Res call(
      {String? id,
      String? memberId,
      String? concernId,
      String? phonenumber,
      String? address,
      String? fullName,
      String? email,
      String? type,
      String? note,
      int? status,
      bool? enable,
      String? description,
      String? concernName,
      List<String>? concernImage,
      String? createdDate,
      String? lastModifiedDate});
}

/// @nodoc
class _$ConcernResponseCopyWithImpl<$Res, $Val extends ConcernResponse>
    implements $ConcernResponseCopyWith<$Res> {
  _$ConcernResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? memberId = freezed,
    Object? concernId = freezed,
    Object? phonenumber = freezed,
    Object? address = freezed,
    Object? fullName = freezed,
    Object? email = freezed,
    Object? type = freezed,
    Object? note = freezed,
    Object? status = freezed,
    Object? enable = freezed,
    Object? description = freezed,
    Object? concernName = freezed,
    Object? concernImage = freezed,
    Object? createdDate = freezed,
    Object? lastModifiedDate = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      memberId: freezed == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String?,
      concernId: freezed == concernId
          ? _value.concernId
          : concernId // ignore: cast_nullable_to_non_nullable
              as String?,
      phonenumber: freezed == phonenumber
          ? _value.phonenumber
          : phonenumber // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      enable: freezed == enable
          ? _value.enable
          : enable // ignore: cast_nullable_to_non_nullable
              as bool?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      concernName: freezed == concernName
          ? _value.concernName
          : concernName // ignore: cast_nullable_to_non_nullable
              as String?,
      concernImage: freezed == concernImage
          ? _value.concernImage
          : concernImage // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as String?,
      lastModifiedDate: freezed == lastModifiedDate
          ? _value.lastModifiedDate
          : lastModifiedDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConcernResponseImplCopyWith<$Res>
    implements $ConcernResponseCopyWith<$Res> {
  factory _$$ConcernResponseImplCopyWith(_$ConcernResponseImpl value,
          $Res Function(_$ConcernResponseImpl) then) =
      __$$ConcernResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? memberId,
      String? concernId,
      String? phonenumber,
      String? address,
      String? fullName,
      String? email,
      String? type,
      String? note,
      int? status,
      bool? enable,
      String? description,
      String? concernName,
      List<String>? concernImage,
      String? createdDate,
      String? lastModifiedDate});
}

/// @nodoc
class __$$ConcernResponseImplCopyWithImpl<$Res>
    extends _$ConcernResponseCopyWithImpl<$Res, _$ConcernResponseImpl>
    implements _$$ConcernResponseImplCopyWith<$Res> {
  __$$ConcernResponseImplCopyWithImpl(
      _$ConcernResponseImpl _value, $Res Function(_$ConcernResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? memberId = freezed,
    Object? concernId = freezed,
    Object? phonenumber = freezed,
    Object? address = freezed,
    Object? fullName = freezed,
    Object? email = freezed,
    Object? type = freezed,
    Object? note = freezed,
    Object? status = freezed,
    Object? enable = freezed,
    Object? description = freezed,
    Object? concernName = freezed,
    Object? concernImage = freezed,
    Object? createdDate = freezed,
    Object? lastModifiedDate = freezed,
  }) {
    return _then(_$ConcernResponseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      memberId: freezed == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String?,
      concernId: freezed == concernId
          ? _value.concernId
          : concernId // ignore: cast_nullable_to_non_nullable
              as String?,
      phonenumber: freezed == phonenumber
          ? _value.phonenumber
          : phonenumber // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      enable: freezed == enable
          ? _value.enable
          : enable // ignore: cast_nullable_to_non_nullable
              as bool?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      concernName: freezed == concernName
          ? _value.concernName
          : concernName // ignore: cast_nullable_to_non_nullable
              as String?,
      concernImage: freezed == concernImage
          ? _value._concernImage
          : concernImage // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as String?,
      lastModifiedDate: freezed == lastModifiedDate
          ? _value.lastModifiedDate
          : lastModifiedDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConcernResponseImpl implements _ConcernResponse {
  _$ConcernResponseImpl(
      {this.id,
      this.memberId,
      this.concernId,
      this.phonenumber,
      this.address,
      this.fullName,
      this.email,
      this.type,
      this.note,
      this.status,
      this.enable,
      this.description,
      this.concernName,
      final List<String>? concernImage,
      this.createdDate,
      this.lastModifiedDate})
      : _concernImage = concernImage;

  factory _$ConcernResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConcernResponseImplFromJson(json);

  @override
  final String? id;
  @override
  final String? memberId;
  @override
  final String? concernId;
  @override
  final String? phonenumber;
  @override
  final String? address;
  @override
  final String? fullName;
  @override
  final String? email;
  @override
  final String? type;
  @override
  final String? note;
  @override
  final int? status;
  @override
  final bool? enable;
  @override
  final String? description;
  @override
  final String? concernName;
  final List<String>? _concernImage;
  @override
  List<String>? get concernImage {
    final value = _concernImage;
    if (value == null) return null;
    if (_concernImage is EqualUnmodifiableListView) return _concernImage;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? createdDate;
  @override
  final String? lastModifiedDate;

  @override
  String toString() {
    return 'ConcernResponse(id: $id, memberId: $memberId, concernId: $concernId, phonenumber: $phonenumber, address: $address, fullName: $fullName, email: $email, type: $type, note: $note, status: $status, enable: $enable, description: $description, concernName: $concernName, concernImage: $concernImage, createdDate: $createdDate, lastModifiedDate: $lastModifiedDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConcernResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.concernId, concernId) ||
                other.concernId == concernId) &&
            (identical(other.phonenumber, phonenumber) ||
                other.phonenumber == phonenumber) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.enable, enable) || other.enable == enable) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.concernName, concernName) ||
                other.concernName == concernName) &&
            const DeepCollectionEquality()
                .equals(other._concernImage, _concernImage) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            (identical(other.lastModifiedDate, lastModifiedDate) ||
                other.lastModifiedDate == lastModifiedDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      memberId,
      concernId,
      phonenumber,
      address,
      fullName,
      email,
      type,
      note,
      status,
      enable,
      description,
      concernName,
      const DeepCollectionEquality().hash(_concernImage),
      createdDate,
      lastModifiedDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConcernResponseImplCopyWith<_$ConcernResponseImpl> get copyWith =>
      __$$ConcernResponseImplCopyWithImpl<_$ConcernResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConcernResponseImplToJson(
      this,
    );
  }
}

abstract class _ConcernResponse implements ConcernResponse {
  factory _ConcernResponse(
      {final String? id,
      final String? memberId,
      final String? concernId,
      final String? phonenumber,
      final String? address,
      final String? fullName,
      final String? email,
      final String? type,
      final String? note,
      final int? status,
      final bool? enable,
      final String? description,
      final String? concernName,
      final List<String>? concernImage,
      final String? createdDate,
      final String? lastModifiedDate}) = _$ConcernResponseImpl;

  factory _ConcernResponse.fromJson(Map<String, dynamic> json) =
      _$ConcernResponseImpl.fromJson;

  @override
  String? get id;
  @override
  String? get memberId;
  @override
  String? get concernId;
  @override
  String? get phonenumber;
  @override
  String? get address;
  @override
  String? get fullName;
  @override
  String? get email;
  @override
  String? get type;
  @override
  String? get note;
  @override
  int? get status;
  @override
  bool? get enable;
  @override
  String? get description;
  @override
  String? get concernName;
  @override
  List<String>? get concernImage;
  @override
  String? get createdDate;
  @override
  String? get lastModifiedDate;
  @override
  @JsonKey(ignore: true)
  _$$ConcernResponseImplCopyWith<_$ConcernResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
