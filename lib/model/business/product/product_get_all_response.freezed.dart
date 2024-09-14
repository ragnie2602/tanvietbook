// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_get_all_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProductGetAllResponse _$ProductGetAllResponseFromJson(
    Map<String, dynamic> json) {
  return _ProductGetAllResponse.fromJson(json);
}

/// @nodoc
mixin _$ProductGetAllResponse {
  @JsonKey(name: 'data')
  List<ProductDetailResponse>? get data => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalCount')
  int? get totalCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'page')
  int? get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'pageSize')
  int? get pageSize => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductGetAllResponseCopyWith<ProductGetAllResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductGetAllResponseCopyWith<$Res> {
  factory $ProductGetAllResponseCopyWith(ProductGetAllResponse value,
          $Res Function(ProductGetAllResponse) then) =
      _$ProductGetAllResponseCopyWithImpl<$Res, ProductGetAllResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'data') List<ProductDetailResponse>? data,
      @JsonKey(name: 'totalCount') int? totalCount,
      @JsonKey(name: 'page') int? page,
      @JsonKey(name: 'pageSize') int? pageSize});
}

/// @nodoc
class _$ProductGetAllResponseCopyWithImpl<$Res,
        $Val extends ProductGetAllResponse>
    implements $ProductGetAllResponseCopyWith<$Res> {
  _$ProductGetAllResponseCopyWithImpl(this._value, this._then);

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
              as List<ProductDetailResponse>?,
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
abstract class _$$ProductGetAllResponseImplCopyWith<$Res>
    implements $ProductGetAllResponseCopyWith<$Res> {
  factory _$$ProductGetAllResponseImplCopyWith(
          _$ProductGetAllResponseImpl value,
          $Res Function(_$ProductGetAllResponseImpl) then) =
      __$$ProductGetAllResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'data') List<ProductDetailResponse>? data,
      @JsonKey(name: 'totalCount') int? totalCount,
      @JsonKey(name: 'page') int? page,
      @JsonKey(name: 'pageSize') int? pageSize});
}

/// @nodoc
class __$$ProductGetAllResponseImplCopyWithImpl<$Res>
    extends _$ProductGetAllResponseCopyWithImpl<$Res,
        _$ProductGetAllResponseImpl>
    implements _$$ProductGetAllResponseImplCopyWith<$Res> {
  __$$ProductGetAllResponseImplCopyWithImpl(_$ProductGetAllResponseImpl _value,
      $Res Function(_$ProductGetAllResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? totalCount = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(_$ProductGetAllResponseImpl(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ProductDetailResponse>?,
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
class _$ProductGetAllResponseImpl implements _ProductGetAllResponse {
  const _$ProductGetAllResponseImpl(
      {@JsonKey(name: 'data') final List<ProductDetailResponse>? data,
      @JsonKey(name: 'totalCount') this.totalCount,
      @JsonKey(name: 'page') this.page,
      @JsonKey(name: 'pageSize') this.pageSize})
      : _data = data;

  factory _$ProductGetAllResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductGetAllResponseImplFromJson(json);

  final List<ProductDetailResponse>? _data;
  @override
  @JsonKey(name: 'data')
  List<ProductDetailResponse>? get data {
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
    return 'ProductGetAllResponse(data: $data, totalCount: $totalCount, page: $page, pageSize: $pageSize)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductGetAllResponseImpl &&
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
  _$$ProductGetAllResponseImplCopyWith<_$ProductGetAllResponseImpl>
      get copyWith => __$$ProductGetAllResponseImplCopyWithImpl<
          _$ProductGetAllResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductGetAllResponseImplToJson(
      this,
    );
  }
}

abstract class _ProductGetAllResponse implements ProductGetAllResponse {
  const factory _ProductGetAllResponse(
          {@JsonKey(name: 'data') final List<ProductDetailResponse>? data,
          @JsonKey(name: 'totalCount') final int? totalCount,
          @JsonKey(name: 'page') final int? page,
          @JsonKey(name: 'pageSize') final int? pageSize}) =
      _$ProductGetAllResponseImpl;

  factory _ProductGetAllResponse.fromJson(Map<String, dynamic> json) =
      _$ProductGetAllResponseImpl.fromJson;

  @override
  @JsonKey(name: 'data')
  List<ProductDetailResponse>? get data;
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
  _$$ProductGetAllResponseImplCopyWith<_$ProductGetAllResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
