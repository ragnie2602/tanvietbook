// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserSettingsResponseImpl _$$UserSettingsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$UserSettingsResponseImpl(
      id: json['id'] as String?,
      login: json['login'] as String?,
      referralCode: json['referralCode'] as String?,
      firstName: json['firstName'] as String?,
      email: json['email'] as String?,
      emailConfirmed: json['emailConfirmed'] as bool?,
      phoneNumber: json['phoneNumber'] as String?,
      type: json['type'],
      imageUrl: json['imageUrl'] as String?,
      activated: json['activated'] as bool?,
      activationKey: json['activationKey'] as String?,
      langKey: json['langKey'] as String?,
      createdBy: json['createdBy'] as String?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      lastModifiedBy: json['lastModifiedBy'] as String?,
      lastModifiedDate: json['lastModifiedDate'] == null
          ? null
          : DateTime.parse(json['lastModifiedDate'] as String),
      authorities: json['authorities'],
    );

Map<String, dynamic> _$$UserSettingsResponseImplToJson(
        _$UserSettingsResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'referralCode': instance.referralCode,
      'firstName': instance.firstName,
      'email': instance.email,
      'emailConfirmed': instance.emailConfirmed,
      'phoneNumber': instance.phoneNumber,
      'type': instance.type,
      'imageUrl': instance.imageUrl,
      'activated': instance.activated,
      'activationKey': instance.activationKey,
      'langKey': instance.langKey,
      'createdBy': instance.createdBy,
      'createdDate': instance.createdDate?.toIso8601String(),
      'lastModifiedBy': instance.lastModifiedBy,
      'lastModifiedDate': instance.lastModifiedDate?.toIso8601String(),
      'authorities': instance.authorities,
    };
