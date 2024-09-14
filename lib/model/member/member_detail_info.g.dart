// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_detail_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MemberInfoImpl _$$MemberInfoImplFromJson(Map<String, dynamic> json) =>
    _$MemberInfoImpl(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      nickName: json['nickName'] as String?,
      bio: json['bio'] as String?,
      favoriteQuote: json['favoriteQuote'] as String?,
      login: json['login'] as String?,
      avatar: json['avatar'] as String?,
      coverImage: json['coverImage'] as String?,
      dob: json['dob'] as String?,
      gender: json['gender'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      district: json['district'] as String?,
      commune: json['commune'] as String?,
      registerAddressLink: json['registerAddressLink'] as String?,
      hightlight: json['hightlight'] as String?,
      hideInfo: json['hideInfo'] as bool?,
      favoriteQuoteHidden: json['favoriteQuoteHidden'] as bool?,
      dobHidden: json['dobHidden'] as bool?,
      genderHidden: json['genderHidden'] as bool?,
      addressHidden: json['addressHidden'] as bool?,
      fullNameHidden: json['fullNameHidden'] as bool?,
      nickNameHidden: json['nickNameHidden'] as bool?,
      bioHidden: json['bioHidden'] as bool?,
      hightlightHidden: json['hightlightHidden'] as bool?,
      logo: json['logo'] as String?,
      baseInfor: (json['baseInfor'] as List<dynamic>?)
          ?.map((e) => BaseInfoResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'],
    );

Map<String, dynamic> _$$MemberInfoImplToJson(_$MemberInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'nickName': instance.nickName,
      'bio': instance.bio,
      'favoriteQuote': instance.favoriteQuote,
      'login': instance.login,
      'avatar': instance.avatar,
      'coverImage': instance.coverImage,
      'dob': instance.dob,
      'gender': instance.gender,
      'address': instance.address,
      'city': instance.city,
      'district': instance.district,
      'commune': instance.commune,
      'registerAddressLink': instance.registerAddressLink,
      'hightlight': instance.hightlight,
      'hideInfo': instance.hideInfo,
      'favoriteQuoteHidden': instance.favoriteQuoteHidden,
      'dobHidden': instance.dobHidden,
      'genderHidden': instance.genderHidden,
      'addressHidden': instance.addressHidden,
      'fullNameHidden': instance.fullNameHidden,
      'nickNameHidden': instance.nickNameHidden,
      'bioHidden': instance.bioHidden,
      'hightlightHidden': instance.hightlightHidden,
      'logo': instance.logo,
      'baseInfor': instance.baseInfor?.map((e) => e.toJson()).toList(),
      'error': instance.error,
    };
