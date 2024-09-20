class VehicleModel {
  String? id;
  String? dataId;
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

  VehicleModel(this.id,
      {this.dataId,
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

  factory VehicleModel.fromSqfliteDatabase(Map<String, dynamic> json) =>
      VehicleModel(
        json["id"].toString(),
        dataId: json["dataId"],
        bankName: json['bankName'],
        branch: json['branch'],
        regNo: json['regNo'],
        loanNo: json['loanNo'],
        customerName: json['customerName'],
        model: json['model'],
        maker: json['maker'],
        chasisNo: json['chasisNo'],
        engineNo: json['engineNo'],
        emi: json['emi'],
        bucket: json['bucket'],
        pos: json['pos'],
        tos: json['tos'],
        allocation: json['allocation'],
        callCenterNo1: json['callCenterNo1'],
        callCenterNo1Name: json['callCenterNo1Name'],
        callCenterNo1Email: json['callCenterNo1Email'],
        callCenterNo2: json['callCenterNo2'],
        callCenterNo2Name: json['callCenterNo2Name'],
        callCenterNo2Email: json['callCenterNo2Email'],
        callCenterNo3: json['callCenterNo3'],
        callCenterNo3Name: json['callCenterNo3Name'],
        callCenterNo3Email: json['callCenterNo3Email'],
        address: json['address'],
        sec17: json['sec17'],
        agreementNo: json['agreementNo'],
        dlCode: json['dlCode'],
        color: json['color'],
        lastDigit: json['lastDigit'],
        month: json['month'],
        status: json['status'],
        confirmDate: json['confirmDate'],
        confirmTime: json['confirmTime'],
        loadStatus: json['loadStatus'],
        loadItem: json['loadItem'],
        tbrFlag: json['tbrFlag'],
        executiveName: json['executiveName'],
        sec9: json['sec9'],
        seasoning: json['seasoning'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        vehicleType: json['vehicleType'],
        seezerId: json['seezerId'],
        confirmBy: json['confirmBy'],
        holdAt: json['holdAt'],
        releaseAt: json['releaseAt'],
        searchedAt: json['searchedAt'],
        repoAt: json['repoAt'],
        iV: json['__v'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
      );
}
