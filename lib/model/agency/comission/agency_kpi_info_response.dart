class KPIInfoResponse {
  String? id;
  String? code;
  String? name;
  int? type;
  num? target;
  num? weighted;
  num? completionRate;
  num? reality;
  dynamic error;

  KPIInfoResponse(
      {this.id,
      this.code,
      this.name,
      this.type,
      this.target,
      this.weighted,
      this.completionRate,
      this.reality,
      this.error});

  KPIInfoResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    type = json['type'];
    target = json['target'];
    weighted = json['weighted'];
    completionRate = json['completionRate'];
    reality = json['reality'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['type'] = type;
    data['target'] = target;
    data['weighted'] = weighted;
    data['completionRate'] = completionRate;
    data['reality'] = reality;
    data['error'] = error;
    return data;
  }
}
