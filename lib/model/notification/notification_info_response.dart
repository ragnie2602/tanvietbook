// To parse this JSON data, do
//
//     final notificationsResponse = notificationsResponseFromJson(jsonString);

import 'dart:convert';

List<Notifications> notificationsResponseFromJson(String str) =>
    List<Notifications>.from(
        json.decode(str).map((x) => Notifications.fromJson(x)));

String notificationsResponseToJson(List<Notifications> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationsResponse {
  List<Notifications>? data;
  int? totalCount;

  NotificationsResponse({
    this.data,
    this.totalCount,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      NotificationsResponse(
          data: List<Notifications>.from(
              json["data"].map((x) => Notifications.fromJson(x))),
          totalCount: json["totalCount"]);
}

class Notifications {
  Notifications({
    this.id,
    this.title,
    this.body,
    this.notificationTypeId,
    this.note,
    this.metadata,
    this.isSeen,
    this.createdBy,
    this.createdDate,
    this.lastModifiedDate,
  });

  String? id;
  String? title;
  String? body;
  String? notificationTypeId;
  dynamic note;
  dynamic metadata;
  bool? isSeen;
  String? createdBy;
  DateTime? createdDate;
  DateTime? lastModifiedDate;

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        notificationTypeId: json["notificationTypeId"],
        note: json["note"],
        metadata: json["metadata"],
        isSeen: json["isSeen"],
        createdBy: json["createdBy"],
        createdDate: DateTime.parse(json["createdDate"]),
        lastModifiedDate: DateTime.parse(json["lastModifiedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "notificationTypeId": notificationTypeId,
        "note": note,
        "metadata": metadata,
        "isSeen": isSeen,
        "createdBy": createdBy,
        "createdDate": createdDate,
        "lastModifiedDate": lastModifiedDate,
      };
}
