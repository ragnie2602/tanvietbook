class UserLogin {
  late String username;
  late String password;
  late bool rememberMe;

  UserLogin(
      {required this.username,
      required this.password,
      required this.rememberMe});

  UserLogin.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    rememberMe = json['rememberMe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['rememberMe'] = rememberMe;
    return data;
  }
}
