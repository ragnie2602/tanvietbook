// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_order_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductOrderEntityImpl _$$ProductOrderEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductOrderEntityImpl(
      amount: json['amount'] as int?,
      productName: json['productName'] as String?,
      productPropertyId: json['productPropertyId'] as String?,
      productPropertyName: json['productPropertyName'] as String?,
      productPropertyPrice: (json['productPropertyPrice'] as num?)?.toDouble(),
      productPropertySalePrice:
          (json['productPropertySalePrice'] as num?)?.toDouble(),
      productPropertyImage: json['productPropertyImage'] as String?,
    );

Map<String, dynamic> _$$ProductOrderEntityImplToJson(
        _$ProductOrderEntityImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'productName': instance.productName,
      'productPropertyId': instance.productPropertyId,
      'productPropertyName': instance.productPropertyName,
      'productPropertyPrice': instance.productPropertyPrice,
      'productPropertySalePrice': instance.productPropertySalePrice,
      'productPropertyImage': instance.productPropertyImage,
    };
