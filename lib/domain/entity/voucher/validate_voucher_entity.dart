class VoucherValidateEntity {
  final bool? success;
  final String? errorCode;
  final String? errorMessage;
  final VoucherValidateDataEntity? data;

  VoucherValidateEntity({
    this.success,
    this.errorCode,
    this.errorMessage,
    this.data,
  });
}

class VoucherValidateDataEntity {
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

  VoucherValidateDataEntity({
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
}
