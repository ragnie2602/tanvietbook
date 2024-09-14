import 'dart:convert';

class GetShippingFeeResponse {
  final int? status;
  final bool? error;
  final String? message;
  final GetShippingFeeData? data;

  GetShippingFeeResponse({
    this.status,
    this.error,
    this.message,
    this.data,
  });

  factory GetShippingFeeResponse.fromRawJson(String str) => GetShippingFeeResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetShippingFeeResponse.fromJson(Map<String, dynamic> json) => GetShippingFeeResponse(
        status: json["status"],
        error: json["error"],
        message: json["message"],
        data: json["data"] is List ? null : GetShippingFeeData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "message": message,
        "data": data?.toJson(),
      };
}

class GetShippingFeeData {
  final num? moneyTotalOld;
  final num? moneyTotal;
  final num? moneyTotalFee;
  final num? moneyFee;
  final num? moneyCollectionFee;
  final num? moneyOtherFee;
  final num? moneyVas;
  final num? moneyVat;
  final num? kpiHt;
  final num? exchangeWeight;

  GetShippingFeeData({
    this.moneyTotalOld,
    this.moneyTotal,
    this.moneyTotalFee,
    this.moneyFee,
    this.moneyCollectionFee,
    this.moneyOtherFee,
    this.moneyVas,
    this.moneyVat,
    this.kpiHt,
    this.exchangeWeight,
  });

  factory GetShippingFeeData.fromJson(Map<String, dynamic> json) => GetShippingFeeData(
        moneyTotalOld: json["MONEY_TOTAL_OLD"],
        moneyTotal: json["MONEY_TOTAL"],
        moneyTotalFee: json["MONEY_TOTAL_FEE"],
        moneyFee: json["MONEY_FEE"],
        moneyCollectionFee: json["MONEY_COLLECTION_FEE"],
        moneyOtherFee: json["MONEY_OTHER_FEE"],
        moneyVas: json["MONEY_VAS"],
        moneyVat: json["MONEY_VAT"],
        kpiHt: json["KPI_HT"],
        exchangeWeight: json["EXCHANGE_WEIGHT"],
      );

  Map<String, dynamic> toJson() => {
        "MONEY_TOTAL_OLD": moneyTotalOld,
        "MONEY_TOTAL": moneyTotal,
        "MONEY_TOTAL_FEE": moneyTotalFee,
        "MONEY_FEE": moneyFee,
        "MONEY_COLLECTION_FEE": moneyCollectionFee,
        "MONEY_OTHER_FEE": moneyOtherFee,
        "MONEY_VAS": moneyVas,
        "MONEY_VAT": moneyVat,
        "KPI_HT": kpiHt,
        "EXCHANGE_WEIGHT": exchangeWeight,
      };
}
