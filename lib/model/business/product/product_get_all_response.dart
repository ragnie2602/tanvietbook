import 'package:freezed_annotation/freezed_annotation.dart';

import 'product_detail_response.dart';

part 'product_get_all_response.freezed.dart';
part 'product_get_all_response.g.dart';

@freezed
class ProductGetAllResponse with _$ProductGetAllResponse {
  const factory ProductGetAllResponse({
    @JsonKey(name: 'data') List<ProductDetailResponse>? data,
    @JsonKey(name: 'totalCount') int? totalCount,
    @JsonKey(name: 'page') int? page,
    @JsonKey(name: 'pageSize') int? pageSize,
  }) = _ProductGetAllResponse;

  factory ProductGetAllResponse.fromJson(Map<String, Object?> json) =>
      _$ProductGetAllResponseFromJson(json);
}
