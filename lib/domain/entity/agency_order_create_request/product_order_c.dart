import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_order_c.freezed.dart';
part 'product_order_c.g.dart';

@freezed
class ProductOrderC with _$ProductOrderC {
  factory ProductOrderC({
    int? amount,
    String? productPropertyId,
    int? discountAmount,
    String? discountCode,
  }) = _ProductOrderC;

  factory ProductOrderC.fromJson(Map<String, dynamic> json) =>
      _$ProductOrderCFromJson(json);
}
