class CheckinDetail {
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
  String? purpose;
  List<String>? images;
  String? note;
  int? orderTotal;
  String? customerName;
  String? mobileCus;
  String? addressCus;
  String? districtCus;
  String? provinceCus;
  String? communeCus;
  String? agency;
  List<String>? listOrderId;

  CheckinDetail(
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
      this.purpose,
      this.images,
      this.note,
      this.orderTotal,
      this.customerName,
      this.mobileCus,
      this.addressCus,
      this.districtCus,
      this.provinceCus,
      this.communeCus,
      this.agency,
      this.listOrderId});

  CheckinDetail.fromJson(Map<String, dynamic> json) {
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
    purpose = json['purpose'];
    images = json['images'].cast<String>();
    note = json['note'];
    orderTotal = json['orderTotal'];
    customerName = json['customerName'];
    mobileCus = json['mobileCus'];
    addressCus = json['addressCus'];
    districtCus = json['districtCus'];
    provinceCus = json['provinceCus'];
    communeCus = json['communeCus'];
    agency = json['agency'];
    listOrderId = json['listOrderId'].cast<String>();
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
    data['purpose'] = purpose;
    data['images'] = images;
    data['note'] = note;
    data['orderTotal'] = orderTotal;
    data['customerName'] = customerName;
    data['mobileCus'] = mobileCus;
    data['addressCus'] = addressCus;
    data['districtCus'] = districtCus;
    data['provinceCus'] = provinceCus;
    data['communeCus'] = communeCus;
    data['agency'] = agency;
    data['listOrderId'] = listOrderId;
    return data;
  }
}
