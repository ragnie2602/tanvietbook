import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_contact_response.freezed.dart';
part 'saved_contact_response.g.dart';

@freezed
class SavedContactResponse with _$SavedContactResponse {
  factory SavedContactResponse({
    List<SavedContactResponseData>? data,
    int? totalCount,
    int? page,
    int? pageSize,
  }) = _SavedContactResponse;

  factory SavedContactResponse.fromJson(Map<String, dynamic> json) =>
      _$SavedContactResponseFromJson(json);
}

@freezed
class SavedContactResponseData with _$SavedContactResponseData {
  factory SavedContactResponseData({
    String? id,
    String? name,
    String? avatar,
    String? displayname,
    String? phoneNumber,
    String? memberId,
    dynamic error,
  }) = _SavedContactResponseData;

  factory SavedContactResponseData.fromJson(Map<String, dynamic> json) =>
      _$SavedContactResponseDataFromJson(json);
}
