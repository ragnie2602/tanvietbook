import 'package:freezed_annotation/freezed_annotation.dart';

part 'concern_response.freezed.dart';
part 'concern_response.g.dart';

@freezed
class ConcernResponsePaging with _$ConcernResponsePaging {
  const factory ConcernResponsePaging({
    @JsonKey(name: 'data') List<ConcernResponse>? data,
    @JsonKey(name: 'totalCount') int? totalCount,
    @JsonKey(name: 'page') int? page,
    @JsonKey(name: 'pageSize') int? pageSize,
  }) = _ConcernResponsePaging;

  factory ConcernResponsePaging.fromJson(Map<String, Object?> json) =>
      _$ConcernResponsePagingFromJson(json);
}

@freezed
class ConcernResponse with _$ConcernResponse {
  factory ConcernResponse({
    String? id,
    String? memberId,
    String? concernId,
    String? phonenumber,
    String? address,
    String? fullName,
    String? email,
    String? type,
    String? note,
    int? status,
    bool? enable,
    String? description,
    String? concernName,
    List<String>? concernImage,
    String? createdDate,
    String? lastModifiedDate,
  }) = _ConcernResponse;

  factory ConcernResponse.fromJson(Map<String, dynamic> json) =>
      _$ConcernResponseFromJson(json);
}
