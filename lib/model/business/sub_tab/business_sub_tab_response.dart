import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_sub_tab_response.freezed.dart';
part 'business_sub_tab_response.g.dart';

@freezed
class BusinessSubTabResponse with _$BusinessSubTabResponse {
  const factory BusinessSubTabResponse({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'websiteId') String? websiteId,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'dataType') String? dataType,
    @JsonKey(name: 'memberId') String? memberId,
    @JsonKey(name: 'createDate') String? createDate,
    @JsonKey(name: 'priority') int? priority,
    @JsonKey(name: 'subtabTemplate') String? subtabTemplate,
    @JsonKey(name: 'hidden') bool? hidden,
    @JsonKey(name: 'error') dynamic? error,
  }) = _BusinessSubTabResponse;

  factory BusinessSubTabResponse.fromJson(Map<String, Object?> json) =>
      _$BusinessSubTabResponseFromJson(json);
}
