import 'package:freezed_annotation/freezed_annotation.dart';

import 'product_order.dart';

part 'agency_order_detail_response.freezed.dart';
part 'agency_order_detail_response.g.dart';

@freezed
class AgencyOrderDetailResponse with _$AgencyOrderDetailResponse {
  factory AgencyOrderDetailResponse({
    String? id,
    String? orderCode,
    int? orderMethod,
    String? userId,
    int? status,
    int? paymentStatus,
    double? payment,
    String? userName,
    String? phoneNumber,
    String? address,
    String? email,
    String? district,
    String? province,
    String? commune,
    String? note,
    dynamic image,
    int? paymentMethod,
    String? createdDate,
    dynamic lastModifiedDate,
    dynamic transportFee,
    dynamic discountCode,
    String? fullName,
    String? referralName,
    List<ProductOrder>? productOrders,
    dynamic transportId,
    int? transportMethod,
    dynamic warehouseId,
    dynamic warehouseName,
    dynamic warehouseAddress,
    dynamic receiverName,
    dynamic receiverPhoneNumber,
    dynamic receiverAddress,
    dynamic receiverEmail,
    dynamic receiverDistrict,
    dynamic receiverProvince,
    dynamic receiverCommune,
    dynamic receiverId,
    dynamic discountAmount,
    dynamic discountCodeInfo,
    dynamic agency,
    bool? isUpdate,
    int? weight,
    int? length,
    int? width,
    int? height,
  }) = _AgencyOrderDetailResponse;

  factory AgencyOrderDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$AgencyOrderDetailResponseFromJson(json);
}
