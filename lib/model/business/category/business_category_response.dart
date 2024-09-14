import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_category_response.freezed.dart';
part 'business_category_response.g.dart';

@freezed
class BusinessCategoryGetAllResponse with _$BusinessCategoryGetAllResponse {
  const factory BusinessCategoryGetAllResponse({
    @JsonKey(name: 'data') List<BusinessCategoryResponse>? data,
    @JsonKey(name: 'totalCount') int? totalCount,
    @JsonKey(name: 'page') int? page,
    @JsonKey(name: 'pageSize') int? pageSize,
  }) = _BusinessCategoryGetAllResponse;

  factory BusinessCategoryGetAllResponse.fromJson(Map<String, Object?> json) =>
      _$BusinessCategoryGetAllResponseFromJson(json);
}

@freezed
class BusinessCategoryResponse with _$BusinessCategoryResponse {
  const factory BusinessCategoryResponse({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'subTabId') String? subTabId,
    @JsonKey(name: 'categoryName') String? categoryName,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'memberId') String? memberId,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'isInitialized') bool? isInitialized,
    @JsonKey(name: 'enable') bool? enable,
    @JsonKey(name: 'priority') int? priority,
    @JsonKey(name: 'error') String? error,
  }) = _BusinessCategoryResponse;

  factory BusinessCategoryResponse.fromJson(Map<String, Object?> json) =>
      _$BusinessCategoryResponseFromJson(json);
}
