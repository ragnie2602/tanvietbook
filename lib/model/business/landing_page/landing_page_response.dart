class LandingPageResponse {
  String? id;
  String? categoryID;
  int? type;
  String? title;
  String? error;
  dynamic key;

  LandingPageResponse(
      {this.id, this.categoryID, this.type, this.title, this.error});

  LandingPageResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryID = json['categoryID'];
    type = json['type'];
    title = json['title'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['categoryID'] = categoryID;
    data['type'] = type;
    data['title'] = title;
    data['error'] = error;
    return data;
  }
}
