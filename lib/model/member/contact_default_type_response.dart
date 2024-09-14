class ContactDefaultTypeResponse {
  String? type;
  String? label;
  String? value;
  String? iconUrl;

  ContactDefaultTypeResponse({this.type, this.iconUrl, this.value, this.label});

  ContactDefaultTypeResponse.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    type = json['type'];
    iconUrl = json['iconUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    data['type'] = type;
    data['iconUrl'] = iconUrl;
    return data;
  }
}
