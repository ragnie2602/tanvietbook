class Purpose {
  String? id;
  String? name;
  String? error;

  Purpose({this.id, this.name, this.error});

  Purpose.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['error'] = error;
    return data;
  }
}
