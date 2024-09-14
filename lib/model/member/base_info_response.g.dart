// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BaseInfoResponseImpl _$$BaseInfoResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$BaseInfoResponseImpl(
      id: json['id'] as String?,
      type: json['type'] as String?,
      title: json['title'] as String?,
      hidden: json['hidden'] as bool?,
      error: json['error'],
    );

Map<String, dynamic> _$$BaseInfoResponseImplToJson(
        _$BaseInfoResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'hidden': instance.hidden,
      'error': instance.error,
    };
