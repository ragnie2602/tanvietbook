// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_product_property_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgencyProductPropertyResponseImpl
    _$$AgencyProductPropertyResponseImplFromJson(Map<String, dynamic> json) =>
        _$AgencyProductPropertyResponseImpl(
          id: json['id'] as String?,
          name: json['name'] as String?,
          image: json['image'] as String?,
          productId: json['productId'] as String?,
          createdBy: json['createdBy'],
          createdDate: json['createdDate'] as String?,
          lastModifiedBy: json['lastModifiedBy'],
          lastModifiedDate: json['lastModifiedDate'],
        );

Map<String, dynamic> _$$AgencyProductPropertyResponseImplToJson(
        _$AgencyProductPropertyResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'productId': instance.productId,
      'createdBy': instance.createdBy,
      'createdDate': instance.createdDate,
      'lastModifiedBy': instance.lastModifiedBy,
      'lastModifiedDate': instance.lastModifiedDate,
    };
