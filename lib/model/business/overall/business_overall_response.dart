import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_overall_response.freezed.dart';
part 'business_overall_response.g.dart';

@freezed
class BusinessOverallResponse with _$BusinessOverallResponse {
  const factory BusinessOverallResponse({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'memberId') String? memberId,
    @JsonKey(name: 'websiteName') String? websiteName,
    @JsonKey(name: 'logo') String? logo,
    @JsonKey(name: 'accessCount') int? accessCount,
    @Default("Website Mini") @JsonKey(name: 'defaultName') String? defaultName,
    @JsonKey(name: 'growthRate') double? growthRate,
    @JsonKey(name: 'growthType') String? growthType,
    @JsonKey(name: 'growthChange') int? growthChange,
    @JsonKey(name: 'catalogCount') int? catalogCount,
    @JsonKey(name: 'postGeneral') PostGeneral? postGeneral,
  }) = _BusinessOverallResponse;

  factory BusinessOverallResponse.fromJson(Map<String, Object?> json) =>
      _$BusinessOverallResponseFromJson(json);
}

@freezed
class PostGeneral with _$PostGeneral {
  const factory PostGeneral({
    @JsonKey(name: 'totalCount') int? totalCount,
    @JsonKey(name: 'activeCount') int? activeCount,
    @JsonKey(name: 'soldOutCount') int? soldOutCount,
    @JsonKey(name: 'hidingCount') int? hidingCount,
  }) = _PostGeneral;

  factory PostGeneral.fromJson(Map<String, Object?> json) =>
      _$PostGeneralFromJson(json);
}
