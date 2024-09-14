// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProductOrder _$ProductOrderFromJson(Map<String, dynamic> json) {
  return _ProductOrder.fromJson(json);
}

/// @nodoc
mixin _$ProductOrder {
  int? get amount => throw _privateConstructorUsedError;
  Product? get product => throw _privateConstructorUsedError;
  dynamic get discountAmount => throw _privateConstructorUsedError;
  dynamic get discountCode => throw _privateConstructorUsedError;
  String? get productPropertyId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductOrderCopyWith<ProductOrder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductOrderCopyWith<$Res> {
  factory $ProductOrderCopyWith(
          ProductOrder value, $Res Function(ProductOrder) then) =
      _$ProductOrderCopyWithImpl<$Res, ProductOrder>;
  @useResult
  $Res call(
      {int? amount,
      Product? product,
      dynamic discountAmount,
      dynamic discountCode,
      String? productPropertyId});

  $ProductCopyWith<$Res>? get product;
}

/// @nodoc
class _$ProductOrderCopyWithImpl<$Res, $Val extends ProductOrder>
    implements $ProductOrderCopyWith<$Res> {
  _$ProductOrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? product = freezed,
    Object? discountAmount = freezed,
    Object? discountCode = freezed,
    Object? productPropertyId = freezed,
  }) {
    return _then(_value.copyWith(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as dynamic,
      discountCode: freezed == discountCode
          ? _value.discountCode
          : discountCode // ignore: cast_nullable_to_non_nullable
              as dynamic,
      productPropertyId: freezed == productPropertyId
          ? _value.productPropertyId
          : productPropertyId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res>? get product {
    if (_value.product == null) {
      return null;
    }

    return $ProductCopyWith<$Res>(_value.product!, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductOrderImplCopyWith<$Res>
    implements $ProductOrderCopyWith<$Res> {
  factory _$$ProductOrderImplCopyWith(
          _$ProductOrderImpl value, $Res Function(_$ProductOrderImpl) then) =
      __$$ProductOrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? amount,
      Product? product,
      dynamic discountAmount,
      dynamic discountCode,
      String? productPropertyId});

  @override
  $ProductCopyWith<$Res>? get product;
}

/// @nodoc
class __$$ProductOrderImplCopyWithImpl<$Res>
    extends _$ProductOrderCopyWithImpl<$Res, _$ProductOrderImpl>
    implements _$$ProductOrderImplCopyWith<$Res> {
  __$$ProductOrderImplCopyWithImpl(
      _$ProductOrderImpl _value, $Res Function(_$ProductOrderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? product = freezed,
    Object? discountAmount = freezed,
    Object? discountCode = freezed,
    Object? productPropertyId = freezed,
  }) {
    return _then(_$ProductOrderImpl(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as dynamic,
      discountCode: freezed == discountCode
          ? _value.discountCode
          : discountCode // ignore: cast_nullable_to_non_nullable
              as dynamic,
      productPropertyId: freezed == productPropertyId
          ? _value.productPropertyId
          : productPropertyId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductOrderImpl implements _ProductOrder {
  _$ProductOrderImpl(
      {this.amount,
      this.product,
      this.discountAmount,
      this.discountCode,
      this.productPropertyId});

  factory _$ProductOrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductOrderImplFromJson(json);

  @override
  final int? amount;
  @override
  final Product? product;
  @override
  final dynamic discountAmount;
  @override
  final dynamic discountCode;
  @override
  final String? productPropertyId;

  @override
  String toString() {
    return 'ProductOrder(amount: $amount, product: $product, discountAmount: $discountAmount, discountCode: $discountCode, productPropertyId: $productPropertyId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductOrderImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.product, product) || other.product == product) &&
            const DeepCollectionEquality()
                .equals(other.discountAmount, discountAmount) &&
            const DeepCollectionEquality()
                .equals(other.discountCode, discountCode) &&
            (identical(other.productPropertyId, productPropertyId) ||
                other.productPropertyId == productPropertyId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      amount,
      product,
      const DeepCollectionEquality().hash(discountAmount),
      const DeepCollectionEquality().hash(discountCode),
      productPropertyId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductOrderImplCopyWith<_$ProductOrderImpl> get copyWith =>
      __$$ProductOrderImplCopyWithImpl<_$ProductOrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductOrderImplToJson(
      this,
    );
  }
}

abstract class _ProductOrder implements ProductOrder {
  factory _ProductOrder(
      {final int? amount,
      final Product? product,
      final dynamic discountAmount,
      final dynamic discountCode,
      final String? productPropertyId}) = _$ProductOrderImpl;

  factory _ProductOrder.fromJson(Map<String, dynamic> json) =
      _$ProductOrderImpl.fromJson;

  @override
  int? get amount;
  @override
  Product? get product;
  @override
  dynamic get discountAmount;
  @override
  dynamic get discountCode;
  @override
  String? get productPropertyId;
  @override
  @JsonKey(ignore: true)
  _$$ProductOrderImplCopyWith<_$ProductOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
