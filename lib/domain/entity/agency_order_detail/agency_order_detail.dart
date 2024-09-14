import 'package:freezed_annotation/freezed_annotation.dart';

import 'product_order_entity.dart';

part 'agency_order_detail.freezed.dart';
part 'agency_order_detail.g.dart';

@unfreezed
class AgencyOrderDetail with _$AgencyOrderDetail {
  factory AgencyOrderDetail({
    String? id,
    String? orderCode,
    int? orderMethod,
    String? userId,
    int? status,
    String? statusStr,
    int? paymentStatus,
    String? paymentStatusStr,
    int? payment,
    String? userName,
    String? phoneNumber,
    String? address,
    String? email,
    String? district,
    String? province,
    String? commune,
    String? createdBy,
    String? createdDate,
    // String? lastModifiedBy,
    // String? lastModifiedDate,
    String? note,
    int? paymentMethod,
    String? paymentMethodStr,
    int? transportFee,
    int? transportMethod,
    String? discountCode,
    String? fullName,
    String? referralName,
    String? transactionId,
    List<ProductOrderEntity>? products,
    num? weight,
    num? length,
    num? width,
    num? height,
  }) = _AgencyOrderDetail;

  factory AgencyOrderDetail.fromJson(Map<String, dynamic> json) =>
      _$AgencyOrderDetailFromJson(json);
}
