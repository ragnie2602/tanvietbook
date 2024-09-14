// To parse this JSON data, do
//
//     final province = provinceFromJson(jsonString);

class Province {
  Province({
    this.name,
    this.code,
    this.divisionType,
    this.codename,
    this.phoneCode,
    this.districts,
  });

  String? name;
  int? code;
  String? divisionType;
  String? codename;
  int? phoneCode;
  List<District>? districts = [];

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        name: json["name"],
        code: json["code"],
        divisionType: json["division_type"],
        codename: json["codename"],
        phoneCode: json["phone_code"],
        districts: List<District>.from(
            json["districts"].map((x) => District.fromJson(x))),
      );
}

class District {
  District({
    this.name,
    this.code,
    this.divisionType,
    this.codename,
    this.provinceCode,
    this.wards,
  });

  String? name;
  int? code;
  String? divisionType;
  String? codename;
  int? provinceCode;
  List<Ward>? wards;

  factory District.fromJson(Map<String, dynamic> json) => District(
        name: json["name"],
        code: json["code"],
        divisionType: json["division_type"],
        codename: json["codename"],
        provinceCode: json["province_code"],
        wards: List<Ward>.from(json["wards"].map((x) => Ward.fromJson(x))),
      );
}

class Ward {
  Ward({
    this.name,
    this.code,
    this.divisionType,
    this.codename,
    this.districtCode,
  });

  String? name;
  int? code;
  String? divisionType;
  String? codename;
  int? districtCode;

  factory Ward.fromJson(Map<String, dynamic> json) => Ward(
        name: json["name"],
        code: json["code"],
        divisionType: json["division_type"],
        codename: json["codename"],
        districtCode: json["district_code"],
      );
}
