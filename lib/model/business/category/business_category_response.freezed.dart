// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_category_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BusinessCategoryGetAllResponse _$BusinessCategoryGetAllResponseFromJson(
    Map<String, dynamic> json) {
  return _BusinessCategoryGetAllResponse.fromJson(json);
}

/// @nodoc
mixin _$BusinessCategoryGetAllResponse {
  @JsonKey(name: 'data')
  List<BusinessCategoryResponse>? get data =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'totalCount')
  int? get totalCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'page')
  int? get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'pageSize')
  int? get pageSize => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BusinessCategoryGetAllResponseCopyWith<BusinessCategoryGetAllResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessCategoryGetAllResponseCopyWith<$Res> {
  factory $BusinessCategoryGetAllResponseCopyWith(
          BusinessCategoryGetAllResponse value,
          $Res Function(BusinessCategoryGetAllResponse) then) =
      _$BusinessCategoryGetAllResponseCopyWithImpl<$Res,
          BusinessCategoryGetAllResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'data') List<BusinessCategoryResponse>? data,
      @JsonKey(name: 'totalCount') int? totalCount,
      @JsonKey(name: 'page') int? page,
      @JsonKey(name: 'pageSize') int? pageSize});
}

/// @nodoc
class _$BusinessCategoryGetAllResponseCopyWithImpl<$Res,
        $Val extends BusinessCategoryGetAllResponse>
    implements $BusinessCategoryGetAllResponseCopyWith<$Res> {
  _$BusinessCategoryGetAllResponseCopyWithImpl(this._value, this._then);

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
              as List<BusinessCategoryResponse>?,
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
abstract class _$$BusinessCategoryGetAllResponseImplCopyWith<$Res>
    implements $BusinessCategoryGetAllResponseCopyWith<$Res> {
  factory _$$BusinessCategoryGetAllResponseImplCopyWith(
          _$BusinessCategoryGetAllResponseImpl value,
          $Res Function(_$BusinessCategoryGetAllResponseImpl) then) =
      __$$BusinessCategoryGetAllResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'data') List<BusinessCategoryResponse>? data,
      @JsonKey(name: 'totalCount') int? totalCount,
      @JsonKey(name: 'page') int? page,
      @JsonKey(name: 'pageSize') int? pageSize});
}

/// @nodoc
class __$$BusinessCategoryGetAllResponseImplCopyWithImpl<$Res>
    extends _$BusinessCategoryGetAllResponseCopyWithImpl<$Res,
        _$BusinessCategoryGetAllResponseImpl>
    implements _$$BusinessCategoryGetAllResponseImplCopyWith<$Res> {
  __$$BusinessCategoryGetAllResponseImplCopyWithImpl(
      _$BusinessCategoryGetAllResponseImpl _value,
      $Res Function(_$BusinessCategoryGetAllResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? totalCount = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(_$BusinessCategoryGetAllResponseImpl(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<BusinessCategoryResponse>?,
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
class _$BusinessCategoryGetAllResponseImpl
    implements _BusinessCategoryGetAllResponse {
  const _$BusinessCategoryGetAllResponseImpl(
      {@JsonKey(name: 'data') final List<BusinessCategoryResponse>? data,
      @JsonKey(name: 'totalCount') this.totalCount,
      @JsonKey(name: 'page') this.page,
      @JsonKey(name: 'pageSize') this.pageSize})
      : _data = data;

  factory _$BusinessCategoryGetAllResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$BusinessCategoryGetAllResponseImplFromJson(json);

  final List<BusinessCategoryResponse>? _data;
  @override
  @JsonKey(name: 'data')
  List<BusinessCategoryResponse>? get data {
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
    return 'BusinessCategoryGetAllResponse(data: $data, totalCount: $totalCount, page: $page, pageSize: $pageSize)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessCategoryGetAllResponseImpl &&
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
  _$$BusinessCategoryGetAllResponseImplCopyWith<
          _$BusinessCategoryGetAllResponseImpl>
      get copyWith => __$$BusinessCategoryGetAllResponseImplCopyWithImpl<
          _$BusinessCategoryGetAllResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessCategoryGetAllResponseImplToJson(
      this,
    );
  }
}

abstract class _BusinessCategoryGetAllResponse
    implements BusinessCategoryGetAllResponse {
  const factory _BusinessCategoryGetAllResponse(
          {@JsonKey(name: 'data') final List<BusinessCategoryResponse>? data,
          @JsonKey(name: 'totalCount') final int? totalCount,
          @JsonKey(name: 'page') final int? page,
          @JsonKey(name: 'pageSize') final int? pageSize}) =
      _$BusinessCategoryGetAllResponseImpl;

  factory _BusinessCategoryGetAllResponse.fromJson(Map<String, dynamic> json) =
      _$BusinessCategoryGetAllResponseImpl.fromJson;

  @override
  @JsonKey(name: 'data')
  List<BusinessCategoryResponse>? get data;
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
  _$$BusinessCategoryGetAllResponseImplCopyWith<
          _$BusinessCategoryGetAllResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

BusinessCategoryResponse _$BusinessCategoryResponseFromJson(
    Map<String, dynamic> json) {
  return _BusinessCategoryResponse.fromJson(json);
}

/// @nodoc
mixin _$BusinessCategoryResponse {
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'subTabId')
  String? get subTabId => throw _privateConstructorUsedError;
  @JsonKey(name: 'categoryName')
  String? get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'memberId')
  String? get memberId => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'isInitialized')
  bool? get isInitialized => throw _privateConstructorUsedError;
  @JsonKey(name: 'enable')
  bool? get enable => throw _privateConstructorUsedError;
  @JsonKey(name: 'priority')
  int? get priority => throw _privateConstructorUsedError;
  @JsonKey(name: 'error')
  String? get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BusinessCategoryResponseCopyWith<BusinessCategoryResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessCategoryResponseCopyWith<$Res> {
  factory $BusinessCategoryResponseCopyWith(BusinessCategoryResponse value,
          $Res Function(BusinessCategoryResponse) then) =
      _$BusinessCategoryResponseCopyWithImpl<$Res, BusinessCategoryResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'subTabId') String? subTabId,
      @JsonKey(name: 'categoryName') String? categoryName,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'memberId') String? memberId,
      @JsonKey(name: 'type') String? type,
      @JsonKey(name: 'isInitialized') bool? isInitialized,
      @JsonKey(name: 'enable') bool? enable,
      @JsonKey(name: 'priority') int? priority,
      @JsonKey(name: 'error') String? error});
}

/// @nodoc
class _$BusinessCategoryResponseCopyWithImpl<$Res,
        $Val extends BusinessCategoryResponse>
    implements $BusinessCategoryResponseCopyWith<$Res> {
  _$BusinessCategoryResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? subTabId = freezed,
    Object? categoryName = freezed,
    Object? description = freezed,
    Object? memberId = freezed,
    Object? type = freezed,
    Object? isInitialized = freezed,
    Object? enable = freezed,
    Object? priority = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      subTabId: freezed == subTabId
          ? _value.subTabId
          : subTabId // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      memberId: freezed == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      isInitialized: freezed == isInitialized
          ? _value.isInitialized
          : isInitialized // ignore: cast_nullable_to_non_nullable
              as bool?,
      enable: freezed == enable
          ? _value.enable
          : enable // ignore: cast_nullable_to_non_nullable
              as bool?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BusinessCategoryResponseImplCopyWith<$Res>
    implements $BusinessCategoryResponseCopyWith<$Res> {
  factory _$$BusinessCategoryResponseImplCopyWith(
          _$BusinessCategoryResponseImpl value,
          $Res Function(_$BusinessCategoryResponseImpl) then) =
      __$$BusinessCategoryResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'subTabId') String? subTabId,
      @JsonKey(name: 'categoryName') String? categoryName,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'memberId') String? memberId,
      @JsonKey(name: 'type') String? type,
      @JsonKey(name: 'isInitialized') bool? isInitialized,
      @JsonKey(name: 'enable') bool? enable,
      @JsonKey(name: 'priority') int? priority,
      @JsonKey(name: 'error') String? error});
}

/// @nodoc
class __$$BusinessCategoryResponseImplCopyWithImpl<$Res>
    extends _$BusinessCategoryResponseCopyWithImpl<$Res,
        _$BusinessCategoryResponseImpl>
    implements _$$BusinessCategoryResponseImplCopyWith<$Res> {
  __$$BusinessCategoryResponseImplCopyWithImpl(
      _$BusinessCategoryResponseImpl _value,
      $Res Function(_$BusinessCategoryResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? subTabId = freezed,
    Object? categoryName = freezed,
    Object? description = freezed,
    Object? memberId = freezed,
    Object? type = freezed,
    Object? isInitialized = freezed,
    Object? enable = freezed,
    Object? priority = freezed,
    Object? error = freezed,
  }) {
    return _then(_$BusinessCategoryResponseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      subTabId: freezed == subTabId
          ? _value.subTabId
          : subTabId // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      memberId: freezed == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      isInitialized: freezed == isInitialized
          ? _value.isInitialized
          : isInitialized // ignore: cast_nullable_to_non_nullable
              as bool?,
      enable: freezed == enable
          ? _value.enable
          : enable // ignore: cast_nullable_to_non_nullable
              as bool?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BusinessCategoryResponseImpl implements _BusinessCategoryResponse {
  const _$BusinessCategoryResponseImpl(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'subTabId') this.subTabId,
      @JsonKey(name: 'categoryName') this.categoryName,
      @JsonKey(name: 'description') this.description,
      @JsonKey(name: 'memberId') this.memberId,
      @JsonKey(name: 'type') this.type,
      @JsonKey(name: 'isInitialized') this.isInitialized,
      @JsonKey(name: 'enable') this.enable,
      @JsonKey(name: 'priority') this.priority,
      @JsonKey(name: 'error') this.error});

  factory _$BusinessCategoryResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessCategoryResponseImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'subTabId')
  final String? subTabId;
  @override
  @JsonKey(name: 'categoryName')
  final String? categoryName;
  @override
  @JsonKey(name: 'description')
  final String? description;
  @override
  @JsonKey(name: 'memberId')
  final String? memberId;
  @override
  @JsonKey(name: 'type')
  final String? type;
  @override
  @JsonKey(name: 'isInitialized')
  final bool? isInitialized;
  @override
  @JsonKey(name: 'enable')
  final bool? enable;
  @override
  @JsonKey(name: 'priority')
  final int? priority;
  @override
  @JsonKey(name: 'error')
  final String? error;

  @override
  String toString() {
    return 'BusinessCategoryResponse(id: $id, subTabId: $subTabId, categoryName: $categoryName, description: $description, memberId: $memberId, type: $type, isInitialized: $isInitialized, enable: $enable, priority: $priority, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessCategoryResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.subTabId, subTabId) ||
                other.subTabId == subTabId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isInitialized, isInitialized) ||
                other.isInitialized == isInitialized) &&
            (identical(other.enable, enable) || other.enable == enable) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, subTabId, categoryName,
      description, memberId, type, isInitialized, enable, priority, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessCategoryResponseImplCopyWith<_$BusinessCategoryResponseImpl>
      get copyWith => __$$BusinessCategoryResponseImplCopyWithImpl<
          _$BusinessCategoryResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessCategoryResponseImplToJson(
      this,
    );
  }
}

abstract class _BusinessCategoryResponse implements BusinessCategoryResponse {
  const factory _BusinessCategoryResponse(
          {@JsonKey(name: 'id') final String? id,
          @JsonKey(name: 'subTabId') final String? subTabId,
          @JsonKey(name: 'categoryName') final String? categoryName,
          @JsonKey(name: 'description') final String? description,
          @JsonKey(name: 'memberId') final String? memberId,
          @JsonKey(name: 'type') final String? type,
          @JsonKey(name: 'isInitialized') final bool? isInitialized,
          @JsonKey(name: 'enable') final bool? enable,
          @JsonKey(name: 'priority') final int? priority,
          @JsonKey(name: 'error') final String? error}) =
      _$BusinessCategoryResponseImpl;

  factory _BusinessCategoryResponse.fromJson(Map<String, dynamic> json) =
      _$BusinessCategoryResponseImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'subTabId')
  String? get subTabId;
  @override
  @JsonKey(name: 'categoryName')
  String? get categoryName;
  @override
  @JsonKey(name: 'description')
  String? get description;
  @override
  @JsonKey(name: 'memberId')
  String? get memberId;
  @override
  @JsonKey(name: 'type')
  String? get type;
  @override
  @JsonKey(name: 'isInitialized')
  bool? get isInitialized;
  @override
  @JsonKey(name: 'enable')
  bool? get enable;
  @override
  @JsonKey(name: 'priority')
  int? get priority;
  @override
  @JsonKey(name: 'error')
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$BusinessCategoryResponseImplCopyWith<_$BusinessCategoryResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
