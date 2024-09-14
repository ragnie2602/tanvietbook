class ContactInfoResponse {
  String? id;
  String? type;
  String? title;
  String? value;
  String? iconUrl;
  String? contactBaseId;
  bool? hidden;
  bool? useAsBase;

  ContactInfoResponse(
      {this.id,
      this.contactBaseId,
      this.hidden,
      this.type,
      this.title,
      this.value,
      this.iconUrl,
      this.useAsBase});

  ContactInfoResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    title = json['title'];
    value = json['value'];
    iconUrl = json['iconUrl'];
    hidden = json['hidden'];
    contactBaseId = json['contactBaseId'];
    useAsBase = json['useAsBase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['title'] = title;
    data['value'] = value;
    data['iconUrl'] = iconUrl;
    data['hidden'] = hidden;
    data['contactBaseId'] = contactBaseId;
    data['useAsBase'] = useAsBase;
    return data;
  }
}
