// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'concern_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConcernResponsePagingImpl _$$ConcernResponsePagingImplFromJson(
        Map<String, dynamic> json) =>
    _$ConcernResponsePagingImpl(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ConcernResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int?,
      page: json['page'] as int?,
      pageSize: json['pageSize'] as int?,
    );

Map<String, dynamic> _$$ConcernResponsePagingImplToJson(
        _$ConcernResponsePagingImpl instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'totalCount': instance.totalCount,
      'page': instance.page,
      'pageSize': instance.pageSize,
    };

_$ConcernResponseImpl _$$ConcernResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ConcernResponseImpl(
      id: json['id'] as String?,
      memberId: json['memberId'] as String?,
      concernId: json['concernId'] as String?,
      phonenumber: json['phonenumber'] as String?,
      address: json['address'] as String?,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      type: json['type'] as String?,
      note: json['note'] as String?,
      status: json['status'] as int?,
      enable: json['enable'] as bool?,
      description: json['description'] as String?,
      concernName: json['concernName'] as String?,
      concernImage: (json['concernImage'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdDate: json['createdDate'] as String?,
      lastModifiedDate: json['lastModifiedDate'] as String?,
    );

Map<String, dynamic> _$$ConcernResponseImplToJson(
        _$ConcernResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'memberId': instance.memberId,
      'concernId': instance.concernId,
      'phonenumber': instance.phonenumber,
      'address': instance.address,
      'fullName': instance.fullName,
      'email': instance.email,
      'type': instance.type,
      'note': instance.note,
      'status': instance.status,
      'enable': instance.enable,
      'description': instance.description,
      'concernName': instance.concernName,
      'concernImage': instance.concernImage,
      'createdDate': instance.createdDate,
      'lastModifiedDate': instance.lastModifiedDate,
    };
