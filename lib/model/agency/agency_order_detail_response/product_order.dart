import 'package:freezed_annotation/freezed_annotation.dart';

import 'product.dart';

part 'product_order.freezed.dart';
part 'product_order.g.dart';

@freezed
class ProductOrder with _$ProductOrder {
  factory ProductOrder({
    int? amount,
    Product? product,
    dynamic discountAmount,
    dynamic discountCode,
    String? productPropertyId,
  }) = _ProductOrder;

  factory ProductOrder.fromJson(Map<String, dynamic> json) =>
      _$ProductOrderFromJson(json);
}
