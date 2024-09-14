import 'dart:convert';

ResponseLogin responseLoginFromJson(String str) =>
    ResponseLogin.fromJson(json.decode(str));

String responseLoginToJson(ResponseLogin data) => json.encode(data.toJson());

class ResponseLogin {
  ResponseLogin({
    this.idToken,
    this.keyLicense,
  });

  String? idToken;
  String? keyLicense;

  factory ResponseLogin.fromJson(Map<String, dynamic> json) => ResponseLogin(
        idToken: json["id_token"],
        keyLicense: json["key_license"],
      );

  Map<String, dynamic> toJson() => {
        "id_token": idToken,
        "key_license": keyLicense,
      };
}
