import 'dart:convert';

List<BusinessTab> businessTabFromJson(String str) => List<BusinessTab>.from(
    json.decode(str).map((x) => BusinessTab.fromJson(x)));

String businessTabToJson(List<BusinessTab> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BusinessTab {
  BusinessTab({
    this.memberId,
    this.nameTab,
    this.id,
  });

  String? memberId;
  String? nameTab;
  String? id;

  factory BusinessTab.fromJson(Map<String, dynamic> json) => BusinessTab(
        memberId: json["memberId"],
        nameTab: json["nameTab"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "memberId": memberId,
        "nameTab": nameTab,
        "id": id,
      };
}
