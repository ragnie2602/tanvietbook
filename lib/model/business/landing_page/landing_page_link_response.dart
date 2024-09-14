class LandingPageLinkResponse {
  String? id;
  String? value;
  String? title;
  String? error;

  LandingPageLinkResponse({this.id, this.value, this.title, this.error});

  LandingPageLinkResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    title = json['title'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['value'] = value;
    data['title'] = title;
    data['error'] = error;
    return data;
  }
}
