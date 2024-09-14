// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String?,
      propertyId: json['propertyId'] as String?,
      name: json['name'] as String?,
      sku: json['sku'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      salePrice: (json['salePrice'] as num?)?.toDouble(),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      productPropertyImage: json['productPropertyImage'] as String?,
      productPropertyName: json['productPropertyName'] as String?,
      agency: json['agency'],
      hidden: json['hidden'],
      groupProductId: json['groupProductId'],
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'propertyId': instance.propertyId,
      'name': instance.name,
      'sku': instance.sku,
      'price': instance.price,
      'salePrice': instance.salePrice,
      'images': instance.images,
      'productPropertyImage': instance.productPropertyImage,
      'productPropertyName': instance.productPropertyName,
      'agency': instance.agency,
      'hidden': instance.hidden,
      'groupProductId': instance.groupProductId,
    };
