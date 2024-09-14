class BasicInfo {
  String? email;
  String? phoneNumber;

  BasicInfo({
    this.email,
    this.phoneNumber,
  });

  factory BasicInfo.fromJson(Map<String, dynamic> json) => BasicInfo(
        email: json["email"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "phoneNumber": phoneNumber,
      };
}
