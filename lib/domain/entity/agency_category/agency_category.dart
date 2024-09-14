import 'package:freezed_annotation/freezed_annotation.dart';

part 'agency_category.freezed.dart';
part 'agency_category.g.dart';

@freezed
class AgencyCategory with _$AgencyCategory {
  factory AgencyCategory({
    String? id,
    String? name,
    String? description,
    int? status,
    DateTime? createdDate,
    dynamic updateDate,
    List<String>? image,
    int? quantity,
  }) = _AgencyCategory;

  factory AgencyCategory.fromJson(Map<String, dynamic> json) =>
      _$AgencyCategoryFromJson(json);
}
