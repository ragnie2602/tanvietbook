class AgencyCartItemResponse {
  String? id;
  int? amount;
  CartItemProduct? product;
  String? userId;
  String? createdDate;

  AgencyCartItemResponse(
      {this.id, this.amount, this.product, this.userId, this.createdDate});

  AgencyCartItemResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    product = json['product'] != null
        ? CartItemProduct.fromJson(json['product'])
        : null;
    userId = json['userId'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['userId'] = userId;
    data['createdDate'] = createdDate;
    return data;
  }
}

class CartItemProduct {
  String? id;
  String? propertyId;
  String? name;
  String? sku;
  num? price;
  num? salePrice;
  List<String>? images;
  String? productPropertyImage;
  String? productPropertyName;
  String? agency;
  bool? hidden;
  String? groupProductId;
  num? weight;
  num? length;
  num? height;
  num? width;

  CartItemProduct({
    this.id,
    this.propertyId,
    this.name,
    this.sku,
    this.price,
    this.salePrice,
    this.images,
    this.productPropertyImage,
    this.productPropertyName,
    this.agency,
    this.hidden,
    this.groupProductId,
    this.weight,
    this.length,
    this.height,
    this.width,
  });

  CartItemProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyId = json['propertyId'];
    name = json['name'];
    sku = json['sku'];
    price = json['price'];
    salePrice = json['salePrice'];
    images = json['images'].cast<String>();
    productPropertyImage = json['productPropertyImage'];
    productPropertyName = json['productPropertyName'];
    agency = json['agency'];
    hidden = json['hidden'];
    groupProductId = json['groupProductId'];
    weight = json['weight'];
    length = json['length'];
    height = json['height'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['propertyId'] = propertyId;
    data['name'] = name;
    data['sku'] = sku;
    data['price'] = price;
    data['salePrice'] = salePrice;
    data['images'] = images;
    data['productPropertyImage'] = productPropertyImage;
    data['productPropertyName'] = productPropertyName;
    data['agency'] = agency;
    data['hidden'] = hidden;
    data['groupProductId'] = groupProductId;
    data['weight'] = weight;
    data['length'] = length;
    data['height'] = height;
    data['width'] = width;
    return data;
  }
}
