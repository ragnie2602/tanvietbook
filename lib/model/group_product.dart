import 'dart:convert';

List<GroupProduct> groupProductFromJson(String str) => List<GroupProduct>.from(
    json.decode(str).map((x) => GroupProduct.fromJson(x)));

String groupProductToJson(List<GroupProduct> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GroupProduct {
  GroupProduct({
    this.subTabId,
    this.productGroupName,
    this.memberId,
    this.id,
  });

  String? subTabId;
  String? productGroupName;
  String? memberId;
  String? id;

  factory GroupProduct.fromJson(Map<String, dynamic> json) => GroupProduct(
        subTabId: json["subTabId"],
        productGroupName: json["productGroupName"],
        memberId: json["memberId"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "subTabId": subTabId,
        "productGroupName": productGroupName,
        "memberId": memberId,
        "id": id,
      };
}
