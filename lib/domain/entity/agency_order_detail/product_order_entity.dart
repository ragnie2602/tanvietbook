import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_order_entity.freezed.dart';
part 'product_order_entity.g.dart';

@freezed
class ProductOrderEntity with _$ProductOrderEntity {
  factory ProductOrderEntity({
    int? amount,
    String? productName,
    String? productPropertyId,
    String? productPropertyName,
    double? productPropertyPrice,
    double? productPropertySalePrice,
    String? productPropertyImage,
  }) = _ProductOrderEntity;

  factory ProductOrderEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductOrderEntityFromJson(json);
}
