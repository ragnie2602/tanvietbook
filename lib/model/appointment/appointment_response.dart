class AppointmentResponse {
  String? id;
  String? routeId;
  String? customerId;
  String? customerName;
  String? customerPhone;
  String? address;
  String? employeeName;
  String? employeeUserName;
  String? position;
  String? salerName;
  String? dateAppointment;
  String? location;
  String? district;
  String? province;
  String? ward;
  String? purpose;
  String? note;
  String? status;
  int? type;
  String? agency;
  double? longitude;
  double? latitude;
  String? code;
  String? error;

  AppointmentResponse(
      {this.id,
      this.routeId,
      this.customerId,
      this.customerName,
      this.customerPhone,
      this.address,
      this.employeeName,
      this.employeeUserName,
      this.position,
      this.salerName,
      this.dateAppointment,
      this.location,
      this.district,
      this.province,
      this.ward,
      this.purpose,
      this.note,
      this.status,
      this.type,
      this.agency,
      this.longitude,
      this.latitude,
      this.code,
      this.error});

  AppointmentResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    routeId = json['routeId'];
    customerId = json['customerId'];
    customerName = json['customerName'];
    customerPhone = json['customerPhone'];
    address = json['address'];
    employeeName = json['employeeName'];
    employeeUserName = json['employeeUserName'];
    position = json['position'];
    salerName = json['salerName'];
    dateAppointment = json['dateAppointment'];
    location = json['location'];
    district = json['district'];
    province = json['province'];
    ward = json['ward'];
    purpose = json['purpose'];
    note = json['note'];
    status = json['status'];
    type = json['type'];
    agency = json['agency'];
    longitude = 0.0 + (json['longitude'] ?? 0);
    latitude = 0.0 + (json['latitude'] ?? 0);
    code = json['code'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['routeId'] = routeId;
    data['customerId'] = customerId;
    data['customerName'] = customerName;
    data['customerPhone'] = customerPhone;
    data['address'] = address;
    data['employeeName'] = employeeName;
    data['employeeUserName'] = employeeUserName;
    data['position'] = position;
    data['salerName'] = salerName;
    data['dateAppointment'] = dateAppointment;
    data['location'] = location;
    data['district'] = district;
    data['province'] = province;
    data['ward'] = ward;
    data['purpose'] = purpose;
    data['note'] = note;
    data['status'] = status;
    data['type'] = type;
    data['agency'] = agency;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['code'] = code;
    data['error'] = error;
    return data;
  }
}
