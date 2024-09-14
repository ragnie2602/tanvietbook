import 'package:freezed_annotation/freezed_annotation.dart';

part 'agency_detail_response.freezed.dart';
part 'agency_detail_response.g.dart';

@freezed
class AgencyDetailResponse with _$AgencyDetailResponse {
  factory AgencyDetailResponse({
    String? id,
    String? name,
    String? shortName,
    String? domain,
    String? logo,
    List<String>? background,
    String? color,
    String? description,
    String? field,
    String? address,
    String? agency,
    List<AgencyPathResponse>? path,
    dynamic error,
    List<AgencyCategoryProductResponse>? listAgencyCateProd,
    String? instruction,
    String? pdf,
  }) = _AgencyDetailResponse;

  factory AgencyDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$AgencyDetailResponseFromJson(json);
}

@freezed
class AgencyPathResponse with _$AgencyPathResponse {
  factory AgencyPathResponse({
    String? id,
    String? agencyInfoId,
    String? title,
    String? value,
    String? type,
    dynamic error,
  }) = _AgencyPathResponse;

  factory AgencyPathResponse.fromJson(Map<String, dynamic> json) =>
      _$AgencyPathResponseFromJson(json);
}

@freezed
class AgencyCategoryProductResponse with _$AgencyCategoryProductResponse {
  factory AgencyCategoryProductResponse({
    String? name,
    String? image,
    String? link,
    String? description,
    String? agency,
  }) = _AgencyCategoryProductResponse;

  factory AgencyCategoryProductResponse.fromJson(Map<String, dynamic> json) =>
      _$AgencyCategoryProductResponseFromJson(json);
}
