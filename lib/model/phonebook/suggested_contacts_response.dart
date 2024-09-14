class SuggestedContactsResponse {
  int? suggestedCount;
  int? totalUserCount;
  List<SuggestedContact>? data;

  SuggestedContactsResponse(
      {this.suggestedCount, this.totalUserCount, this.data});

  SuggestedContactsResponse.fromJson(Map<String, dynamic> json) {
    suggestedCount = json['suggested_count'];
    totalUserCount = json['total_user_count'];
    if (json['data'] != null) {
      data = <SuggestedContact>[];
      json['data'].forEach((v) {
        data!.add(SuggestedContact.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['suggested_count'] = suggestedCount;
    data['total_user_count'] = totalUserCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SuggestedContact {
  String? id;
  String? fullName;
  String? login;
  String? avatar;

  SuggestedContact({this.id, this.fullName, this.login, this.avatar});

  SuggestedContact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    login = json['login'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['login'] = login;
    data['avatar'] = avatar;
    return data;
  }
}
