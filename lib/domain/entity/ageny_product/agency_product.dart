import 'package:freezed_annotation/freezed_annotation.dart';

part 'agency_product.freezed.dart';
part 'agency_product.g.dart';

@freezed
class AgencyProduct with _$AgencyProduct {
  factory AgencyProduct({
    String? id,
    String? sku,
    String? name,
    int? status,
    int? price,
    String? priceStr,
    int? salePrice,
    String? salePriceStr,
    String? description,
    String? titleVideo,
    String? urlVideo,
    int? feeShip,
    String? feeShipStr,
    List<AgencyProductImage>? images,
    List<AgencyProductProperty>? productProperties,

    // dynamic createdBy,
    DateTime? createdDate,
    // dynamic lastModifiedBy,
    // dynamic lastModifiedDate,
    // dynamic listCateId,
    String? groupProdName,
    bool? hidden,
    num? weight,
    num? length,
    num? width,
    num? height,
  }) = _AgencyProduct;

  factory AgencyProduct.fromJson(Map<String, dynamic> json) =>
      _$AgencyProductFromJson(json);
}

@freezed
class AgencyProductImage with _$AgencyProductImage {
  factory AgencyProductImage({
    String? id,
    String? productId,
    String? image,
  }) = _AgencyProductImage;

  factory AgencyProductImage.fromJson(Map<String, dynamic> json) =>
      _$AgencyProductImageFromJson(json);
}

@freezed
class AgencyProductProperty with _$AgencyProductProperty {
  factory AgencyProductProperty({
    String? id,
    String? name,
    String? image,
    String? productId,
    String? createdDate,
    // dynamic lastModifiedBy,
    // dynamic lastModifiedDate,
  }) = _AgencyProductProperty;

  factory AgencyProductProperty.fromJson(Map<String, dynamic> json) =>
      _$AgencyProductPropertyFromJson(json);
}
