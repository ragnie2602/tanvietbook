// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_order_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgencyOrderDetailImpl _$$AgencyOrderDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$AgencyOrderDetailImpl(
      id: json['id'] as String?,
      orderCode: json['orderCode'] as String?,
      orderMethod: json['orderMethod'] as int?,
      userId: json['userId'] as String?,
      status: json['status'] as int?,
      statusStr: json['statusStr'] as String?,
      paymentStatus: json['paymentStatus'] as int?,
      paymentStatusStr: json['paymentStatusStr'] as String?,
      payment: json['payment'] as int?,
      userName: json['userName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
      email: json['email'] as String?,
      district: json['district'] as String?,
      province: json['province'] as String?,
      commune: json['commune'] as String?,
      createdBy: json['createdBy'] as String?,
      createdDate: json['createdDate'] as String?,
      note: json['note'] as String?,
      paymentMethod: json['paymentMethod'] as int?,
      paymentMethodStr: json['paymentMethodStr'] as String?,
      transportFee: json['transportFee'] as int?,
      transportMethod: json['transportMethod'] as int?,
      discountCode: json['discountCode'] as String?,
      fullName: json['fullName'] as String?,
      referralName: json['referralName'] as String?,
      transactionId: json['transactionId'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ProductOrderEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      weight: json['weight'] as num?,
      length: json['length'] as num?,
      width: json['width'] as num?,
      height: json['height'] as num?,
    );

Map<String, dynamic> _$$AgencyOrderDetailImplToJson(
        _$AgencyOrderDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderCode': instance.orderCode,
      'orderMethod': instance.orderMethod,
      'userId': instance.userId,
      'status': instance.status,
      'statusStr': instance.statusStr,
      'paymentStatus': instance.paymentStatus,
      'paymentStatusStr': instance.paymentStatusStr,
      'payment': instance.payment,
      'userName': instance.userName,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'email': instance.email,
      'district': instance.district,
      'province': instance.province,
      'commune': instance.commune,
      'createdBy': instance.createdBy,
      'createdDate': instance.createdDate,
      'note': instance.note,
      'paymentMethod': instance.paymentMethod,
      'paymentMethodStr': instance.paymentMethodStr,
      'transportFee': instance.transportFee,
      'transportMethod': instance.transportMethod,
      'discountCode': instance.discountCode,
      'fullName': instance.fullName,
      'referralName': instance.referralName,
      'transactionId': instance.transactionId,
      'products': instance.products?.map((e) => e.toJson()).toList(),
      'weight': instance.weight,
      'length': instance.length,
      'width': instance.width,
      'height': instance.height,
    };
