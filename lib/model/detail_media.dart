import 'dart:convert';

List<DetailMedia> detailMediaFromJson(String str) => List<DetailMedia>.from(
    json.decode(str).map((x) => DetailMedia.fromJson(x)));
List<DetailMedia> detailMediaFromListDynamic(List<dynamic> list) =>
    List<DetailMedia>.from(list.map((x) => DetailMedia.fromJson(x)));
String detailMediaToJson(List<DetailMedia> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DetailMedia {
  DetailMedia({
    this.value,
    this.type,
    this.areaCode,
    this.priority,
    this.hidden,
    this.id,
  });

  String? value;
  String? type;
  String? areaCode;
  int? priority;
  bool? hidden;
  String? id;

  factory DetailMedia.fromJson(Map<String, dynamic> json) => DetailMedia(
        value: json["value"],
        type: json["type"],
        areaCode: json["areaCode"],
        priority: json["priority"],
        hidden: json["hidden"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "type": type,
        "areaCode": areaCode,
      };
}
