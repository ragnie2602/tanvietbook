import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_detail_response.freezed.dart';
part 'product_detail_response.g.dart';

@freezed
class ProductDetailResponse with _$ProductDetailResponse {
  const factory ProductDetailResponse({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'categoryID') String? categoryID,
    @JsonKey(name: 'postName') String? postName,
    @JsonKey(name: 'description1') String? description1,
    @JsonKey(name: 'titleLink1') String? titleLink1,
    @JsonKey(name: 'link1') String? link1,
    @JsonKey(name: 'description2') String? description2,
    @JsonKey(name: 'titleLink2') String? titleLink2,
    @JsonKey(name: 'link2') String? link2,
    @JsonKey(name: 'categoryName') String? categoryName,
    @JsonKey(name: 'prices') double? prices,
    @JsonKey(name: 'discountPrices') double? discountPrices,
    @JsonKey(name: 'link') String? link,
    @JsonKey(name: 'note') String? note,
    @JsonKey(name: 'memberId') String? memberId,
    @JsonKey(name: 'hidden') bool? hidden,
    @JsonKey(name: 'outOfStock') bool? outOfStock,
    @JsonKey(name: 'video') String? video,
    @JsonKey(name: 'actionInfor') String? actionInfor,
    @JsonKey(name: 'images') List<String>? images,
  }) = _ProductDetailResponse;

  factory ProductDetailResponse.fromJson(Map<String, Object?> json) =>
      _$ProductDetailResponseFromJson(json);
}
