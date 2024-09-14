import 'package:freezed_annotation/freezed_annotation.dart';

part 'agency_cart_product_entity.freezed.dart';
part 'agency_cart_product_entity.g.dart';

@unfreezed
class AgencyCartProductEntity with _$AgencyCartProductEntity {
  factory AgencyCartProductEntity({
    String? id,
    String? propertyId,
    String? name,
    int? price,
    int? salePrice,
    List<String>? images,
    String? productPropertyImage,
    String? productPropertyName,
    bool? hidden,
    num? weight,
    num? length,
    num? height,
    num? width,
  }) = _AgencyCartProductEntity;

  factory AgencyCartProductEntity.fromJson(Map<String, dynamic> json) => _$AgencyCartProductEntityFromJson(json);
}
