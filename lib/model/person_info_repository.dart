import 'dart:convert';

List<Info> infoFromJson(String str) =>
    List<Info>.from(json.decode(str).map((x) => Info.fromJson(x)));

String infoToJson(List<Info> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Info {
  Info({
    this.memberId,
    this.type,
    this.hidden,
    this.unUsed,
    this.priority,
    this.id,
  });

  String? memberId;
  String? type;
  bool? hidden;
  bool? unUsed;
  int? priority;
  String? id;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        memberId: json["memberId"],
        type: json["type"],
        hidden: json["hidden"],
        unUsed: json["unUsed"],
        priority: json["priority"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "memberId": memberId,
        "type": type,
        "hidden": hidden,
        "unUsed": unUsed,
        "priority": priority,
        "id": id,
      };
}
