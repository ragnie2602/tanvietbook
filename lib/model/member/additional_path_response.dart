class AdditionalPathInfoResponse {
  String? id;
  String? pathBaseId;
  String? type;
  String? title;
  String? value;
  String? image;
  bool? hidden;
  String? icon;
  bool? enableLink;

  AdditionalPathInfoResponse({
    this.id,
    this.pathBaseId,
    this.type,
    this.title,
    this.value,
    this.image,
    this.hidden,
    this.enableLink,
    this.icon,
  });

  AdditionalPathInfoResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pathBaseId = json['pathBaseId'];
    type = json['type'];
    title = json['title'];
    value = json['value'];
    image = json['image'];
    hidden = json['hidden'];
    enableLink = json['enableLink'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pathBaseId'] = pathBaseId;
    data['type'] = type;
    data['title'] = title;
    data['value'] = value;
    data['image'] = image;
    data['hidden'] = hidden;
    data['enableLink'] = enableLink;
    data['icon'] = icon;
    return data;
  }
}
