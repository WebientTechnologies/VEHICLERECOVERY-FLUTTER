class VehicleDataModel {
  List<Data>? data;
  int? totalRecords;
  int? totalPages;
  int? currentPage;
  int? nextPage;

  VehicleDataModel(
      {this.data,
      this.totalRecords,
      this.totalPages,
      this.currentPage,
      this.nextPage});

  VehicleDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    totalRecords = json['totalRecords'];
    totalPages = json['totalPages'];
    currentPage = int.parse(json['currentPage']);
    nextPage = int.parse(json['nextPage']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['totalRecords'] = this.totalRecords;
    data['totalPages'] = this.totalPages;
    data['currentPage'] = this.currentPage;
    data['nextPage'] = this.nextPage;
    return data;
  }
}

class Data {
  String? sId;
  String? bankName;
  String? branch;
  String? agreementNo;
  String? customerName;
  String? regNo;
  String? chasisNo;
  String? engineNo;
  String? maker;
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
  String? createdAt;
  String? updatedAt;

  Data(
      {this.sId,
      this.bankName,
      this.branch,
      this.agreementNo,
      this.customerName,
      this.regNo,
      this.chasisNo,
      this.engineNo,
      this.maker,
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

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    bankName = json['bankName'];
    branch = json['branch'];
    agreementNo =
        json['agreementNo'] != null ? json['agreementNo'].toString() : '';
    customerName = json['customerName'];
    regNo = json['regNo'];
    chasisNo = json['chasisNo'];
    engineNo = json['engineNo'];
    maker = json['maker'];
    callCenterNo1 = json['callCenterNo1'];
    callCenterNo1Name = json['callCenterNo1Name'];
    callCenterNo2 = json['callCenterNo2'];
    callCenterNo2Name = json['callCenterNo2Name'];
    lastDigit = json['lastDigit'];
    month = json['month'];
    status = json['status'];
    loadStatus = json['loadStatus'];
    fileName = json['fileName'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['bankName'] = this.bankName;
    data['branch'] = this.branch;
    data['agreementNo'] = this.agreementNo;
    data['customerName'] = this.customerName;
    data['regNo'] = this.regNo;
    data['chasisNo'] = this.chasisNo;
    data['engineNo'] = this.engineNo;
    data['maker'] = this.maker;
    data['callCenterNo1'] = this.callCenterNo1;
    data['callCenterNo1Name'] = this.callCenterNo1Name;
    data['callCenterNo2'] = this.callCenterNo2;
    data['callCenterNo2Name'] = this.callCenterNo2Name;
    data['lastDigit'] = this.lastDigit;
    data['month'] = this.month;
    data['status'] = this.status;
    data['loadStatus'] = this.loadStatus;
    data['fileName'] = this.fileName;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
