class UserRoleResponse {
  int? status;
  bool? sale;
  bool? ctv;
  bool? user;

  UserRoleResponse({this.status, this.sale, this.ctv, this.user});

  UserRoleResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sale = json['sale'];
    ctv = json['ctv'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['sale'] = sale;
    data['ctv'] = ctv;
    data['user'] = user;
    return data;
  }
}
