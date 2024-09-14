import 'package:freezed_annotation/freezed_annotation.dart';

part 'agency_product_property_response.freezed.dart';
part 'agency_product_property_response.g.dart';

@freezed
class AgencyProductPropertyResponse with _$AgencyProductPropertyResponse {
  factory AgencyProductPropertyResponse({
    String? id,
    String? name,
    String? image,
    String? productId,
    dynamic createdBy,
    String? createdDate,
    dynamic lastModifiedBy,
    dynamic lastModifiedDate,
  }) = _AgencyProductPropertyResponse;

  factory AgencyProductPropertyResponse.fromJson(Map<String, dynamic> json) =>
      _$AgencyProductPropertyResponseFromJson(json);
}
