class JourneyRequest {
  String? agency;
  int? day;
  int? month;
  int? year;
  int? week;
  String? fromDatetime;
  String? toDatetime;
  String? routeId;

  JourneyRequest({this.agency, this.day, this.month, this.year, this.week, this.fromDatetime, this.toDatetime, this.routeId});

  JourneyRequest.fromJson(Map<String, dynamic> json) {
    agency = json['agency'];
    day = json['day'];
    month = json['month'];
    year = json['year'];
    week = json['week'];
    fromDatetime = json['fromDatetime'];
    toDatetime = json['toDatetime'];
    routeId = json['routeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['agency'] = agency;
    data['day'] = day;
    data['month'] = month;
    data['year'] = year;
    data['week'] = week;
    data['fromDatetime'] = fromDatetime;
    data['toDatetime'] = toDatetime;
    data['routeId'] = routeId;
    return data;
  }
}
