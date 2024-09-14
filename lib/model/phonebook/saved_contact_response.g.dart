// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_contact_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SavedContactResponseImpl _$$SavedContactResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$SavedContactResponseImpl(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              SavedContactResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int?,
      page: json['page'] as int?,
      pageSize: json['pageSize'] as int?,
    );

Map<String, dynamic> _$$SavedContactResponseImplToJson(
        _$SavedContactResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'totalCount': instance.totalCount,
      'page': instance.page,
      'pageSize': instance.pageSize,
    };

_$SavedContactResponseDataImpl _$$SavedContactResponseDataImplFromJson(
        Map<String, dynamic> json) =>
    _$SavedContactResponseDataImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      displayname: json['displayname'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      memberId: json['memberId'] as String?,
      error: json['error'],
    );

Map<String, dynamic> _$$SavedContactResponseDataImplToJson(
        _$SavedContactResponseDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'displayname': instance.displayname,
      'phoneNumber': instance.phoneNumber,
      'memberId': instance.memberId,
      'error': instance.error,
    };
