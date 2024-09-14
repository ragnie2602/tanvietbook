// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_cart_item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgencyCartItemEntityImpl _$$AgencyCartItemEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$AgencyCartItemEntityImpl(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      createdDate: json['createdDate'] as String?,
      amount: json['amount'] as int?,
      product: json['product'] == null
          ? null
          : AgencyCartProductEntity.fromJson(
              json['product'] as Map<String, dynamic>),
      totalLength: json['totalLength'] as num?,
      totalWidth: json['totalWidth'] as num?,
      totalHeight: json['totalHeight'] as num?,
      totalWeight: json['totalWeight'] as num?,
    );

Map<String, dynamic> _$$AgencyCartItemEntityImplToJson(
        _$AgencyCartItemEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'createdDate': instance.createdDate,
      'amount': instance.amount,
      'product': instance.product?.toJson(),
      'totalLength': instance.totalLength,
      'totalWidth': instance.totalWidth,
      'totalHeight': instance.totalHeight,
      'totalWeight': instance.totalWeight,
    };
