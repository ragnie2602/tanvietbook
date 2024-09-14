class AgencyComissionTree {
  String? username;
  String? fullname;
  String? type;
  int? quantityLv1;
  int? quantityLv2;
  String? referralCode;
  String? referralFullname;
  num? totalPersonalSale;
  List<Level1>? level1;

  AgencyComissionTree(
      {this.username,
      this.fullname,
      this.type,
      this.quantityLv1,
      this.quantityLv2,
      this.referralCode,
      this.referralFullname,
      this.totalPersonalSale,
      this.level1});

  AgencyComissionTree.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    fullname = json['fullname'];
    type = json['type'];
    quantityLv1 = json['quantityLv1'];
    quantityLv2 = json['quantityLv2'];
    referralCode = json['referralCode'];
    referralFullname = json['referralFullname'];
    totalPersonalSale = json['totalPersonalSale'];
    if (json['level1'] != null) {
      level1 = <Level1>[];
      json['level1'].forEach((v) {
        level1!.add(Level1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['fullname'] = fullname;
    data['type'] = type;
    data['quantityLv1'] = quantityLv1;
    data['quantityLv2'] = quantityLv2;
    data['referralCode'] = referralCode;
    data['referralFullname'] = referralFullname;
    data['totalPersonalSale'] = totalPersonalSale;
    if (level1 != null) {
      data['level1'] = level1!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Level1 {
  String? username;
  String? fullname;
  String? type;
  int? quantityLv1;
  int? quantityLv2;
  String? referralCode;
  num? totalPersonalSale;
  String? referralFullname;
  List<Level2>? level2;

  Level1(
      {this.username,
      this.fullname,
      this.type,
      this.quantityLv1,
      this.quantityLv2,
      this.referralCode,
      this.totalPersonalSale,
      this.referralFullname,
      this.level2});

  Level1.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    fullname = json['fullname'];
    type = json['type'];
    quantityLv1 = json['quantityLv1'];
    quantityLv2 = json['quantityLv2'];
    referralCode = json['referralCode'];
    totalPersonalSale = json['totalPersonalSale'];
    referralFullname = json['referralFullname'];
    if (json['level2'] != null) {
      level2 = <Level2>[];
      json['level2'].forEach((v) {
        level2!.add(Level2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['fullname'] = fullname;
    data['type'] = type;
    data['quantityLv1'] = quantityLv1;
    data['quantityLv2'] = quantityLv2;
    data['referralCode'] = referralCode;
    data['totalPersonalSale'] = totalPersonalSale;
    data['referralFullname'] = referralFullname;
    if (level2 != null) {
      data['level2'] = level2!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Level2 {
  String? username;
  String? fullname;
  String? type;
  num? totalPersonalSale;
  int? quantityLv1;
  int? quantityLv2;
  String? referralCode;
  String? referralFullname;

  Level2(
      {this.username,
      this.fullname,
      this.type,
      this.totalPersonalSale,
      this.quantityLv1,
      this.quantityLv2,
      this.referralCode,
      this.referralFullname});

  Level2.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    fullname = json['fullname'];
    type = json['type'];
    totalPersonalSale = json['totalPersonalSale'];
    quantityLv1 = json['quantityLv1'];
    quantityLv2 = json['quantityLv2'];
    referralCode = json['referralCode'];
    referralFullname = json['referralFullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['fullname'] = fullname;
    data['type'] = type;
    data['totalPersonalSale'] = totalPersonalSale;
    data['quantityLv1'] = quantityLv1;
    data['quantityLv2'] = quantityLv2;
    data['referralCode'] = referralCode;
    data['referralFullname'] = referralFullname;
    return data;
  }
}
