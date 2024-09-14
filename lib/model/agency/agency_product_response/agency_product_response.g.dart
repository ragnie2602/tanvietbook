// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgencyProductResponseImpl _$$AgencyProductResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AgencyProductResponseImpl(
      id: json['id'] as String?,
      sku: json['sku'] as String?,
      name: json['name'] as String?,
      status: json['status'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      salePrice: (json['salePrice'] as num?)?.toDouble(),
      description: json['description'] as String?,
      titleVideo: json['titleVideo'] as String?,
      urlVideo: json['urlVideo'] as String?,
      feeShip: (json['feeShip'] as num?)?.toDouble(),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) =>
              AgencyProductImageResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      productProperties: (json['productProperties'] as List<dynamic>?)
          ?.map((e) =>
              AgencyProductPropertyResponse.fromJson(e as Map<String, dynamic>))
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

Map<String, dynamic> _$$AgencyProductResponseImplToJson(
        _$AgencyProductResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'name': instance.name,
      'status': instance.status,
      'price': instance.price,
      'salePrice': instance.salePrice,
      'description': instance.description,
      'titleVideo': instance.titleVideo,
      'urlVideo': instance.urlVideo,
      'feeShip': instance.feeShip,
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

_$AgencyProductImageResponseImpl _$$AgencyProductImageResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AgencyProductImageResponseImpl(
      id: json['id'] as String?,
      productId: json['productId'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$$AgencyProductImageResponseImplToJson(
        _$AgencyProductImageResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'image': instance.image,
    };

_$AgencyProductPropertyResponseImpl
    _$$AgencyProductPropertyResponseImplFromJson(Map<String, dynamic> json) =>
        _$AgencyProductPropertyResponseImpl(
          id: json['id'] as String?,
          name: json['name'] as String?,
          image: json['image'] as String?,
          productId: json['productId'] as String?,
          createdDate: json['createdDate'] as String?,
        );

Map<String, dynamic> _$$AgencyProductPropertyResponseImplToJson(
        _$AgencyProductPropertyResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'productId': instance.productId,
      'createdDate': instance.createdDate,
    };
