class Store {
  Store({
    this.memberId,
    this.name,
    this.field,
    this.bio,
    this.address,
    this.email,
    this.phoneNumber,
    this.id,
  });

  String? memberId;
  String? name;
  String? field;
  String? bio;
  String? address;
  String? email;
  String? phoneNumber;
  String? id;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        memberId: json["memberId"],
        name: json["name"],
        field: json["field"],
        bio: json["bio"],
        address: json["address"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "memberId": memberId,
        "name": name,
        "field": field,
        "bio": bio,
        "address": address,
        "email": email,
        "phoneNumber": phoneNumber,
        "id": id,
      };
}
