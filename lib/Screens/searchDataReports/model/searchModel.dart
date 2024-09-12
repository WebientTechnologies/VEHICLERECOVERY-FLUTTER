class SearchData {
  List<Search>? search;

  SearchData({this.search});

  SearchData.fromJson(Map<String, dynamic> json) {
    if (json['search'] != null) {
      search = <Search>[];
      json['search'].forEach((v) {
        search!.add(new Search.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.search != null) {
      data['search'] = this.search!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Search {
  String? sId;
  VehicleId? vehicleId;
  SeezerId? seezerId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Search(
      {this.sId,
      this.vehicleId,
      this.seezerId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Search.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    vehicleId = json['vehicleId'] != null
        ? new VehicleId.fromJson(json['vehicleId'])
        : null;
    seezerId = json['seezerId'] != null
        ? new SeezerId.fromJson(json['seezerId'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.vehicleId != null) {
      data['vehicleId'] = this.vehicleId!.toJson();
    }
    if (this.seezerId != null) {
      data['seezerId'] = this.seezerId!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class VehicleId {
  String? sId;
  String? bankName;
  String? customerName;
  String? regNo;
  String? chasisNo;
  String? engineNo;
  String? maker;
  String? callCenterNo1;
  String? callCenterNo1Name;
  String? callCenterNo2;
  String? callCenterNo2Name;
  String? callCenterNo3;
  String? callCenterNo3Name;
  String? lastDigit;
  String? month;
  String? status;
  String? loadStatus;
  String? fileName;
  int? iV;
  String? createdAt;
  String? updatedAt;
  String? latitude;
  String? longitude;
  String? searchedAt;
  String? seezerId;

  VehicleId(
      {this.sId,
      this.bankName,
      this.customerName,
      this.regNo,
      this.chasisNo,
      this.engineNo,
      this.maker,
      this.callCenterNo1,
      this.callCenterNo1Name,
      this.callCenterNo2,
      this.callCenterNo2Name,
      this.callCenterNo3,
      this.callCenterNo3Name,
      this.lastDigit,
      this.month,
      this.status,
      this.loadStatus,
      this.fileName,
      this.iV,
      this.createdAt,
      this.updatedAt,
      this.latitude,
      this.longitude,
      this.searchedAt,
      this.seezerId});

  VehicleId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    bankName = json['bankName'];
    customerName = json['customerName'];
    regNo = json['regNo'];
    chasisNo = json['chasisNo'];
    engineNo = json['engineNo'];
    maker = json['maker'];
    callCenterNo1 = json['callCenterNo1'];
    callCenterNo1Name = json['callCenterNo1Name'];
    callCenterNo2 = json['callCenterNo2'];
    callCenterNo2Name = json['callCenterNo2Name'];
    callCenterNo3 = json['callCenterNo3'];
    callCenterNo3Name = json['callCenterNo3Name'];
    lastDigit = json['lastDigit'];
    month = json['month'];
    status = json['status'];
    loadStatus = json['loadStatus'];
    fileName = json['fileName'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    searchedAt = json['searchedAt'];
    seezerId = json['seezerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['bankName'] = this.bankName;
    data['customerName'] = this.customerName;
    data['regNo'] = this.regNo;
    data['chasisNo'] = this.chasisNo;
    data['engineNo'] = this.engineNo;
    data['maker'] = this.maker;
    data['callCenterNo1'] = this.callCenterNo1;
    data['callCenterNo1Name'] = this.callCenterNo1Name;
    data['callCenterNo2'] = this.callCenterNo2;
    data['callCenterNo2Name'] = this.callCenterNo2Name;
    data['callCenterNo3'] = this.callCenterNo3;
    data['callCenterNo3Name'] = this.callCenterNo3Name;

    data['lastDigit'] = this.lastDigit;
    data['month'] = this.month;
    data['status'] = this.status;
    data['loadStatus'] = this.loadStatus;
    data['fileName'] = this.fileName;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['searchedAt'] = this.searchedAt;
    data['seezerId'] = this.seezerId;
    return data;
  }
}

class SeezerId {
  String? sId;
  String? agentId;
  String? zoneId;
  String? stateId;
  String? cityId;
  String? name;
  String? mobile;
  String? alternativeMobile;
  String? email;
  String? panCard;
  String? aadharCard;
  String? addressLine1;
  String? addressLine2;
  String? state;
  String? city;
  int? pincode;
  String? username;
  String? password;
  String? status;
  int? tokenVersion;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? deviceId;

  SeezerId(
      {this.sId,
      this.agentId,
      this.zoneId,
      this.stateId,
      this.cityId,
      this.name,
      this.mobile,
      this.alternativeMobile,
      this.email,
      this.panCard,
      this.aadharCard,
      this.addressLine1,
      this.addressLine2,
      this.state,
      this.city,
      this.pincode,
      this.username,
      this.password,
      this.status,
      this.tokenVersion,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.deviceId});

  SeezerId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    agentId = json['agentId'];
    zoneId = json['zoneId'];
    stateId = json['stateId'];
    cityId = json['cityId'];
    name = json['name'];
    mobile = json['mobile'];
    alternativeMobile = json['alternativeMobile'];
    email = json['email'];
    panCard = json['panCard'];
    aadharCard = json['aadharCard'];
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
    username = json['username'];
    password = json['password'];
    status = json['status'];
    tokenVersion = json['tokenVersion'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    deviceId = json['deviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['agentId'] = this.agentId;
    data['zoneId'] = this.zoneId;
    data['stateId'] = this.stateId;
    data['cityId'] = this.cityId;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['alternativeMobile'] = this.alternativeMobile;
    data['email'] = this.email;
    data['panCard'] = this.panCard;
    data['aadharCard'] = this.aadharCard;
    data['addressLine1'] = this.addressLine1;
    data['addressLine2'] = this.addressLine2;
    data['state'] = this.state;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['username'] = this.username;
    data['password'] = this.password;
    data['status'] = this.status;
    data['tokenVersion'] = this.tokenVersion;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['deviceId'] = this.deviceId;
    return data;
  }
}
