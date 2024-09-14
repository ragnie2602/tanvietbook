import 'dart:convert';

class VoucherValidateResponse {
  final bool? success;
  final String? errorCode;
  final String? errorMessage;
  final VoucherValidateDataResponse? data;

  VoucherValidateResponse({
    this.success,
    this.errorCode,
    this.errorMessage,
    this.data,
  });

  factory VoucherValidateResponse.fromRawJson(String str) =>
      VoucherValidateResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VoucherValidateResponse.fromJson(Map<String, dynamic> json) =>
      VoucherValidateResponse(
        success: json["success"],
        errorCode: json["errorCode"],
        errorMessage: json["errorMessage"],
        data: json["data"] == null
            ? null
            : VoucherValidateDataResponse.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "errorCode": errorCode,
        "errorMessage": errorMessage,
        "data": data?.toJson(),
      };
}

class VoucherValidateDataResponse {
  final String? id;
  final String? code;
  final String? codeName;
  final bool? status;
  final int? minimumOrderCost;
  final int? maxCountInUse;
  final String? validDate;
  final String? unValidDate;
  final int? type;
  final int? percent;
  final int? maxPromotion;
  final String? description;
  final int? coinChange;
  final dynamic memberClass;
  final List<dynamic>? productApply;
  final dynamic error;
  final int? promotionMethod;
  final dynamic productGroupApplyArr;
  final List<dynamic>? orderApply;
  final int? validate;
  final int? userApply;
  final List<dynamic>? listUserApply;

  VoucherValidateDataResponse({
    this.id,
    this.code,
    this.codeName,
    this.status,
    this.minimumOrderCost,
    this.maxCountInUse,
    this.validDate,
    this.unValidDate,
    this.type,
    this.percent,
    this.maxPromotion,
    this.description,
    this.coinChange,
    this.memberClass,
    this.productApply,
    this.error,
    this.promotionMethod,
    this.productGroupApplyArr,
    this.orderApply,
    this.validate,
    this.userApply,
    this.listUserApply,
  });

  factory VoucherValidateDataResponse.fromRawJson(String str) =>
      VoucherValidateDataResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VoucherValidateDataResponse.fromJson(Map<String, dynamic> json) =>
      VoucherValidateDataResponse(
        id: json["id"],
        code: json["code"],
        codeName: json["codeName"],
        status: json["status"],
        minimumOrderCost: json["minimumOrderCost"],
        maxCountInUse: json["maxCountInUse"],
        validDate: json["validDate"],
        unValidDate: json["unValidDate"],
        type: json["type"],
        percent: json["percent"],
        maxPromotion: json["maxPromotion"],
        description: json["description"],
        coinChange: json["coinChange"],
        memberClass: json["memberClass"],
        productApply: json["productApply"],
        error: json["error"],
        promotionMethod: json["promotionMethod"],
        productGroupApplyArr: json["productGroupApplyArr"],
        orderApply: json["orderApply"],
        validate: json["validate"],
        userApply: json["userApply"],
        listUserApply: json["listUserApply"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "codeName": codeName,
        "status": status,
        "minimumOrderCost": minimumOrderCost,
        "maxCountInUse": maxCountInUse,
        "validDate": validDate,
        "unValidDate": unValidDate,
        "type": type,
        "percent": percent,
        "maxPromotion": maxPromotion,
        "description": description,
        "coinChange": coinChange,
        "memberClass": memberClass,
        "productApply": productApply,
        "error": error,
        "promotionMethod": promotionMethod,
        "productGroupApplyArr": productGroupApplyArr,
        "orderApply": orderApply,
        "validate": validate,
        "userApply": userApply,
        "listUserApply": listUserApply,
      };
}
