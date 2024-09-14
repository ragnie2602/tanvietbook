// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agency_cart_item_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AgencyCartItemEntity _$AgencyCartItemEntityFromJson(Map<String, dynamic> json) {
  return _AgencyCartItemEntity.fromJson(json);
}

/// @nodoc
mixin _$AgencyCartItemEntity {
  String? get id => throw _privateConstructorUsedError;
  set id(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  set userId(String? value) => throw _privateConstructorUsedError;
  String? get createdDate => throw _privateConstructorUsedError;
  set createdDate(String? value) => throw _privateConstructorUsedError;
  int? get amount => throw _privateConstructorUsedError;
  set amount(int? value) => throw _privateConstructorUsedError;
  AgencyCartProductEntity? get product => throw _privateConstructorUsedError;
  set product(AgencyCartProductEntity? value) =>
      throw _privateConstructorUsedError;
  num? get totalLength => throw _privateConstructorUsedError;
  set totalLength(num? value) => throw _privateConstructorUsedError;
  num? get totalWidth => throw _privateConstructorUsedError;
  set totalWidth(num? value) => throw _privateConstructorUsedError;
  num? get totalHeight => throw _privateConstructorUsedError;
  set totalHeight(num? value) => throw _privateConstructorUsedError;
  num? get totalWeight => throw _privateConstructorUsedError;
  set totalWeight(num? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgencyCartItemEntityCopyWith<AgencyCartItemEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgencyCartItemEntityCopyWith<$Res> {
  factory $AgencyCartItemEntityCopyWith(AgencyCartItemEntity value,
          $Res Function(AgencyCartItemEntity) then) =
      _$AgencyCartItemEntityCopyWithImpl<$Res, AgencyCartItemEntity>;
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'user_id') String? userId,
      String? createdDate,
      int? amount,
      AgencyCartProductEntity? product,
      num? totalLength,
      num? totalWidth,
      num? totalHeight,
      num? totalWeight});

  $AgencyCartProductEntityCopyWith<$Res>? get product;
}

/// @nodoc
class _$AgencyCartItemEntityCopyWithImpl<$Res,
        $Val extends AgencyCartItemEntity>
    implements $AgencyCartItemEntityCopyWith<$Res> {
  _$AgencyCartItemEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? createdDate = freezed,
    Object? amount = freezed,
    Object? product = freezed,
    Object? totalLength = freezed,
    Object? totalWidth = freezed,
    Object? totalHeight = freezed,
    Object? totalWeight = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as AgencyCartProductEntity?,
      totalLength: freezed == totalLength
          ? _value.totalLength
          : totalLength // ignore: cast_nullable_to_non_nullable
              as num?,
      totalWidth: freezed == totalWidth
          ? _value.totalWidth
          : totalWidth // ignore: cast_nullable_to_non_nullable
              as num?,
      totalHeight: freezed == totalHeight
          ? _value.totalHeight
          : totalHeight // ignore: cast_nullable_to_non_nullable
              as num?,
      totalWeight: freezed == totalWeight
          ? _value.totalWeight
          : totalWeight // ignore: cast_nullable_to_non_nullable
              as num?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AgencyCartProductEntityCopyWith<$Res>? get product {
    if (_value.product == null) {
      return null;
    }

    return $AgencyCartProductEntityCopyWith<$Res>(_value.product!, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AgencyCartItemEntityImplCopyWith<$Res>
    implements $AgencyCartItemEntityCopyWith<$Res> {
  factory _$$AgencyCartItemEntityImplCopyWith(_$AgencyCartItemEntityImpl value,
          $Res Function(_$AgencyCartItemEntityImpl) then) =
      __$$AgencyCartItemEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      @JsonKey(name: 'user_id') String? userId,
      String? createdDate,
      int? amount,
      AgencyCartProductEntity? product,
      num? totalLength,
      num? totalWidth,
      num? totalHeight,
      num? totalWeight});

  @override
  $AgencyCartProductEntityCopyWith<$Res>? get product;
}

/// @nodoc
class __$$AgencyCartItemEntityImplCopyWithImpl<$Res>
    extends _$AgencyCartItemEntityCopyWithImpl<$Res, _$AgencyCartItemEntityImpl>
    implements _$$AgencyCartItemEntityImplCopyWith<$Res> {
  __$$AgencyCartItemEntityImplCopyWithImpl(_$AgencyCartItemEntityImpl _value,
      $Res Function(_$AgencyCartItemEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? createdDate = freezed,
    Object? amount = freezed,
    Object? product = freezed,
    Object? totalLength = freezed,
    Object? totalWidth = freezed,
    Object? totalHeight = freezed,
    Object? totalWeight = freezed,
  }) {
    return _then(_$AgencyCartItemEntityImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as AgencyCartProductEntity?,
      totalLength: freezed == totalLength
          ? _value.totalLength
          : totalLength // ignore: cast_nullable_to_non_nullable
              as num?,
      totalWidth: freezed == totalWidth
          ? _value.totalWidth
          : totalWidth // ignore: cast_nullable_to_non_nullable
              as num?,
      totalHeight: freezed == totalHeight
          ? _value.totalHeight
          : totalHeight // ignore: cast_nullable_to_non_nullable
              as num?,
      totalWeight: freezed == totalWeight
          ? _value.totalWeight
          : totalWeight // ignore: cast_nullable_to_non_nullable
              as num?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgencyCartItemEntityImpl implements _AgencyCartItemEntity {
  _$AgencyCartItemEntityImpl(
      {this.id,
      @JsonKey(name: 'user_id') this.userId,
      this.createdDate,
      this.amount,
      this.product,
      this.totalLength,
      this.totalWidth,
      this.totalHeight,
      this.totalWeight});

  factory _$AgencyCartItemEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgencyCartItemEntityImplFromJson(json);

  @override
  String? id;
  @override
  @JsonKey(name: 'user_id')
  String? userId;
  @override
  String? createdDate;
  @override
  int? amount;
  @override
  AgencyCartProductEntity? product;
  @override
  num? totalLength;
  @override
  num? totalWidth;
  @override
  num? totalHeight;
  @override
  num? totalWeight;

  @override
  String toString() {
    return 'AgencyCartItemEntity(id: $id, userId: $userId, createdDate: $createdDate, amount: $amount, product: $product, totalLength: $totalLength, totalWidth: $totalWidth, totalHeight: $totalHeight, totalWeight: $totalWeight)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgencyCartItemEntityImplCopyWith<_$AgencyCartItemEntityImpl>
      get copyWith =>
          __$$AgencyCartItemEntityImplCopyWithImpl<_$AgencyCartItemEntityImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgencyCartItemEntityImplToJson(
      this,
    );
  }
}

abstract class _AgencyCartItemEntity implements AgencyCartItemEntity {
  factory _AgencyCartItemEntity(
      {String? id,
      @JsonKey(name: 'user_id') String? userId,
      String? createdDate,
      int? amount,
      AgencyCartProductEntity? product,
      num? totalLength,
      num? totalWidth,
      num? totalHeight,
      num? totalWeight}) = _$AgencyCartItemEntityImpl;

  factory _AgencyCartItemEntity.fromJson(Map<String, dynamic> json) =
      _$AgencyCartItemEntityImpl.fromJson;

  @override
  String? get id;
  set id(String? value);
  @override
  @JsonKey(name: 'user_id')
  String? get userId;
  @JsonKey(name: 'user_id')
  set userId(String? value);
  @override
  String? get createdDate;
  set createdDate(String? value);
  @override
  int? get amount;
  set amount(int? value);
  @override
  AgencyCartProductEntity? get product;
  set product(AgencyCartProductEntity? value);
  @override
  num? get totalLength;
  set totalLength(num? value);
  @override
  num? get totalWidth;
  set totalWidth(num? value);
  @override
  num? get totalHeight;
  set totalHeight(num? value);
  @override
  num? get totalWeight;
  set totalWeight(num? value);
  @override
  @JsonKey(ignore: true)
  _$$AgencyCartItemEntityImplCopyWith<_$AgencyCartItemEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
