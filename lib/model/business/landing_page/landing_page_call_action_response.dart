class LandingPageCallActionResponse {
  String? id;
  String? actionInfor;
  String? title;
  String? background;
  List<String>? actions;
  String? error;

  LandingPageCallActionResponse(
      {this.id,
      this.actionInfor,
      this.title,
      this.background,
      this.actions,
      this.error});

  LandingPageCallActionResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    actionInfor = json['actionInfor'];
    title = json['title'];
    background = json['background'];
    if (json['actions'] != null) {
      actions = json['actions'].cast<String>();
    }
    // actions = json['actions'].cast<String>();
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['actionInfor'] = actionInfor;
    data['title'] = title;
    data['background'] = background;
    data['actions'] = actions;
    data['error'] = error;
    return data;
  }
}
