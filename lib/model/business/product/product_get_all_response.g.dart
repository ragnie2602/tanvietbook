// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_get_all_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductGetAllResponseImpl _$$ProductGetAllResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductGetAllResponseImpl(
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => ProductDetailResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int?,
      page: json['page'] as int?,
      pageSize: json['pageSize'] as int?,
    );

Map<String, dynamic> _$$ProductGetAllResponseImplToJson(
        _$ProductGetAllResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'totalCount': instance.totalCount,
      'page': instance.page,
      'pageSize': instance.pageSize,
    };
