class NotificationDetailResponse {
  String? id;
  String? title;
  String? body;
  String? note;
  String? metadata;
  String? notiType;
  bool? isSeen;
  String? createdBy;
  String? createdDate;
  String? lastModifiedDate;

  NotificationDetailResponse(
      {this.id,
      this.title,
      this.body,
      this.note,
      this.notiType,
      this.metadata,
      this.isSeen,
      this.createdBy,
      this.createdDate,
      this.lastModifiedDate});

  NotificationDetailResponse.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    title = json['Title'];
    body = json['Body'];
    note = json['Note'];
    notiType = json['NotiType'];
    metadata = json['Metadata'];
    isSeen = json['IsSeen'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
    lastModifiedDate = json['LastModifiedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Title'] = title;
    data['Body'] = body;
    data['Note'] = note;
    data['Metadata'] = metadata;
    data['NotiType'] = notiType;
    data['IsSeen'] = isSeen;
    data['CreatedBy'] = createdBy;
    data['CreatedDate'] = createdDate;
    data['LastModifiedDate'] = lastModifiedDate;
    return data;
  }
}
