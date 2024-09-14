// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_order_c.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductOrderCImpl _$$ProductOrderCImplFromJson(Map<String, dynamic> json) =>
    _$ProductOrderCImpl(
      amount: json['amount'] as int?,
      productPropertyId: json['productPropertyId'] as String?,
      discountAmount: json['discountAmount'] as int?,
      discountCode: json['discountCode'] as String?,
    );

Map<String, dynamic> _$$ProductOrderCImplToJson(_$ProductOrderCImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'productPropertyId': instance.productPropertyId,
      'discountAmount': instance.discountAmount,
      'discountCode': instance.discountCode,
    };
