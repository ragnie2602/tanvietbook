import 'package:freezed_annotation/freezed_annotation.dart';

part 'agency_category_response.freezed.dart';
part 'agency_category_response.g.dart';

@freezed
class AgencyCategoryResponse with _$AgencyCategoryResponse {
  factory AgencyCategoryResponse({
    String? id,
    String? name,
    String? description,
    int? status,
    DateTime? createdDate,
    dynamic updateDate,
    List<String>? image,
    int? quantity,
  }) = _AgencyCategoryResponse;

  factory AgencyCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$AgencyCategoryResponseFromJson(json);
}
