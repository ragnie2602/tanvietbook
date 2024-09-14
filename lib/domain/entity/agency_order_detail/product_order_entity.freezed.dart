// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_order_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProductOrderEntity _$ProductOrderEntityFromJson(Map<String, dynamic> json) {
  return _ProductOrderEntity.fromJson(json);
}

/// @nodoc
mixin _$ProductOrderEntity {
  int? get amount => throw _privateConstructorUsedError;
  String? get productName => throw _privateConstructorUsedError;
  String? get productPropertyId => throw _privateConstructorUsedError;
  String? get productPropertyName => throw _privateConstructorUsedError;
  double? get productPropertyPrice => throw _privateConstructorUsedError;
  double? get productPropertySalePrice => throw _privateConstructorUsedError;
  String? get productPropertyImage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductOrderEntityCopyWith<ProductOrderEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductOrderEntityCopyWith<$Res> {
  factory $ProductOrderEntityCopyWith(
          ProductOrderEntity value, $Res Function(ProductOrderEntity) then) =
      _$ProductOrderEntityCopyWithImpl<$Res, ProductOrderEntity>;
  @useResult
  $Res call(
      {int? amount,
      String? productName,
      String? productPropertyId,
      String? productPropertyName,
      double? productPropertyPrice,
      double? productPropertySalePrice,
      String? productPropertyImage});
}

/// @nodoc
class _$ProductOrderEntityCopyWithImpl<$Res, $Val extends ProductOrderEntity>
    implements $ProductOrderEntityCopyWith<$Res> {
  _$ProductOrderEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? productName = freezed,
    Object? productPropertyId = freezed,
    Object? productPropertyName = freezed,
    Object? productPropertyPrice = freezed,
    Object? productPropertySalePrice = freezed,
    Object? productPropertyImage = freezed,
  }) {
    return _then(_value.copyWith(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      productPropertyId: freezed == productPropertyId
          ? _value.productPropertyId
          : productPropertyId // ignore: cast_nullable_to_non_nullable
              as String?,
      productPropertyName: freezed == productPropertyName
          ? _value.productPropertyName
          : productPropertyName // ignore: cast_nullable_to_non_nullable
              as String?,
      productPropertyPrice: freezed == productPropertyPrice
          ? _value.productPropertyPrice
          : productPropertyPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      productPropertySalePrice: freezed == productPropertySalePrice
          ? _value.productPropertySalePrice
          : productPropertySalePrice // ignore: cast_nullable_to_non_nullable
              as double?,
      productPropertyImage: freezed == productPropertyImage
          ? _value.productPropertyImage
          : productPropertyImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductOrderEntityImplCopyWith<$Res>
    implements $ProductOrderEntityCopyWith<$Res> {
  factory _$$ProductOrderEntityImplCopyWith(_$ProductOrderEntityImpl value,
          $Res Function(_$ProductOrderEntityImpl) then) =
      __$$ProductOrderEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? amount,
      String? productName,
      String? productPropertyId,
      String? productPropertyName,
      double? productPropertyPrice,
      double? productPropertySalePrice,
      String? productPropertyImage});
}

/// @nodoc
class __$$ProductOrderEntityImplCopyWithImpl<$Res>
    extends _$ProductOrderEntityCopyWithImpl<$Res, _$ProductOrderEntityImpl>
    implements _$$ProductOrderEntityImplCopyWith<$Res> {
  __$$ProductOrderEntityImplCopyWithImpl(_$ProductOrderEntityImpl _value,
      $Res Function(_$ProductOrderEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? productName = freezed,
    Object? productPropertyId = freezed,
    Object? productPropertyName = freezed,
    Object? productPropertyPrice = freezed,
    Object? productPropertySalePrice = freezed,
    Object? productPropertyImage = freezed,
  }) {
    return _then(_$ProductOrderEntityImpl(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      productPropertyId: freezed == productPropertyId
          ? _value.productPropertyId
          : productPropertyId // ignore: cast_nullable_to_non_nullable
              as String?,
      productPropertyName: freezed == productPropertyName
          ? _value.productPropertyName
          : productPropertyName // ignore: cast_nullable_to_non_nullable
              as String?,
      productPropertyPrice: freezed == productPropertyPrice
          ? _value.productPropertyPrice
          : productPropertyPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      productPropertySalePrice: freezed == productPropertySalePrice
          ? _value.productPropertySalePrice
          : productPropertySalePrice // ignore: cast_nullable_to_non_nullable
              as double?,
      productPropertyImage: freezed == productPropertyImage
          ? _value.productPropertyImage
          : productPropertyImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductOrderEntityImpl implements _ProductOrderEntity {
  _$ProductOrderEntityImpl(
      {this.amount,
      this.productName,
      this.productPropertyId,
      this.productPropertyName,
      this.productPropertyPrice,
      this.productPropertySalePrice,
      this.productPropertyImage});

  factory _$ProductOrderEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductOrderEntityImplFromJson(json);

  @override
  final int? amount;
  @override
  final String? productName;
  @override
  final String? productPropertyId;
  @override
  final String? productPropertyName;
  @override
  final double? productPropertyPrice;
  @override
  final double? productPropertySalePrice;
  @override
  final String? productPropertyImage;

  @override
  String toString() {
    return 'ProductOrderEntity(amount: $amount, productName: $productName, productPropertyId: $productPropertyId, productPropertyName: $productPropertyName, productPropertyPrice: $productPropertyPrice, productPropertySalePrice: $productPropertySalePrice, productPropertyImage: $productPropertyImage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductOrderEntityImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.productPropertyId, productPropertyId) ||
                other.productPropertyId == productPropertyId) &&
            (identical(other.productPropertyName, productPropertyName) ||
                other.productPropertyName == productPropertyName) &&
            (identical(other.productPropertyPrice, productPropertyPrice) ||
                other.productPropertyPrice == productPropertyPrice) &&
            (identical(
                    other.productPropertySalePrice, productPropertySalePrice) ||
                other.productPropertySalePrice == productPropertySalePrice) &&
            (identical(other.productPropertyImage, productPropertyImage) ||
                other.productPropertyImage == productPropertyImage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      amount,
      productName,
      productPropertyId,
      productPropertyName,
      productPropertyPrice,
      productPropertySalePrice,
      productPropertyImage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductOrderEntityImplCopyWith<_$ProductOrderEntityImpl> get copyWith =>
      __$$ProductOrderEntityImplCopyWithImpl<_$ProductOrderEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductOrderEntityImplToJson(
      this,
    );
  }
}

abstract class _ProductOrderEntity implements ProductOrderEntity {
  factory _ProductOrderEntity(
      {final int? amount,
      final String? productName,
      final String? productPropertyId,
      final String? productPropertyName,
      final double? productPropertyPrice,
      final double? productPropertySalePrice,
      final String? productPropertyImage}) = _$ProductOrderEntityImpl;

  factory _ProductOrderEntity.fromJson(Map<String, dynamic> json) =
      _$ProductOrderEntityImpl.fromJson;

  @override
  int? get amount;
  @override
  String? get productName;
  @override
  String? get productPropertyId;
  @override
  String? get productPropertyName;
  @override
  double? get productPropertyPrice;
  @override
  double? get productPropertySalePrice;
  @override
  String? get productPropertyImage;
  @override
  @JsonKey(ignore: true)
  _$$ProductOrderEntityImplCopyWith<_$ProductOrderEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
