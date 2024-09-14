// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_cart_product_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgencyCartProductEntityImpl _$$AgencyCartProductEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$AgencyCartProductEntityImpl(
      id: json['id'] as String?,
      propertyId: json['propertyId'] as String?,
      name: json['name'] as String?,
      price: json['price'] as int?,
      salePrice: json['salePrice'] as int?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      productPropertyImage: json['productPropertyImage'] as String?,
      productPropertyName: json['productPropertyName'] as String?,
      hidden: json['hidden'] as bool?,
      weight: json['weight'] as num?,
      length: json['length'] as num?,
      height: json['height'] as num?,
      width: json['width'] as num?,
    );

Map<String, dynamic> _$$AgencyCartProductEntityImplToJson(
        _$AgencyCartProductEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'propertyId': instance.propertyId,
      'name': instance.name,
      'price': instance.price,
      'salePrice': instance.salePrice,
      'images': instance.images,
      'productPropertyImage': instance.productPropertyImage,
      'productPropertyName': instance.productPropertyName,
      'hidden': instance.hidden,
      'weight': instance.weight,
      'length': instance.length,
      'height': instance.height,
      'width': instance.width,
    };
