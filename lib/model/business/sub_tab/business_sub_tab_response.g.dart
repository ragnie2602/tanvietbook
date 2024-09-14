// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_sub_tab_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusinessSubTabResponseImpl _$$BusinessSubTabResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$BusinessSubTabResponseImpl(
      id: json['id'] as String?,
      websiteId: json['websiteId'] as String?,
      name: json['name'] as String?,
      dataType: json['dataType'] as String?,
      memberId: json['memberId'] as String?,
      createDate: json['createDate'] as String?,
      priority: json['priority'] as int?,
      subtabTemplate: json['subtabTemplate'] as String?,
      hidden: json['hidden'] as bool?,
      error: json['error'],
    );

Map<String, dynamic> _$$BusinessSubTabResponseImplToJson(
        _$BusinessSubTabResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'websiteId': instance.websiteId,
      'name': instance.name,
      'dataType': instance.dataType,
      'memberId': instance.memberId,
      'createDate': instance.createDate,
      'priority': instance.priority,
      'subtabTemplate': instance.subtabTemplate,
      'hidden': instance.hidden,
      'error': instance.error,
    };
