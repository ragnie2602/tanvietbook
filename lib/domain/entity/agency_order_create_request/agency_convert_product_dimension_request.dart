class ConvertProductDimension {
  int? productWeight;
  int? productLenght;
  int? productWidth;
  int? productHeight;

  ConvertProductDimension(
      {this.productWeight,
      this.productLenght,
      this.productWidth,
      this.productHeight});

  ConvertProductDimension.fromJson(Map<String, dynamic> json) {
    productWeight = json['producT_WEIGHT'];
    productLenght = json['producT_LENGTH'];
    productWidth = json['producT_WIDTH'];
    productHeight = json['producT_HEIGHT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['producT_WEIGHT'] = productWeight;
    data['producT_LENGTH'] = productLenght;
    data['producT_WIDTH'] = productWidth;
    data['producT_HEIGHT'] = productHeight;
    return data;
  }
}
