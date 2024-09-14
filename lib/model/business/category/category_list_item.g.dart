// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_list_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryListItemImpl _$$CategoryListItemImplFromJson(
        Map<String, dynamic> json) =>
    _$CategoryListItemImpl(
      id: json['id'] as String?,
      categoryName: json['categoryName'] as String?,
      type: json['type'] as String?,
      enable: json['enable'] as bool?,
      error: json['error'],
    );

Map<String, dynamic> _$$CategoryListItemImplToJson(
        _$CategoryListItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryName': instance.categoryName,
      'type': instance.type,
      'enable': instance.enable,
      'error': instance.error,
    };
