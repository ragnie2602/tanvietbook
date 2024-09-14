// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgencyDetailResponseImpl _$$AgencyDetailResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AgencyDetailResponseImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      shortName: json['shortName'] as String?,
      domain: json['domain'] as String?,
      logo: json['logo'] as String?,
      background: (json['background'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      color: json['color'] as String?,
      description: json['description'] as String?,
      field: json['field'] as String?,
      address: json['address'] as String?,
      agency: json['agency'] as String?,
      path: (json['path'] as List<dynamic>?)
          ?.map((e) => AgencyPathResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'],
      listAgencyCateProd: (json['listAgencyCateProd'] as List<dynamic>?)
          ?.map((e) =>
              AgencyCategoryProductResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      instruction: json['instruction'] as String?,
      pdf: json['pdf'] as String?,
    );

Map<String, dynamic> _$$AgencyDetailResponseImplToJson(
        _$AgencyDetailResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shortName': instance.shortName,
      'domain': instance.domain,
      'logo': instance.logo,
      'background': instance.background,
      'color': instance.color,
      'description': instance.description,
      'field': instance.field,
      'address': instance.address,
      'agency': instance.agency,
      'path': instance.path?.map((e) => e.toJson()).toList(),
      'error': instance.error,
      'listAgencyCateProd':
          instance.listAgencyCateProd?.map((e) => e.toJson()).toList(),
      'instruction': instance.instruction,
      'pdf': instance.pdf,
    };

_$AgencyPathResponseImpl _$$AgencyPathResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AgencyPathResponseImpl(
      id: json['id'] as String?,
      agencyInfoId: json['agencyInfoId'] as String?,
      title: json['title'] as String?,
      value: json['value'] as String?,
      type: json['type'] as String?,
      error: json['error'],
    );

Map<String, dynamic> _$$AgencyPathResponseImplToJson(
        _$AgencyPathResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'agencyInfoId': instance.agencyInfoId,
      'title': instance.title,
      'value': instance.value,
      'type': instance.type,
      'error': instance.error,
    };

_$AgencyCategoryProductResponseImpl
    _$$AgencyCategoryProductResponseImplFromJson(Map<String, dynamic> json) =>
        _$AgencyCategoryProductResponseImpl(
          name: json['name'] as String?,
          image: json['image'] as String?,
          link: json['link'] as String?,
          description: json['description'] as String?,
          agency: json['agency'] as String?,
        );

Map<String, dynamic> _$$AgencyCategoryProductResponseImplToJson(
        _$AgencyCategoryProductResponseImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'link': instance.link,
      'description': instance.description,
      'agency': instance.agency,
    };
