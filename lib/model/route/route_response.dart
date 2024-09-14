class RouteResponse {
  String? id;
  String? code;
  String? name;
  String? area;
  String? province;
  String? manager;
  String? desciption;
  String? agency;
  String? error;

  RouteResponse(
      {this.id,
      this.code,
      this.name,
      this.area,
      this.province,
      this.manager,
      this.desciption,
      this.agency,
      this.error});

  RouteResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    area = json['area'];
    province = json['province'];
    manager = json['manager'];
    desciption = json['desciption'];
    agency = json['agency'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['area'] = area;
    data['province'] = province;
    data['manager'] = manager;
    data['desciption'] = desciption;
    data['agency'] = agency;
    data['error'] = error;
    return data;
  }
}
