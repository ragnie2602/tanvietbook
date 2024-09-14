class GetShippingFeeRequest {
  final num? productPrice;
  final num? moneyCollection;
  final String? orderServiceAdd;
  final String? orderService;
  String? senderAddress;
  String? receiverAddress;
  int? productWeight;
  int? productLength;
  int? productWidth;
  int? productHeight;
  final String? productType;
  final int? nationalType;

  GetShippingFeeRequest({
    this.productWeight,
    this.productPrice,
    this.moneyCollection,
    this.orderServiceAdd,
    this.orderService,
    this.senderAddress,
    this.receiverAddress,
    this.productLength,
    this.productWidth,
    this.productHeight,
    this.productType,
    this.nationalType,
  });

  Map<String, dynamic> toJson() => {
        "PRODUCT_WEIGHT": productWeight,
        "PRODUCT_PRICE": productPrice,
        "MONEY_COLLECTION": moneyCollection,
        "ORDER_SERVICE_ADD": orderServiceAdd,
        "ORDER_SERVICE": orderService,
        "SENDER_ADDRESS": senderAddress,
        "RECEIVER_ADDRESS": receiverAddress,
        "PRODUCT_LENGTH": productLength,
        "PRODUCT_WIDTH": productWidth,
        "PRODUCT_HEIGHT": productHeight,
        "PRODUCT_TYPE": productType,
        "NATIONAL_TYPE": nationalType,
      };
}
