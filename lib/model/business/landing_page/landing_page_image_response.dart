class LandingPageImageResponse {
  String? id;
  String? value;
  String? title;
  String? error;

  LandingPageImageResponse({this.id, this.value, this.title, this.error});

  LandingPageImageResponse.fromJson(Map<String, dynamic> json) {
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
