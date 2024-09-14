class OrganizationInfoResponse {
  String? id;
  String? organizationBaseId;
  bool? positionHidden;
  String? position;
  bool? organizationHidden;
  String? organization;
  bool? majorHidden;
  String? major;
  bool? addressHidden;
  String? address;
  bool? departmentHidden;
  String? department;
  bool? taxCodeHidden;
  String? taxCode;
  bool? hotlineHidden;
  String? hotline;
  String? hotlineInfor;
  bool? websiteHidden;
  String? website;
  String? websiteInfor;
  bool? fanpageHidden;
  String? fanpage;
  String? fanpageInfor;

  OrganizationInfoResponse(
      {this.id,
      this.organizationBaseId,
      this.positionHidden,
      this.position,
      this.organizationHidden,
      this.organization,
      this.majorHidden,
      this.major,
      this.addressHidden,
      this.address,
      this.departmentHidden,
      this.department,
      this.taxCodeHidden,
      this.taxCode,
      this.hotlineHidden,
      this.hotline,
      this.hotlineInfor,
      this.websiteHidden,
      this.website,
      this.websiteInfor,
      this.fanpageHidden,
      this.fanpage,
      this.fanpageInfor});

  OrganizationInfoResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organizationBaseId = json['organizationBaseId'];
    positionHidden = json['positionHidden'];
    position = json['position'];
    organizationHidden = json['organizationHidden'];
    organization = json['organization'];
    majorHidden = json['majorHidden'];
    major = json['major'];
    addressHidden = json['addressHidden'];
    address = json['address'];
    departmentHidden = json['departmentHidden'];
    department = json['department'];
    taxCodeHidden = json['taxCodeHidden'];
    taxCode = json['taxCode'];
    hotlineHidden = json['hotlineHidden'];
    hotline = json['hotline'];
    hotlineInfor = json['hotlineInfor'];
    websiteHidden = json['websiteHidden'];
    website = json['website'];
    websiteInfor = json['websiteInfor'];
    fanpageHidden = json['fanpageHidden'];
    fanpage = json['fanpage'];
    fanpageInfor = json['fanpageInfor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['organizationBaseId'] = organizationBaseId;
    data['positionHidden'] = positionHidden;
    data['position'] = position;
    data['organizationHidden'] = organizationHidden;
    data['organization'] = organization;
    data['majorHidden'] = majorHidden;
    data['major'] = major;
    data['addressHidden'] = addressHidden;
    data['address'] = address;
    data['departmentHidden'] = departmentHidden;
    data['department'] = department;
    data['taxCodeHidden'] = taxCodeHidden;
    data['taxCode'] = taxCode;
    data['hotlineHidden'] = hotlineHidden;
    data['hotline'] = hotline;
    data['hotlineInfor'] = hotlineInfor;
    data['websiteHidden'] = websiteHidden;
    data['website'] = website;
    data['websiteInfor'] = websiteInfor;
    data['fanpageHidden'] = fanpageHidden;
    data['fanpage'] = fanpage;
    data['fanpageInfor'] = fanpageInfor;
    return data;
  }
}
