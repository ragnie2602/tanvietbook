// ignore_for_file: empty_catches

import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

// String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    this.totalCount,
    this.productConcerned,
  });

  int? totalCount;
  List<ProductConcerned>? productConcerned;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      totalCount: json["totalCount"],
      productConcerned: List<ProductConcerned>.from(
          json["productConcerned"].map((x) => ProductConcerned.fromJson(x))),
    );
  }
}

class ProductConcerned {
  ProductConcerned({
    this.id,
    this.quantity,
    this.memberId,
    this.productId,
    this.phonenumber,
    this.address,
    this.fullName,
    this.ip,
    this.createdDate,
    this.lastModified,
    this.status,
    this.productName,
    this.productDetail,
  });

  String? id;
  int? quantity;
  String? memberId;
  String? productId;
  String? phonenumber;
  String? address;
  String? fullName;
  String? ip;
  DateTime? createdDate;
  DateTime? lastModified;
  String? status;
  String? productName;
  ProductDetail? productDetail;

  factory ProductConcerned.fromJson(Map<String, dynamic> json) {
    return ProductConcerned(
      id: json["id"],
      quantity: json["quantity"],
      memberId: json["memberId"],
      productId: json["productId"],
      phonenumber: json["phonenumber"],
      address: json["address"],
      fullName: json["fullName"],
      ip: json["ip"],
      createdDate: DateTime.parse(json["createdDate"]),
      lastModified: json["lastModified"] == null
          ? null
          : DateTime.parse(json["lastModified"]),
      status: json["status"],
      productName: json["productName"],
      productDetail: json["productDetail"] == null
          ? null
          : ProductDetail.fromJson(json["productDetail"]),
    );
  }
}

class ProductDetail {
  ProductDetail({
    this.productGroupId,
    this.productName,
    this.productDescription,
    this.productGroupName,
    this.prices,
    this.unit,
    this.color,
    this.size,
    this.video,
    this.otherCataloge,
    this.origin,
    this.acceptedShippingMthodId,
    this.acceptedPaymentmethodId,
    this.note,
    this.memberId,
    this.createDate,
    this.medias,
    this.id,
  });

  String? productGroupId;
  String? productName;
  String? productDescription;
  String? productGroupName;
  String? prices;
  String? unit;
  String? color;
  String? size;
  String? video;
  String? otherCataloge;
  String? origin;
  String? acceptedShippingMthodId;
  String? acceptedPaymentmethodId;
  String? note;
  String? memberId;
  DateTime? createDate;
  List<Media>? medias;
  String? id;

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    try {
      ProductDetail(
        productGroupId: json["productGroupID"],
        productName: json["productName"],
        productDescription: json["productDescription"],
        productGroupName: json["productGroupName"],
        prices: json["prices"].toString(),
        unit: json["unit"],
        color: json["color"],
        size: json["size"],
        video: json["video"],
        otherCataloge: json["otherCataloge"],
        origin: json["origin"],
        acceptedShippingMthodId: json["acceptedShippingMthodID"],
        acceptedPaymentmethodId: json["acceptedPaymentmethodID"],
        note: json["note"],
        memberId: json["memberId"],
        createDate: DateTime.parse(json["createDate"]),
        medias: List<Media>.from(json["medias"].map((e) => Media.fromJson(e))),
        id: json["id"],
      );
    } catch (e) {}

    return ProductDetail(
      productGroupId: json["productGroupID"],
      productName: json["productName"],
      productDescription: json["productDescription"],
      productGroupName: json["productGroupName"],
      prices: json["prices"].toString(),
      unit: json["unit"],
      color: json["color"],
      size: json["size"],
      video: json["video"],
      otherCataloge: json["otherCataloge"],
      origin: json["origin"],
      acceptedShippingMthodId: json["acceptedShippingMthodID"],
      acceptedPaymentmethodId: json["acceptedPaymentmethodID"],
      note: json["note"],
      memberId: json["memberId"],
      createDate: DateTime.parse(json["createDate"]),
      medias: List<Media>.from(json["medias"].map((e) => Media.fromJson(e))),
      id: json["id"],
    );
  }
}

class Media {
  Media({
    this.productId,
    this.memberId,
    this.value,
    this.id,
  });

  String? productId;
  String? memberId;
  String? value;
  String? id;

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      productId: json["productId"],
      memberId: json["memberId"],
      value: json["value"],
      id: json["id"],
    );
  }
}
