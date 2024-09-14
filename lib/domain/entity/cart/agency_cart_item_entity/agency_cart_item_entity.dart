import 'package:freezed_annotation/freezed_annotation.dart';

import 'agency_cart_product_entity.dart';

part 'agency_cart_item_entity.freezed.dart';
part 'agency_cart_item_entity.g.dart';

@unfreezed
class AgencyCartItemEntity with _$AgencyCartItemEntity {
  factory AgencyCartItemEntity({
    String? id,
    @JsonKey(name: 'user_id') String? userId,
    String? createdDate,
    int? amount,
    AgencyCartProductEntity? product,
    num? totalLength,
    num? totalWidth,
    num? totalHeight,
    num? totalWeight,
  }) = _AgencyCartItemEntity;

  factory AgencyCartItemEntity.fromJson(Map<String, dynamic> json) => _$AgencyCartItemEntityFromJson(json);
}
