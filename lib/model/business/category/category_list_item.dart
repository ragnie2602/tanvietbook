import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_list_item.freezed.dart';
part 'category_list_item.g.dart';

@freezed
class CategoryListItem with _$CategoryListItem {
  const factory CategoryListItem({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'categoryName') String? categoryName,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'enable') bool? enable,
    @JsonKey(name: 'error') dynamic error,
  }) = _CategoryListItem;

  factory CategoryListItem.fromJson(Map<String, Object?> json) =>
      _$CategoryListItemFromJson(json);
}
