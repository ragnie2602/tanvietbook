// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgencyProductImpl _$$AgencyProductImplFromJson(Map<String, dynamic> json) =>
    _$AgencyProductImpl(
      id: json['id'] as String?,
      sku: json['sku'] as String?,
      name: json['name'] as String?,
      status: json['status'] as int?,
      price: json['price'] as int?,
      priceStr: json['priceStr'] as String?,
      salePrice: json['salePrice'] as int?,
      salePriceStr: json['salePriceStr'] as String?,
      description: json['description'] as String?,
      titleVideo: json['titleVideo'] as String?,
      urlVideo: json['urlVideo'] as String?,
      feeShip: json['feeShip'] as int?,
      feeShipStr: json['feeShipStr'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => AgencyProductImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      productProperties: (json['productProperties'] as List<dynamic>?)
          ?.map(
              (e) => AgencyProductProperty.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      groupProdName: json['groupProdName'] as String?,
      hidden: json['hidden'] as bool?,
      weight: json['weight'] as num?,
      length: json['length'] as num?,
      width: json['width'] as num?,
      height: json['height'] as num?,
    );

Map<String, dynamic> _$$AgencyProductImplToJson(_$AgencyProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'name': instance.name,
      'status': instance.status,
      'price': instance.price,
      'priceStr': instance.priceStr,
      'salePrice': instance.salePrice,
      'salePriceStr': instance.salePriceStr,
      'description': instance.description,
      'titleVideo': instance.titleVideo,
      'urlVideo': instance.urlVideo,
      'feeShip': instance.feeShip,
      'feeShipStr': instance.feeShipStr,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'productProperties':
          instance.productProperties?.map((e) => e.toJson()).toList(),
      'createdDate': instance.createdDate?.toIso8601String(),
      'groupProdName': instance.groupProdName,
      'hidden': instance.hidden,
      'weight': instance.weight,
      'length': instance.length,
      'width': instance.width,
      'height': instance.height,
    };

_$AgencyProductImageImpl _$$AgencyProductImageImplFromJson(
        Map<String, dynamic> json) =>
    _$AgencyProductImageImpl(
      id: json['id'] as String?,
      productId: json['productId'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$$AgencyProductImageImplToJson(
        _$AgencyProductImageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'image': instance.image,
    };

_$AgencyProductPropertyImpl _$$AgencyProductPropertyImplFromJson(
        Map<String, dynamic> json) =>
    _$AgencyProductPropertyImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      productId: json['productId'] as String?,
      createdDate: json['createdDate'] as String?,
    );

Map<String, dynamic> _$$AgencyProductPropertyImplToJson(
        _$AgencyProductPropertyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'productId': instance.productId,
      'createdDate': instance.createdDate,
    };
