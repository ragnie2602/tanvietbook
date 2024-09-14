// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductDetailResponseImpl _$$ProductDetailResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductDetailResponseImpl(
      id: json['id'] as String?,
      categoryID: json['categoryID'] as String?,
      postName: json['postName'] as String?,
      description1: json['description1'] as String?,
      titleLink1: json['titleLink1'] as String?,
      link1: json['link1'] as String?,
      description2: json['description2'] as String?,
      titleLink2: json['titleLink2'] as String?,
      link2: json['link2'] as String?,
      categoryName: json['categoryName'] as String?,
      prices: (json['prices'] as num?)?.toDouble(),
      discountPrices: (json['discountPrices'] as num?)?.toDouble(),
      link: json['link'] as String?,
      note: json['note'] as String?,
      memberId: json['memberId'] as String?,
      hidden: json['hidden'] as bool?,
      outOfStock: json['outOfStock'] as bool?,
      video: json['video'] as String?,
      actionInfor: json['actionInfor'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$ProductDetailResponseImplToJson(
        _$ProductDetailResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryID': instance.categoryID,
      'postName': instance.postName,
      'description1': instance.description1,
      'titleLink1': instance.titleLink1,
      'link1': instance.link1,
      'description2': instance.description2,
      'titleLink2': instance.titleLink2,
      'link2': instance.link2,
      'categoryName': instance.categoryName,
      'prices': instance.prices,
      'discountPrices': instance.discountPrices,
      'link': instance.link,
      'note': instance.note,
      'memberId': instance.memberId,
      'hidden': instance.hidden,
      'outOfStock': instance.outOfStock,
      'video': instance.video,
      'actionInfor': instance.actionInfor,
      'images': instance.images,
    };
