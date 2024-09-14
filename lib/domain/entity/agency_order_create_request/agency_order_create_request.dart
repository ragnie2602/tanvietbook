import 'package:freezed_annotation/freezed_annotation.dart';

import 'product_order_c.dart';

part 'agency_order_create_request.freezed.dart';
part 'agency_order_create_request.g.dart';

@unfreezed
class AgencyOrderCreateRequest with _$AgencyOrderCreateRequest {
  factory AgencyOrderCreateRequest({
    String? orderCode,
    String? userId,
    List<ProductOrderC>? productOrderCs,
    int? status,
    int? paymentStatus,
    int? payment,
    String? userName,
    String? phoneNumber,
    String? address,
    String? email,
    String? district,
    String? province,
    String? commune,
    String? image,
    int? paymentMethod,
    String? note,
    int? transportFee,
    String? discountCode,
    String? discountCodeInfo,
    String? fullName,
    String? referralName,
    String? agency,
    String? transportId,
    int? transportMethod,
    String? warehouseId,
    int? orderMethod,
    String? receiverName,
    String? receiverPhoneNumber,
    String? receiverAddress,
    String? receiverEmail,
    String? receiverDistrict,
    String? receiverProvince,
    String? receiverCommune,
    String? receiverId,
    int? discountAmount,
    int? typeVoucher,
    int? voucherMethod,
    int? region,
    int? state,
    int? weight,
    int? length,
    int? width,
    int? height,
  }) = _AgencyOrderCreateRequest;

  factory AgencyOrderCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$AgencyOrderCreateRequestFromJson(json);
}
