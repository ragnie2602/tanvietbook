import 'notification_detail_response.dart';

class NotificationDetailResponseWrapper {
  List<NotificationDetailResponse>? data;
  int? totalCount;
  String? type;

  NotificationDetailResponseWrapper({this.data, this.totalCount, this.type});

  NotificationDetailResponseWrapper.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = <NotificationDetailResponse>[];
      json['Data'].forEach((v) {
        data!.add(NotificationDetailResponse.fromJson(v));
      });
    }
    totalCount = json['TotalCount'];
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['TotalCount'] = totalCount;
    data['Type'] = type;
    return data;
  }
}
