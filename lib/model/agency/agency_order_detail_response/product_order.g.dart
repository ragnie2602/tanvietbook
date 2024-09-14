// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductOrderImpl _$$ProductOrderImplFromJson(Map<String, dynamic> json) =>
    _$ProductOrderImpl(
      amount: json['amount'] as int?,
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      discountAmount: json['discountAmount'],
      discountCode: json['discountCode'],
      productPropertyId: json['productPropertyId'] as String?,
    );

Map<String, dynamic> _$$ProductOrderImplToJson(_$ProductOrderImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'product': instance.product?.toJson(),
      'discountAmount': instance.discountAmount,
      'discountCode': instance.discountCode,
      'productPropertyId': instance.productPropertyId,
    };
