class Customer {
  String? id;
  String? routeId;
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
  String? timeCheckinRecent;
  int? totalCheckin;
  int? totalOrder;

  Customer(
      {this.id,
      this.routeId,
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
      this.timeCheckinRecent,
      this.totalCheckin,
      this.totalOrder});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    routeId = json['routeId'];
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
    timeCheckinRecent = json['timeCheckinRecent'];
    totalCheckin = json['totalCheckin'];
    totalOrder = json['totalOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['routeId'] = routeId;
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
    data['timeCheckinRecent'] = timeCheckinRecent;
    data['totalCheckin'] = totalCheckin;
    data['totalOrder'] = totalOrder;
    return data;
  }
}
