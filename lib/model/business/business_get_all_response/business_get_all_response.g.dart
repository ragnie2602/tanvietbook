// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_get_all_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusinessGetAllResponseImpl _$$BusinessGetAllResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$BusinessGetAllResponseImpl(
      id: json['id'] as String?,
      websiteName: json['websiteName'] as String?,
      logo: json['logo'] as String?,
      error: json['error'],
    );

Map<String, dynamic> _$$BusinessGetAllResponseImplToJson(
        _$BusinessGetAllResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'websiteName': instance.websiteName,
      'logo': instance.logo,
      'error': instance.error,
    };
