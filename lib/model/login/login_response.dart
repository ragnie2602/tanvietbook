class LoginResponse {
  bool? success;
  int? statusCode;
  Data? data;
  dynamic messages;

  LoginResponse({this.success, this.statusCode, this.data, this.messages});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    messages = json['messages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['messages'] = messages;
    return data;
  }
}

class Data {
  String? accessToken;
  String? refreshToken;
  User? user;

  Data({this.accessToken, this.refreshToken, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  bool? isGuest;
  bool? iapLock;
  bool? emailIsVerified;
  bool? phoneIsVerified;
  int? coin;
  String? username;
  String? idString;

  User({
    this.isGuest,
    this.iapLock,
    this.emailIsVerified,
    this.phoneIsVerified,
    this.coin,
    this.username,
    this.idString,
  });

  User.fromJson(Map<String, dynamic> json) {
    isGuest = json['isGuest'];
    iapLock = json['iapLock'];
    emailIsVerified = json['emailIsVerified'];
    phoneIsVerified = json['phoneIsVerified'];
    coin = json['coin'];
    username = json['username'];
    idString = json['idString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isGuest'] = isGuest;
    data['iapLock'] = iapLock;
    data['emailIsVerified'] = emailIsVerified;
    data['phoneIsVerified'] = phoneIsVerified;
    data['coin'] = coin;
    data['username'] = username;
    data['idString'] = idString;
    return data;
  }
}
