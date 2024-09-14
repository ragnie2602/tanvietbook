import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_get_all_response.freezed.dart';
part 'business_get_all_response.g.dart';

@freezed
class BusinessGetAllResponse with _$BusinessGetAllResponse {
  factory BusinessGetAllResponse({
    String? id,
    String? websiteName,
    String? logo,
    dynamic error,
  }) = _BusinessGetAllResponse;

  factory BusinessGetAllResponse.fromJson(Map<String, dynamic> json) =>
      _$BusinessGetAllResponseFromJson(json);
}
