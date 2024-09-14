class RouteEntity {
  String? id;
  String? code;
  String? name;
  String? error;

  RouteEntity({this.id, this.code, this.name, this.error});

  RouteEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['error'] = error;
    return data;
  }
}
