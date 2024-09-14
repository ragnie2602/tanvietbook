// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusinessCategoryGetAllResponseImpl
    _$$BusinessCategoryGetAllResponseImplFromJson(Map<String, dynamic> json) =>
        _$BusinessCategoryGetAllResponseImpl(
          data: (json['data'] as List<dynamic>?)
              ?.map((e) =>
                  BusinessCategoryResponse.fromJson(e as Map<String, dynamic>))
              .toList(),
          totalCount: json['totalCount'] as int?,
          page: json['page'] as int?,
          pageSize: json['pageSize'] as int?,
        );

Map<String, dynamic> _$$BusinessCategoryGetAllResponseImplToJson(
        _$BusinessCategoryGetAllResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'totalCount': instance.totalCount,
      'page': instance.page,
      'pageSize': instance.pageSize,
    };

_$BusinessCategoryResponseImpl _$$BusinessCategoryResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$BusinessCategoryResponseImpl(
      id: json['id'] as String?,
      subTabId: json['subTabId'] as String?,
      categoryName: json['categoryName'] as String?,
      description: json['description'] as String?,
      memberId: json['memberId'] as String?,
      type: json['type'] as String?,
      isInitialized: json['isInitialized'] as bool?,
      enable: json['enable'] as bool?,
      priority: json['priority'] as int?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$BusinessCategoryResponseImplToJson(
        _$BusinessCategoryResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subTabId': instance.subTabId,
      'categoryName': instance.categoryName,
      'description': instance.description,
      'memberId': instance.memberId,
      'type': instance.type,
      'isInitialized': instance.isInitialized,
      'enable': instance.enable,
      'priority': instance.priority,
      'error': instance.error,
    };
