class SearchDataReport {
  List<VehiclesList>? vehiclesList;
  int? currentPage;
  int? totalPages;

  SearchDataReport({this.vehiclesList, this.currentPage, this.totalPages});

  SearchDataReport.fromJson(Map<String, dynamic> json) {
    vehiclesList = json["vehiclesList"] == null
        ? null
        : (json["vehiclesList"] as List)
            .map((e) => VehiclesList.fromJson(e))
            .toList();
    currentPage = json["currentPage"];
    totalPages = json["totalPages"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (vehiclesList != null) {
      _data["vehiclesList"] = vehiclesList?.map((e) => e.toJson()).toList();
    }
    _data["currentPage"] = currentPage;
    _data["totalPages"] = totalPages;
    return _data;
  }
}

class VehiclesList {
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
  String? loadStatus;
  String? fileName;
  String? createdAt;
  String? updatedAt;
  int? v;
  SeezerId? seezerId;

  VehiclesList(
      {this.id,
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
      this.loadStatus,
      this.fileName,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.seezerId});

  VehiclesList.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    bankName = json["bankName"];
    branch = json["branch"];
    agreementNo = json["agreementNo"];
    customerName = json["customerName"];
    regNo = json["regNo"];
    chasisNo = json["chasisNo"];
    engineNo = json["engineNo"];
    callCenterNo1 = json["callCenterNo1"];
    callCenterNo1Name = json["callCenterNo1Name"];
    callCenterNo2 = json["callCenterNo2"];
    callCenterNo2Name = json["callCenterNo2Name"];
    lastDigit = json["lastDigit"];
    month = json["month"];
    status = json["status"];
    loadStatus = json["loadStatus"];
    fileName = json["fileName"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = json["__v"];
    seezerId =
        json["seezerId"] == null ? null : SeezerId.fromJson(json["seezerId"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["bankName"] = bankName;
    _data["branch"] = branch;
    _data["agreementNo"] = agreementNo;
    _data["customerName"] = customerName;
    _data["regNo"] = regNo;
    _data["chasisNo"] = chasisNo;
    _data["engineNo"] = engineNo;
    _data["callCenterNo1"] = callCenterNo1;
    _data["callCenterNo1Name"] = callCenterNo1Name;
    _data["callCenterNo2"] = callCenterNo2;
    _data["callCenterNo2Name"] = callCenterNo2Name;
    _data["lastDigit"] = lastDigit;
    _data["month"] = month;
    _data["status"] = status;
    _data["loadStatus"] = loadStatus;
    _data["fileName"] = fileName;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["__v"] = v;
    if (seezerId != null) {
      _data["seezerId"] = seezerId?.toJson();
    }
    return _data;
  }
}

class SeezerId {
  String? id;
  String? name;

  SeezerId({this.id, this.name});

  SeezerId.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["name"] = name;
    return _data;
  }
}
