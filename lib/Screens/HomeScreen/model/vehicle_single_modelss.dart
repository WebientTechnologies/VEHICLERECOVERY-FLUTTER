class VehicleSingleModelss {
  Id? iId;
  String? bankName;
  String? branch;
  String? agreementNo;
  String? customerName;
  String? regNo;
  String? chasisNo;
  String? engineNo;
  String? maker;
  String? dlCode;
  String? bucket;
  String? emi;
  String? color;
  String? callCenterNo1;
  String? callCenterNo1Name;
  String? callCenterNo2;
  String? callCenterNo2Name;
  String? lastDigit;
  String? month;
  String? status;
  String? loadStatus;
  String? fileName;
  int? iV;
  CreatedAt? createdAt;
  CreatedAt? updatedAt;

  VehicleSingleModelss(
      {this.iId,
      this.bankName,
      this.branch,
      this.agreementNo,
      this.customerName,
      this.regNo,
      this.chasisNo,
      this.engineNo,
      this.maker,
      this.dlCode,
      this.bucket,
      this.emi,
      this.color,
      this.callCenterNo1,
      this.callCenterNo1Name,
      this.callCenterNo2,
      this.callCenterNo2Name,
      this.lastDigit,
      this.month,
      this.status,
      this.loadStatus,
      this.fileName,
      this.iV,
      this.createdAt,
      this.updatedAt});

  VehicleSingleModelss.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? new Id.fromJson(json['_id']) : null;
    bankName = json['bankName'] ?? '';
    branch = json['branch'] ?? '';
    agreementNo = json['agreementNo'] ?? '';
    customerName = json['customerName'] ?? '';
    regNo = json['regNo'] ?? '';
    chasisNo = json['chasisNo'] ?? '';
    engineNo = json['engineNo'] ?? '';
    maker = json['maker'] ?? '';
    dlCode = json['dlCode'] ?? '';
    bucket = json['bucket'] ?? '';
    emi = json['emi'] ?? '';
    color = json['color'] ?? '';
    callCenterNo1 = json['callCenterNo1'] ?? '';
    callCenterNo1Name = json['callCenterNo1Name'] ?? '';
    callCenterNo2 = json['callCenterNo2'] ?? '';
    callCenterNo2Name = json['callCenterNo2Name'] ?? '';
    lastDigit = json['lastDigit'] ?? '';
    month = json['month'] ?? '';
    status = json['status'] ?? '';
    loadStatus = json['loadStatus'] ?? '';
    fileName = json['fileName'] ?? '';
    iV = json['__v'];
    createdAt = json['createdAt'] != null
        ? new CreatedAt.fromJson(json['createdAt'])
        : null;
    updatedAt = json['updatedAt'] != null
        ? new CreatedAt.fromJson(json['updatedAt'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['_id'] = this.iId!.toJson();
    }
    data['bankName'] = this.bankName;
    data['branch'] = this.branch;
    data['agreementNo'] = this.agreementNo;
    data['customerName'] = this.customerName;
    data['chasisNo'] = this.chasisNo;
    data['engineNo'] = this.engineNo;
    data['maker'] = this.maker;
    data['dlCode'] = this.dlCode;
    data['bucket'] = this.bucket;
    data['emi'] = this.emi;
    data['color'] = this.color;
    data['callCenterNo1'] = this.callCenterNo1;
    data['lastDigit'] = this.lastDigit;
    data['month'] = this.month;
    data['status'] = this.status;
    data['loadStatus'] = this.loadStatus;
    data['fileName'] = this.fileName;
    data['__v'] = this.iV;
    if (this.createdAt != null) {
      data['createdAt'] = this.createdAt!.toJson();
    }
    if (this.updatedAt != null) {
      data['updatedAt'] = this.updatedAt!.toJson();
    }
    return data;
  }
}

class Id {
  String? oid;

  Id({this.oid});

  Id.fromJson(Map<String, dynamic> json) {
    oid = json['$oid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$oid'] = this.oid;
    return data;
  }
}

class CreatedAt {
  String? date;

  CreatedAt({this.date});

  CreatedAt.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$date'] = this.date;
    return data;
  }
}
