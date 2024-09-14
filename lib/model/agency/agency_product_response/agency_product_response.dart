import 'package:freezed_annotation/freezed_annotation.dart';

part 'agency_product_response.freezed.dart';
part 'agency_product_response.g.dart';

@freezed
class AgencyProductResponse with _$AgencyProductResponse {
  factory AgencyProductResponse({
    String? id,
    String? sku,
    String? name,
    int? status,
    double? price,
    double? salePrice,
    String? description,
    String? titleVideo,
    String? urlVideo,
    double? feeShip,
    List<AgencyProductImageResponse>? images,
    List<AgencyProductPropertyResponse>? productProperties,
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
  }) = _AgencyProductResponse;

  factory AgencyProductResponse.fromJson(Map<String, dynamic> json) =>
      _$AgencyProductResponseFromJson(json);
}

@freezed
class AgencyProductImageResponse with _$AgencyProductImageResponse {
  factory AgencyProductImageResponse({
    String? id,
    String? productId,
    String? image,
  }) = _AgencyProductImageResponse;

  factory AgencyProductImageResponse.fromJson(Map<String, dynamic> json) =>
      _$AgencyProductImageResponseFromJson(json);
}

@freezed
class AgencyProductPropertyResponse with _$AgencyProductPropertyResponse {
  factory AgencyProductPropertyResponse({
    String? id,
    String? name,
    String? image,
    String? productId,
    String? createdDate,
    // dynamic lastModifiedBy,
    // dynamic lastModifiedDate,
  }) = _AgencyProductPropertyResponse;

  factory AgencyProductPropertyResponse.fromJson(Map<String, dynamic> json) =>
      _$AgencyProductPropertyResponseFromJson(json);
}
