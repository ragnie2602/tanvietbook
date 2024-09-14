// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_address_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserAddressResponseImpl _$$UserAddressResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$UserAddressResponseImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      commune: json['commune'] as String?,
      district: json['district'] as String?,
      province: json['province'] as String?,
      status: json['status'] as int?,
      userId: json['userId'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$$UserAddressResponseImplToJson(
        _$UserAddressResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'address': instance.address,
      'commune': instance.commune,
      'district': instance.district,
      'province': instance.province,
      'status': instance.status,
      'userId': instance.userId,
      'phoneNumber': instance.phoneNumber,
    };
