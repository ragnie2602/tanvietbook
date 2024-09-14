class AgencyComissionHistoryResponse {
  String? id;
  String? requestId;
  String? transactionId;
  String? durationId;
  String? username;
  String? purchaseName;
  int? level;
  String? name;
  num? amount;
  num? rate;
  int? type;
  String? status;
  num? commissionAmount;
  String? createdDate;
  String? agency;
  String? groupName;
  String? approvedDate;

  AgencyComissionHistoryResponse(
      {this.id,
      this.requestId,
      this.transactionId,
      this.durationId,
      this.username,
      this.purchaseName,
      this.level,
      this.name,
      this.amount,
      this.rate,
      this.type,
      this.status,
      this.commissionAmount,
      this.createdDate,
      this.agency,
      this.groupName,
      this.approvedDate});

  AgencyComissionHistoryResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['requestId'];
    transactionId = json['transactionId'];
    durationId = json['durationId'];
    username = json['username'];
    purchaseName = json['purchaseName'];
    level = json['level'];
    name = json['name'];
    amount = json['amount'];
    rate = json['rate'];
    type = json['type'];
    status = json['status'];
    commissionAmount = json['commissionAmount'];
    createdDate = json['createdDate'];
    agency = json['agency'];
    groupName = json['groupName'];
    approvedDate = json['approvedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['requestId'] = requestId;
    data['transactionId'] = transactionId;
    data['durationId'] = durationId;
    data['username'] = username;
    data['purchaseName'] = purchaseName;
    data['level'] = level;
    data['name'] = name;
    data['amount'] = amount;
    data['rate'] = rate;
    data['type'] = type;
    data['status'] = status;
    data['commissionAmount'] = commissionAmount;
    data['createdDate'] = createdDate;
    data['agency'] = agency;
    data['groupName'] = groupName;
    data['approvedDate'] = approvedDate;
    return data;
  }
}
