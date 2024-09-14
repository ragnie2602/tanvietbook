import 'dart:convert';

List<ForgotPasswordMethod> forgotPasswordMethodFromJson(List<dynamic> data) =>
    List<ForgotPasswordMethod>.from(
        data.map((x) => ForgotPasswordMethod.fromJson(x)));

String forgotPasswordMethodToJson(List<ForgotPasswordMethod> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ForgotPasswordMethod {
  ForgotPasswordMethod({
    this.type,
    this.value,
  });

  String? type;
  String? value;

  factory ForgotPasswordMethod.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordMethod(
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
      };
}
