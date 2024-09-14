// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusinessDetailResponseImpl _$$BusinessDetailResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$BusinessDetailResponseImpl(
      id: json['id'] as String?,
      memberId: json['memberId'] as String?,
      websiteName: json['websiteName'] as String?,
      logo: json['logo'] as String?,
      email: json['email'] as String?,
      emailEnable: json['emailEnable'] as bool?,
      phoneNumber: json['phoneNumber'] as String?,
      phoneNumberEnable: json['phoneNumberEnable'] as bool?,
      messenger: json['messenger'] as String?,
      messengerEnable: json['messengerEnable'] as bool?,
      zalo: json['zalo'] as String?,
      zaloEnable: json['zaloEnable'] as bool?,
      description: json['description'] as String?,
      banners: (json['banners'] as List<dynamic>?)
          ?.map((e) => BusinessBanner.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$BusinessDetailResponseImplToJson(
        _$BusinessDetailResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'memberId': instance.memberId,
      'websiteName': instance.websiteName,
      'logo': instance.logo,
      'email': instance.email,
      'emailEnable': instance.emailEnable,
      'phoneNumber': instance.phoneNumber,
      'phoneNumberEnable': instance.phoneNumberEnable,
      'messenger': instance.messenger,
      'messengerEnable': instance.messengerEnable,
      'zalo': instance.zalo,
      'zaloEnable': instance.zaloEnable,
      'description': instance.description,
      'banners': instance.banners?.map((e) => e.toJson()).toList(),
      'error': instance.error,
    };

_$BusinessBannerImpl _$$BusinessBannerImplFromJson(Map<String, dynamic> json) =>
    _$BusinessBannerImpl(
      id: json['id'] as String?,
      websiteId: json['websiteId'] as String?,
      value: json['value'] as String?,
      redirect: json['redirect'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$$BusinessBannerImplToJson(
        _$BusinessBannerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'websiteId': instance.websiteId,
      'value': instance.value,
      'redirect': instance.redirect,
      'type': instance.type,
    };

_$BusinessDetailUpdateRequestImpl _$$BusinessDetailUpdateRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$BusinessDetailUpdateRequestImpl(
      id: json['id'] as String?,
      memberId: json['memberId'] as String?,
      websiteName: json['websiteName'] as String?,
      logo: json['logo'] as String?,
      email: json['email'] as String?,
      emailEnable: json['emailEnable'] as bool?,
      phoneNumber: json['phoneNumber'] as String?,
      phoneNumberEnable: json['phoneNumberEnable'] as bool?,
      messenger: json['messenger'] as String?,
      messengerEnable: json['messengerEnable'] as bool?,
      zalo: json['zalo'] as String?,
      zaloEnable: json['zaloEnable'] as bool?,
      description: json['description'] as String?,
      banners:
          (json['banners'] as List<dynamic>?)?.map((e) => e as String).toList(),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$BusinessDetailUpdateRequestImplToJson(
        _$BusinessDetailUpdateRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'memberId': instance.memberId,
      'websiteName': instance.websiteName,
      'logo': instance.logo,
      'email': instance.email,
      'emailEnable': instance.emailEnable,
      'phoneNumber': instance.phoneNumber,
      'phoneNumberEnable': instance.phoneNumberEnable,
      'messenger': instance.messenger,
      'messengerEnable': instance.messengerEnable,
      'zalo': instance.zalo,
      'zaloEnable': instance.zaloEnable,
      'description': instance.description,
      'banners': instance.banners,
      'error': instance.error,
    };
