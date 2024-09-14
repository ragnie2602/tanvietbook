import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_detail_response.freezed.dart';
part 'business_detail_response.g.dart';

@freezed
class BusinessDetailResponse with _$BusinessDetailResponse {
  const factory BusinessDetailResponse({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'memberId') String? memberId,
    @JsonKey(name: 'websiteName') String? websiteName,
    @JsonKey(name: 'logo') String? logo,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'emailEnable') bool? emailEnable,
    @JsonKey(name: 'phoneNumber') String? phoneNumber,
    @JsonKey(name: 'phoneNumberEnable') bool? phoneNumberEnable,
    @JsonKey(name: 'messenger') String? messenger,
    @JsonKey(name: 'messengerEnable') bool? messengerEnable,
    @JsonKey(name: 'zalo') String? zalo,
    @JsonKey(name: 'zaloEnable') bool? zaloEnable,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'banners') List<BusinessBanner>? banners,
    @JsonKey(name: 'error') String? error,
  }) = _BusinessDetailResponse;

  factory BusinessDetailResponse.fromJson(Map<String, Object?> json) =>
      _$BusinessDetailResponseFromJson(json);
}

@freezed
class BusinessBanner with _$BusinessBanner {
  const factory BusinessBanner({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'websiteId') String? websiteId,
    @JsonKey(name: 'value') String? value,
    @JsonKey(name: 'redirect') String? redirect,
    @JsonKey(name: 'type') String? type,
  }) = _BusinessBanner;

  factory BusinessBanner.fromJson(Map<String, Object?> json) =>
      _$BusinessBannerFromJson(json);
}

@freezed
class BusinessDetailUpdateRequest with _$BusinessDetailUpdateRequest {
  const factory BusinessDetailUpdateRequest({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'memberId') String? memberId,
    @JsonKey(name: 'websiteName') String? websiteName,
    @JsonKey(name: 'logo') String? logo,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'emailEnable') bool? emailEnable,
    @JsonKey(name: 'phoneNumber') String? phoneNumber,
    @JsonKey(name: 'phoneNumberEnable') bool? phoneNumberEnable,
    @JsonKey(name: 'messenger') String? messenger,
    @JsonKey(name: 'messengerEnable') bool? messengerEnable,
    @JsonKey(name: 'zalo') String? zalo,
    @JsonKey(name: 'zaloEnable') bool? zaloEnable,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'banners') List<String>? banners,
    @JsonKey(name: 'error') String? error,
  }) = _BusinessDetailUpdateRequest;

  factory BusinessDetailUpdateRequest.fromJson(Map<String, Object?> json) =>
      _$BusinessDetailUpdateRequestFromJson(json);
}
