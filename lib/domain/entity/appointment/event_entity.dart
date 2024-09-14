import 'calendar_abstract.dart';

class EventEntity extends CalendarAbstract {
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
  int? eventType;
  String? startDate;
  String? endDate;
  String? eventID;
  String? guest;
  String? city;
  String? picture;
  int? statusRegister;
  String? statusRegisterStr;
  int? statusRegisterColor;
  int? region;
  int? state;
  String? town;

  EventEntity(
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
      this.eventType,
      this.startDate,
      this.endDate,
      this.eventID,
      this.guest,
      this.city,
      this.picture,
      this.statusRegister,
      this.statusRegisterStr,
      this.statusRegisterColor,
      this.region,
      this.state,
      this.town});

  EventEntity.fromJson(Map<String, dynamic> json) {
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
    eventType = json['eventType'];
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
    data['eventType'] = eventType;
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
