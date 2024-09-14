import 'package:freezed_annotation/freezed_annotation.dart';

part 'agency_category_product.freezed.dart';
part 'agency_category_product.g.dart';

@freezed
class AgencyCategoryProduct with _$AgencyCategoryProduct {
  factory AgencyCategoryProduct({
    String? name,
    String? image,
    String? link,
    String? description,
    String? agency,
  }) = _AgencyCategoryProduct;

  factory AgencyCategoryProduct.fromJson(Map<String, dynamic> json) =>
      _$AgencyCategoryProductFromJson(json);
}
