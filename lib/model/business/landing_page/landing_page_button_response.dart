class LandingPageButtonResponse {
  String? id;
  String? landingID;
  String? landingPageActionsId;
  String? link;
  String? title;
  String? actionInfor;
  List<String>? actions;
  String? backgroundAction;
  String? backgroundColorAction;
  String? value;
  int? border;
  String? textColor;
  String? backgroundColor;
  int? type;
  String? error;

  LandingPageButtonResponse(
      {this.id,
      this.landingID,
      this.landingPageActionsId,
      this.link,
      this.title,
      this.actionInfor,
      this.actions,
      this.backgroundAction,
      this.backgroundColorAction,
      this.value,
      this.border,
      this.textColor,
      this.backgroundColor,
      this.type,
      this.error});

  LandingPageButtonResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    landingID = json['landingID'];
    landingPageActionsId = json['landingPageActionsId'];
    link = json['link'];
    title = json['title'];
    actionInfor = json['actionInfor'];
    actions = json['actions'] == null ? null : json["actions"].cast<String>();
    backgroundAction = json['backgroundAction'];
    backgroundColorAction = json['backgroundColorAction'];
    value = json['value'];
    border = json['border'];
    textColor = json['textColor'];
    backgroundColor = json['backgroundColor'];
    type = json['type'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['landingID'] = landingID;
    data['landingPageActionsId'] = landingPageActionsId;
    data['link'] = link;
    data['title'] = title;
    data['actionInfor'] = actionInfor;
    data['actions'] = actions;
    data['backgroundAction'] = backgroundAction;
    data['backgroundColorAction'] = backgroundColorAction;
    data['value'] = value;
    data['border'] = border;
    data['textColor'] = textColor;
    data['backgroundColor'] = backgroundColor;
    data['type'] = type;
    data['error'] = error;
    return data;
  }
}
