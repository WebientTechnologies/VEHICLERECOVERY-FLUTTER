class VehicleModel {
  String? id;
  String? dataId;
  String? loadStatus;
  String? bankName;
  String? branch;
  String? agreementNo;
  String? customerName;
  String? regNo;
  String? chasisNo;
  String? engineNo;
  String? callCenterNo1;
  String? callCenterNo1Name;
  String? callCenterNo2;
  String? callCenterNo2Name;
  String? callCenterNo3;
  String? callCenterNo3Name;
  String? lastDigit;
  String? month;
  String? status;
  String? fileName;
  String? createdAt;
  String? updatedAt;

  VehicleModel(
    this.id, {
    this.dataId,
    this.loadStatus,
    this.bankName,
    this.branch,
    this.agreementNo,
    this.customerName,
    this.regNo,
    this.chasisNo,
    this.engineNo,
    this.callCenterNo1,
    this.callCenterNo1Name,
    this.callCenterNo2,
    this.callCenterNo2Name,
    this.callCenterNo3,
    this.callCenterNo3Name,
    this.lastDigit,
    this.month,
    this.status,
    this.fileName,
    this.createdAt,
    this.updatedAt,
  });

  factory VehicleModel.fromSqfliteDatabase(Map<String, dynamic> json) =>
      VehicleModel(
        json["id"].toString(),
        dataId: json["dataId"],
        loadStatus: json["loadStatus"],
        bankName: json["bankName"],
        branch: json["branch"],
        agreementNo: json["agreementNo"],
        customerName: json["customerName"],
        regNo: json["regNo"],
        chasisNo: json["chasisNo"],
        engineNo: json["engineNo"],
        callCenterNo1: json["callCenterNo1"],
        callCenterNo1Name: json["callCenterNo1Name"],
        callCenterNo2: json["callCenterNo2"],
        callCenterNo2Name: json["callCenterNo2Name"],
        callCenterNo3: json["callCenterNo3"],
        callCenterNo3Name: json["callCenterNo3Name"],
        lastDigit: json["lastDigit"],
        month: json["month"],
        status: json["status"],
        fileName: json["fileName"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );
}
