import 'package:freezed_annotation/freezed_annotation.dart';

part 'agency_detail.freezed.dart';
part 'agency_detail.g.dart';

@freezed
class AgencyDetail with _$AgencyDetail {
  factory AgencyDetail({
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
    List<AgencyPath>? path,
    dynamic error,
    List<AgencyCategoryProduct>? listAgencyCateProd,
    String? instruction,
    String? pdf,
  }) = _AgencyDetail;

  factory AgencyDetail.fromJson(Map<String, dynamic> json) =>
      _$AgencyDetailFromJson(json);
}

@freezed
class AgencyPath with _$AgencyPath {
  factory AgencyPath({
    String? id,
    String? agencyInfoId,
    String? title,
    String? value,
    String? type,
    dynamic error,
  }) = _AgencyPath;

  factory AgencyPath.fromJson(Map<String, dynamic> json) =>
      _$AgencyPathFromJson(json);
}

@freezed
class AgencyCategoryProduct with _$AgencyCategoryProduct {
  factory AgencyCategoryProduct({
    String? name,
    String? image,
    String? link,
    String? description,
    String? agency,
  }) = _AgencyCategoryProduct;

  factory AgencyCategoryProduct.fromJson(Map<String, dynamic> json) =>
      _$AgencyCategoryProductFromJson(json);
}
