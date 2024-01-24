class VehicleModel {
  String? loadStatus;
  String? id;
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
  String? lastDigit;
  String? month;
  String? status;
  String? fileName;
  String? createdAt;
  String? updatedAt;
  int? v;

  VehicleModel(this.id,
      {this.loadStatus,
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
      this.lastDigit,
      this.month,
      this.status,
      this.fileName,
      this.createdAt,
      this.updatedAt,
      this.v});

  factory VehicleModel.fromSqfliteDatabase(Map<String, dynamic> json) =>
      VehicleModel(
        json["id"],
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
        lastDigit: json["lastDigit"],
        month: json["month"],
        status: json["status"],
        fileName: json["fileName"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["v"],
      );
}
