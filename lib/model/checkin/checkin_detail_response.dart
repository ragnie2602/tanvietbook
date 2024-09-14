class CheckinDetailResponse {
  String? id;
  String? routeId;
  String? customerId;
  String? locationCheckin;
  double? longitudeCheckin;
  double? latitudeCheckin;
  String? timeCheckin;
  String? locationCheckout;
  double? longitudeCheckout;
  double? latitudeCheckout;
  String? timeCheckout;
  String? duration;
  String? purpose;
  List<String>? images;
  String? note;
  int? status;
  int? orderTotal;
  String? appointmentId;
  int? state;
  String? salerName;
  int? type;
  String? customerName;
  String? mobileCus;
  String? addressCus;
  String? districtCus;
  String? provinceCus;
  String? communeCus;
  String? agency;
  List<String>? listOrderId;
  String? error;

  CheckinDetailResponse(
      {this.id,
      this.routeId,
      this.customerId,
      this.locationCheckin,
      this.longitudeCheckin,
      this.latitudeCheckin,
      this.timeCheckin,
      this.locationCheckout,
      this.longitudeCheckout,
      this.latitudeCheckout,
      this.timeCheckout,
      this.duration,
      this.purpose,
      this.images,
      this.note,
      this.status,
      this.orderTotal,
      this.appointmentId,
      this.state,
      this.salerName,
      this.type,
      this.customerName,
      this.mobileCus,
      this.addressCus,
      this.districtCus,
      this.provinceCus,
      this.communeCus,
      this.agency,
      this.listOrderId,
      this.error});

  CheckinDetailResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    routeId = json['routeId'];
    customerId = json['customerId'];
    locationCheckin = json['locationCheckin'];
    longitudeCheckin = json['longitudeCheckin'];
    latitudeCheckin = json['latitudeCheckin'];
    timeCheckin = json['timeCheckin'];
    locationCheckout = json['locationCheckout'];
    longitudeCheckout = json['longitudeCheckout'];
    latitudeCheckout = json['latitudeCheckout'];
    timeCheckout = json['timeCheckout'];
    duration = json['duration'];
    purpose = json['purpose'];
    images = (json['images'] ?? []).cast<String>();
    note = json['note'];
    status = json['status'];
    orderTotal = json['orderTotal'];
    appointmentId = json['appointmentId'];
    state = json['state'];
    salerName = json['salerName'];
    type = json['type'];
    customerName = json['customerName'];
    mobileCus = json['mobileCus'];
    addressCus = json['addressCus'];
    districtCus = json['districtCus'];
    provinceCus = json['provinceCus'];
    communeCus = json['communeCus'];
    agency = json['agency'];
    listOrderId = (json['listOrderId'] ?? []).cast<String>();
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['routeId'] = routeId;
    data['customerId'] = customerId;
    data['locationCheckin'] = locationCheckin;
    data['longitudeCheckin'] = longitudeCheckin;
    data['latitudeCheckin'] = latitudeCheckin;
    data['timeCheckin'] = timeCheckin;
    data['locationCheckout'] = locationCheckout;
    data['longitudeCheckout'] = longitudeCheckout;
    data['latitudeCheckout'] = latitudeCheckout;
    data['timeCheckout'] = timeCheckout;
    data['duration'] = duration;
    data['purpose'] = purpose;
    data['images'] = images;
    data['note'] = note;
    data['status'] = status;
    data['orderTotal'] = orderTotal;
    data['appointmentId'] = appointmentId;
    data['state'] = state;
    data['salerName'] = salerName;
    data['type'] = type;
    data['customerName'] = customerName;
    data['mobileCus'] = mobileCus;
    data['addressCus'] = addressCus;
    data['districtCus'] = districtCus;
    data['provinceCus'] = provinceCus;
    data['communeCus'] = communeCus;
    data['agency'] = agency;
    data['listOrderId'] = listOrderId;
    data['error'] = error;
    return data;
  }
}
