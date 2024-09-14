import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  factory Product({
    String? id,
    String? propertyId,
    String? name,
    String? sku,
    double? price,
    double? salePrice,
    List<String>? images,
    String? productPropertyImage,
    String? productPropertyName,
    dynamic agency,
    dynamic hidden,
    dynamic groupProductId,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
