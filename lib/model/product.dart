import 'dart:convert';

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
List<Product> productsFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));
Product productFromJson(String str) => Product.fromJson(json.decode(str));

class Product {
  Product({
    this.id,
    this.productGroupId,
    this.productName,
    this.productDescription,
    this.productGroupName,
    this.prices,
    this.discountPrices,
    this.unit,
    this.color,
    this.size,
    this.video,
    this.otherCataloge,
    this.origin,
    this.acceptedShippingMthodId,
    this.acceptedPaymentmethodId,
    this.note,
    this.images,
    this.hidden,
    this.outOfStock,
  });

  String? id;
  String? productGroupId;
  String? productName;
  String? productDescription;
  String? productGroupName;
  double? prices;
  double? discountPrices;
  String? unit;
  String? color;
  String? size;
  String? video;
  String? otherCataloge;
  String? origin;
  String? acceptedShippingMthodId;
  String? acceptedPaymentmethodId;
  String? note;
  List<ProductImage>? images;
  bool? hidden;
  bool? outOfStock;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        productGroupId: json["productGroupID"],
        productName: json["productName"],
        productDescription: json["productDescription"],
        productGroupName: json["productGroupName"],
        prices: json["prices"],
        discountPrices: json["discountPrices"],
        unit: json["unit"],
        color: json["color"],
        size: json["size"],
        video: json["video"],
        otherCataloge: json["otherCataloge"],
        origin: json["origin"],
        acceptedShippingMthodId: json["acceptedShippingMthodID"],
        acceptedPaymentmethodId: json["acceptedPaymentmethodID"],
        note: json["note"],
        images: List<ProductImage>.from(
            json["images"].map((x) => ProductImage.fromJson(x))),
        hidden: json["hidden"],
        outOfStock: json["outOfStock"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productGroupID": productGroupId,
        "productName": productName,
        "productDescription": productDescription,
        "productGroupName": productGroupName,
        "prices": prices,
        "discountPrices": discountPrices,
        "unit": unit,
        "color": color,
        "size": size,
        "video": video,
        "otherCataloge": otherCataloge,
        "origin": origin,
        "acceptedShippingMthodID": acceptedShippingMthodId,
        "acceptedPaymentmethodID": acceptedPaymentmethodId,
        "note": note,
        "images": List<ProductImage>.from(images!.map((x) => x.toJson())),
      };
}

class ProductImage {
  ProductImage({
    this.id,
    this.value,
  });

  String? id;
  String? value;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        id: json["id"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
      };
}
