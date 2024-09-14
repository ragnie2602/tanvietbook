class CustomerResponse {
  String? id;
  String? routeId;
  String? code;
  String? username;
  String? fullname;
  String? dateOfBirth;
  String? email;
  String? mobile;
  String? address;
  String? district;
  String? province;
  String? commune;
  String? agency;
  int? customerType;
  String? taxCode;
  String? contactPerson;
  String? position;
  String? foundation;
  double? longitude;
  double? latitude;
  String? error;
  String? timeCheckinRecent;
  int? totalCheckin;
  int? totalOrder;

  CustomerResponse(
      {this.id,
      this.routeId,
      this.code,
      this.username,
      this.fullname,
      this.dateOfBirth,
      this.email,
      this.mobile,
      this.address,
      this.district,
      this.province,
      this.commune,
      this.agency,
      this.customerType,
      this.taxCode,
      this.contactPerson,
      this.position,
      this.foundation,
      this.longitude,
      this.latitude,
      this.error,
      this.timeCheckinRecent,
      this.totalCheckin,
      this.totalOrder});

  CustomerResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    routeId = json['routeId'];
    code = json['code'];
    username = json['username'];
    fullname = json['fullname'];
    dateOfBirth = json['dateOfBirth'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    district = json['district'];
    province = json['province'];
    commune = json['commune'];
    agency = json['agency'];
    customerType = json['customerType'];
    taxCode = json['taxCode'];
    contactPerson = json['contactPerson'];
    position = json['position'];
    foundation = json['foundation'];
    longitude = 0.0 + (json['longitude'] ?? 0.0);
    latitude = 0.0 + (json['latitude'] ?? 0.0);
    error = json['error'];
    timeCheckinRecent = json['timeCheckinRecent'];
    totalCheckin = json['totalCheckin'];
    totalOrder = json['totalOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['routeId'] = routeId;
    data['code'] = code;
    data['username'] = username;
    data['fullname'] = fullname;
    data['dateOfBirth'] = dateOfBirth;
    data['email'] = email;
    data['mobile'] = mobile;
    data['address'] = address;
    data['district'] = district;
    data['province'] = province;
    data['commune'] = commune;
    data['agency'] = agency;
    data['customerType'] = customerType;
    data['taxCode'] = taxCode;
    data['contactPerson'] = contactPerson;
    data['position'] = position;
    data['foundation'] = foundation;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['error'] = error;
    data['timeCheckinRecent'] = timeCheckinRecent;
    data['totalCheckin'] = totalCheckin;
    data['totalOrder'] = totalOrder;
    return data;
  }
}
