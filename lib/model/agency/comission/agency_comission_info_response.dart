class AgencyComissionInfo {
  String? username;
  String? fullname;
  String? referralCode;
  num? totalPersonalSale;
  num? commissionReceived;
  num? personalSaleReceived;
  num? commissionDuration;
  num? commissionPending;
  num? commissionRejected;
  num? personalSaleDuration;
  num? personalSalePending;
  num? personalSaleRejected;
  num? personalSale;
  num? commission;
  num? personalSaleF1;
  num? commissionF1;
  num? personalSaleF2;
  num? commissionF2;
  String? type;
  String? agency;
  String? accountName;
  String? accountNumber;
  String? bankName;
  dynamic error;

  AgencyComissionInfo(
      {this.username,
      this.fullname,
      this.referralCode,
      this.totalPersonalSale,
      this.commissionReceived,
      this.personalSaleReceived,
      this.commissionDuration,
      this.commissionPending,
      this.commissionRejected,
      this.personalSaleDuration,
      this.personalSalePending,
      this.personalSaleRejected,
      this.personalSale,
      this.commission,
      this.personalSaleF1,
      this.commissionF1,
      this.personalSaleF2,
      this.commissionF2,
      this.type,
      this.agency,
      this.accountName,
      this.accountNumber,
      this.bankName,
      this.error});

  AgencyComissionInfo.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    fullname = json['fullname'];
    referralCode = json['referralCode'];
    totalPersonalSale = json['totalPersonalSale'];
    commissionReceived = json['commissionReceived'];
    personalSaleReceived = json['personalSaleReceived'];
    commissionDuration = json['commissionDuration'];
    commissionPending = json['commissionPending'];
    commissionRejected = json['commissionRejected'];
    personalSaleDuration = json['personalSaleDuration'];
    personalSalePending = json['personalSalePending'];
    personalSaleRejected = json['personalSaleRejected'];
    personalSale = json['personalSale'];
    commission = json['commission'];
    personalSaleF1 = json['personalSaleF1'];
    commissionF1 = json['commissionF1'];
    personalSaleF2 = json['personalSaleF2'];
    commissionF2 = json['commissionF2'];
    type = json['type'];
    agency = json['agency'];
    accountName = json['accountName'];
    accountNumber = json['accountNumber'];
    bankName = json['bankName'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['fullname'] = fullname;
    data['referralCode'] = referralCode;
    data['totalPersonalSale'] = totalPersonalSale;
    data['commissionReceived'] = commissionReceived;
    data['personalSaleReceived'] = personalSaleReceived;
    data['commissionDuration'] = commissionDuration;
    data['commissionPending'] = commissionPending;
    data['commissionRejected'] = commissionRejected;
    data['personalSaleDuration'] = personalSaleDuration;
    data['personalSalePending'] = personalSalePending;
    data['personalSaleRejected'] = personalSaleRejected;
    data['personalSale'] = personalSale;
    data['commission'] = commission;
    data['personalSaleF1'] = personalSaleF1;
    data['commissionF1'] = commissionF1;
    data['personalSaleF2'] = personalSaleF2;
    data['commissionF2'] = commissionF2;
    data['type'] = type;
    data['agency'] = agency;
    data['accountName'] = accountName;
    data['accountNumber'] = accountNumber;
    data['bankName'] = bankName;
    data['error'] = error;
    return data;
  }
}
