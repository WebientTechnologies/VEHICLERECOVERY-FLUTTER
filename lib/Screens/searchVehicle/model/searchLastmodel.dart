class GetSearchByLastDigitModel {
  List<Data>? data;

  GetSearchByLastDigitModel({this.data});

  GetSearchByLastDigitModel.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Data {
  String? sId;
  String? bankName;
  String? branch;
  String? regNo;
  String? loanNo;
  String? customerName;
  String? model;
  String? maker;
  String? chasisNo;
  String? engineNo;
  String? emi;
  String? bucket;
  String? pos;
  String? tos;
  String? allocation;
  String? callCenterNo1;
  String? callCenterNo1Name;
  String? callCenterNo1Email;
  String? callCenterNo2;
  String? callCenterNo2Name;
  String? callCenterNo2Email;
  String? callCenterNo3;
  String? callCenterNo3Name;
  String? callCenterNo3Email;
  String? address;
  String? sec17;
  String? agreementNo;
  String? dlCode;
  String? color;
  String? lastDigit;
  String? month;
  String? status;
  String? confirmDate;
  String? confirmTime;
  String? loadStatus;
  String? loadItem;
  String? tbrFlag;
  String? executiveName;
  String? sec9;
  String? seasoning;
  double? latitude;
  double? longitude;
  String? vehicleType;
  String? seezerId;
  String? confirmBy;
  String? holdAt;
  String? releaseAt;
  String? searchedAt;
  String? repoAt;
  int? iV;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.sId,
      this.bankName,
      this.branch,
      this.regNo,
      this.loanNo,
      this.customerName,
      this.model,
      this.maker,
      this.chasisNo,
      this.engineNo,
      this.emi,
      this.bucket,
      this.pos,
      this.tos,
      this.allocation,
      this.callCenterNo1,
      this.callCenterNo1Name,
      this.callCenterNo1Email,
      this.callCenterNo2,
      this.callCenterNo2Name,
      this.callCenterNo2Email,
      this.callCenterNo3,
      this.callCenterNo3Name,
      this.callCenterNo3Email,
      this.address,
      this.sec17,
      this.agreementNo,
      this.dlCode,
      this.color,
      this.lastDigit,
      this.month,
      this.status,
      this.confirmDate,
      this.confirmTime,
      this.loadStatus,
      this.loadItem,
      this.tbrFlag,
      this.executiveName,
      this.sec9,
      this.seasoning,
      this.latitude,
      this.longitude,
      this.vehicleType,
      this.seezerId,
      this.confirmBy,
      this.holdAt,
      this.releaseAt,
      this.searchedAt,
      this.repoAt,
      this.iV,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<dynamic, dynamic> json) {
    sId = json['_id'];
    bankName = json['bankName'];
    branch = json['branch'];
    regNo = json['regNo'];
    loanNo = json['loanNo'];
    customerName = json['customerName'];
    model = json['model'];
    maker = json['maker'];
    chasisNo = json['chasisNo'];
    engineNo = json['engineNo'];
    emi = json['emi'];
    bucket = json['bucket'];
    pos = json['pos'];
    tos = json['tos'];
    allocation = json['allocation'];
    callCenterNo1 = json['callCenterNo1'];
    callCenterNo1Name = json['callCenterNo1Name'];
    callCenterNo1Email = json['callCenterNo1Email'];
    callCenterNo2 = json['callCenterNo2'];
    callCenterNo2Name = json['callCenterNo2Name'];
    callCenterNo2Email = json['callCenterNo2Email'];
    callCenterNo3 = json['callCenterNo3'];
    callCenterNo3Name = json['callCenterNo3Name'];
    callCenterNo3Email = json['callCenterNo3Email'];
    address = json['address'];
    sec17 = json['sec17'];
    agreementNo = json['agreementNo'];
    dlCode = json['dlCode'];
    color = json['color'];
    lastDigit = json['lastDigit'];
    month = json['month'];
    status = json['status'];
    confirmDate = json['confirmDate'];
    confirmTime = json['confirmTime'];
    loadStatus = json['loadStatus'];
    loadItem = json['loadItem'];
    tbrFlag = json['tbrFlag'];
    executiveName = json['executiveName'];
    sec9 = json['sec9'];
    seasoning = json['seasoning'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    vehicleType = json['vehicleType'];
    seezerId = json['seezerId'];
    confirmBy = json['confirmBy'];
    holdAt = json['holdAt'];
    releaseAt = json['releaseAt'];
    searchedAt = json['searchedAt'];
    repoAt = json['repoAt'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['bankName'] = this.bankName;
    data['branch'] = this.branch;
    data['regNo'] = this.regNo;
    data['loanNo'] = this.loanNo;
    data['customerName'] = this.customerName;
    data['model'] = this.model;
    data['maker'] = this.maker;
    data['chasisNo'] = this.chasisNo;
    data['engineNo'] = this.engineNo;
    data['emi'] = this.emi;
    data['bucket'] = this.bucket;
    data['pos'] = this.pos;
    data['tos'] = this.tos;
    data['allocation'] = this.allocation;
    data['callCenterNo1'] = this.callCenterNo1;
    data['callCenterNo1Name'] = this.callCenterNo1Name;
    data['callCenterNo1Email'] = this.callCenterNo1Email;
    data['callCenterNo2'] = this.callCenterNo2;
    data['callCenterNo2Name'] = this.callCenterNo2Name;
    data['callCenterNo2Email'] = this.callCenterNo2Email;
    data['callCenterNo3'] = this.callCenterNo3;
    data['callCenterNo3Name'] = this.callCenterNo3Name;
    data['callCenterNo3Email'] = this.callCenterNo3Email;
    data['address'] = this.address;
    data['sec17'] = this.sec17;
    data['agreementNo'] = this.agreementNo;
    data['dlCode'] = this.dlCode;
    data['color'] = this.color;
    data['lastDigit'] = this.lastDigit;
    data['month'] = this.month;
    data['status'] = this.status;
    data['confirmDate'] = this.confirmDate;
    data['confirmTime'] = this.confirmTime;
    data['loadStatus'] = this.loadStatus;
    data['loadItem'] = this.loadItem;
    data['tbrFlag'] = this.tbrFlag;
    data['executiveName'] = this.executiveName;
    data['sec9'] = this.sec9;
    data['seasoning'] = this.seasoning;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['vehicleType'] = this.vehicleType;
    data['seezerId'] = this.seezerId;
    data['confirmBy'] = this.confirmBy;
    data['holdAt'] = this.holdAt;
    data['releaseAt'] = this.releaseAt;
    data['searchedAt'] = this.searchedAt;
    data['repoAt'] = this.repoAt;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
