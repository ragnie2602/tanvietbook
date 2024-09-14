import 'dart:convert';

List<SubTab> subTabFromJson(String str) =>
    List<SubTab>.from(json.decode(str).map((x) => SubTab.fromJson(x)));

String subTabToJson(List<SubTab> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubTab {
  SubTab({
    this.businessTabId,
    this.name,
    this.dataType,
    this.id,
  });

  String? businessTabId;
  String? name;
  String? dataType;
  String? id;

  factory SubTab.fromJson(Map<String, dynamic> json) => SubTab(
        businessTabId: json["businessTabId"],
        name: json["name"],
        dataType: json["dataType"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "businessTabId": businessTabId,
        "name": name,
        "dataType": dataType,
        "id": id,
      };
}
