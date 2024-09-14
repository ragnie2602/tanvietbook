// To parse this JSON data, do
//
//     final province = provinceFromJson(jsonString);

class Province {
  Province({
    this.label,
    this.value,
    this.parent,
  });

  String? label;
  String? value;
  String? parent;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        label: json["label"],
        value: json["value"],
        parent: json["parent"],
      );
}

class District {
  District({
    this.label,
    this.value,
    this.parent,
  });

  String? label;
  String? value;
  String? parent;

  factory District.fromJson(Map<String, dynamic> json) => District(
        label: json["label"],
        value: json["value"],
        parent: json["parent"],
      );
}

class Ward {
  Ward({
    this.label,
    this.value,
    this.parent,
  });

  String? label;
  String? value;
  String? parent;

  factory Ward.fromJson(Map<String, dynamic> json) => Ward(
        label: json["label"],
        value: json["value"],
        parent: json["parent"],
      );
}
