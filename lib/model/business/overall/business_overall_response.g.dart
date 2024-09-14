// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_overall_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusinessOverallResponseImpl _$$BusinessOverallResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$BusinessOverallResponseImpl(
      id: json['id'] as String?,
      memberId: json['memberId'] as String?,
      websiteName: json['websiteName'] as String?,
      logo: json['logo'] as String?,
      accessCount: json['accessCount'] as int?,
      defaultName: json['defaultName'] as String? ?? "Website Mini",
      growthRate: (json['growthRate'] as num?)?.toDouble(),
      growthType: json['growthType'] as String?,
      growthChange: json['growthChange'] as int?,
      catalogCount: json['catalogCount'] as int?,
      postGeneral: json['postGeneral'] == null
          ? null
          : PostGeneral.fromJson(json['postGeneral'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$BusinessOverallResponseImplToJson(
        _$BusinessOverallResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'memberId': instance.memberId,
      'websiteName': instance.websiteName,
      'logo': instance.logo,
      'accessCount': instance.accessCount,
      'defaultName': instance.defaultName,
      'growthRate': instance.growthRate,
      'growthType': instance.growthType,
      'growthChange': instance.growthChange,
      'catalogCount': instance.catalogCount,
      'postGeneral': instance.postGeneral?.toJson(),
    };

_$PostGeneralImpl _$$PostGeneralImplFromJson(Map<String, dynamic> json) =>
    _$PostGeneralImpl(
      totalCount: json['totalCount'] as int?,
      activeCount: json['activeCount'] as int?,
      soldOutCount: json['soldOutCount'] as int?,
      hidingCount: json['hidingCount'] as int?,
    );

Map<String, dynamic> _$$PostGeneralImplToJson(_$PostGeneralImpl instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'activeCount': instance.activeCount,
      'soldOutCount': instance.soldOutCount,
      'hidingCount': instance.hidingCount,
    };
