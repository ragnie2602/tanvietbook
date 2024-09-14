class EventResponse {
  String? id;
  String? title;
  int? status;
  String? date;
  String? startTime;
  String? endTime;
  int? limitGuests;
  String? location;
  String? district;
  List<String>? banner;
  String? description;
  String? note;
  String? createdBy;
  String? createdDate;
  String? lastModifiedBy;
  String? lastModifiedDate;
  String? pic;
  int? eventType;
  int? scale;
  String? error;
  String? startDate;
  String? endDate;
  String? eventID;
  String? guest;
  String? city;
  String? picture;
  int? statusRegister;
  int? region;
  int? state;
  String? town;

  EventResponse(
      {this.id,
      this.title,
      this.status,
      this.date,
      this.startTime,
      this.endTime,
      this.limitGuests,
      this.location,
      this.district,
      this.banner,
      this.description,
      this.note,
      this.createdBy,
      this.createdDate,
      this.lastModifiedBy,
      this.lastModifiedDate,
      this.pic,
      this.eventType,
      this.scale,
      this.error,
      this.startDate,
      this.endDate,
      this.eventID,
      this.guest,
      this.city,
      this.picture,
      this.statusRegister,
      this.region,
      this.state,
      this.town});

  EventResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    limitGuests = json['limitGuests'];
    location = json['location'];
    district = json['district'];
    banner = json['banner'].cast<String>();
    description = json['description'];
    note = json['note'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    lastModifiedBy = json['lastModifiedBy'];
    lastModifiedDate = json['lastModifiedDate'];
    pic = json['pic'];
    eventType = json['eventType'];
    scale = json['scale'];
    error = json['error'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    eventID = json['eventID'];
    guest = json['guest'];
    city = json['city'];
    picture = json['picture'];
    statusRegister = json['statusRegister'];
    region = json['region'];
    state = json['state'];
    town = json['town'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['status'] = status;
    data['date'] = date;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['limitGuests'] = limitGuests;
    data['location'] = location;
    data['district'] = district;
    data['banner'] = banner;
    data['description'] = description;
    data['note'] = note;
    data['createdBy'] = createdBy;
    data['createdDate'] = createdDate;
    data['lastModifiedBy'] = lastModifiedBy;
    data['lastModifiedDate'] = lastModifiedDate;
    data['pic'] = pic;
    data['eventType'] = eventType;
    data['scale'] = scale;
    data['error'] = error;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['eventID'] = eventID;
    data['guest'] = guest;
    data['city'] = city;
    data['picture'] = picture;
    data['statusRegister'] = statusRegister;
    data['region'] = region;
    data['state'] = state;
    data['town'] = town;
    return data;
  }
}
