class VehicleSingleModel {
  Id? iId;
  String? lastDigit;
  String? month;
  String? status;
  String? loadStatus;
  String? fileName;
  int? iV;
  CreatedAt? createdAt;
  CreatedAt? updatedAt;

  VehicleSingleModel(
      {this.iId,
      this.lastDigit,
      this.month,
      this.status,
      this.loadStatus,
      this.fileName,
      this.iV,
      this.createdAt,
      this.updatedAt});

  VehicleSingleModel.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? new Id.fromJson(json['_id']) : null;
    lastDigit = json['lastDigit'];
    month = json['month'];
    status = json['status'];
    loadStatus = json['loadStatus'];
    fileName = json['fileName'];
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
