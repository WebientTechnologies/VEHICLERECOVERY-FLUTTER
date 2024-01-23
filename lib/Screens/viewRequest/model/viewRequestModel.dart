class ViewRequestDataModel {
  List<Requests>? requests;
  int? currentPage;
  int? totalPages;

  ViewRequestDataModel({this.requests, this.currentPage, this.totalPages});

  ViewRequestDataModel.fromJson(Map<String, dynamic> json) {
    requests = json["requests"] == null
        ? null
        : (json["requests"] as List).map((e) => Requests.fromJson(e)).toList();
    currentPage = json["currentPage"];
    totalPages = json["totalPages"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (requests != null) {
      _data["requests"] = requests?.map((e) => e.toJson()).toList();
    }
    _data["currentPage"] = currentPage;
    _data["totalPages"] = totalPages;
    return _data;
  }
}

class Requests {
  String? id;
  RecordId? recordId;
  CreatedBy? createdBy;
  String? createdByType;
  String? requestFor;
  String? bankName;
  String? branch;
  String? agreementNo;
  String? customerName;
  String? regNo;
  String? chasisNo;
  String? createdAt;
  String? updatedAt;
  int? v;

  Requests(
      {this.id,
      this.recordId,
      this.createdBy,
      this.createdByType,
      this.requestFor,
      this.bankName,
      this.branch,
      this.agreementNo,
      this.customerName,
      this.regNo,
      this.chasisNo,
      this.createdAt,
      this.updatedAt,
      this.v});

  Requests.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    recordId =
        json["recordId"] == null ? null : RecordId.fromJson(json["recordId"]);
    createdBy = json["createdBy"] == null
        ? null
        : CreatedBy.fromJson(json["createdBy"]);
    createdByType = json["createdByType"];
    requestFor = json["requestFor"];
    bankName = json["bankName"];
    branch = json["branch"];
    agreementNo = json["agreementNo"];
    customerName = json["customerName"];
    regNo = json["regNo"];
    chasisNo = json["chasisNo"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    if (recordId != null) {
      _data["recordId"] = recordId?.toJson();
    }
    if (createdBy != null) {
      _data["createdBy"] = createdBy?.toJson();
    }
    _data["createdByType"] = createdByType;
    _data["requestFor"] = requestFor;
    _data["bankName"] = bankName;
    _data["branch"] = branch;
    _data["agreementNo"] = agreementNo;
    _data["customerName"] = customerName;
    _data["regNo"] = regNo;
    _data["chasisNo"] = chasisNo;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}

class CreatedBy {
  String? id;
  String? name;

  CreatedBy({this.id, this.name});

  CreatedBy.fromJson(Map<String, dynamic> json) {
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

class RecordId {
  String? id;
  String? bankName;
  String? branch;
  String? agreementNo;
  String? customerName;
  String? regNo;
  String? chasisNo;
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
  String? seezerId;

  RecordId(
      {this.id,
      this.bankName,
      this.branch,
      this.agreementNo,
      this.customerName,
      this.regNo,
      this.chasisNo,
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

  RecordId.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    bankName = json["bankName"];
    branch = json["branch"];
    agreementNo = json["agreementNo"];
    customerName = json["customerName"];
    regNo = json["regNo"];
    chasisNo = json["chasisNo"];
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
    seezerId = json["seezerId"];
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
    _data["seezerId"] = seezerId;
    return _data;
  }
}
