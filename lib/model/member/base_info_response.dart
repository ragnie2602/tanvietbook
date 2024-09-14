import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_info_response.freezed.dart';
part 'base_info_response.g.dart';

@freezed
class BaseInfoResponse with _$BaseInfoResponse {
  factory BaseInfoResponse({
    String? id,
    String? type,
    String? title,
    bool? hidden,
    dynamic error,
  }) = _BaseInfoResponse;

  factory BaseInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseInfoResponseFromJson(json);
}
