class LandingPageContentResponse {
  String? id;
  String? value;
  String? title;
  String? background;
  String? error;

  LandingPageContentResponse(
      {this.id, this.value, this.title, this.background, this.error});

  LandingPageContentResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    title = json['title'];
    background = json['background'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['value'] = value;
    data['title'] = title;
    data['background'] = background;
    data['error'] = error;
    return data;
  }
}
