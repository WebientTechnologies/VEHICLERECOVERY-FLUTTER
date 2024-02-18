class SeezerModel {
  List<Agents>? agents;

  SeezerModel({this.agents});

  SeezerModel.fromJson(Map<String, dynamic> json) {
    if (json['agents'] != null) {
      agents = <Agents>[];
      json['agents'].forEach((v) {
        agents!.add(new Agents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.agents != null) {
      data['agents'] = this.agents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Agents {
  String? sId;
  String? agentId;
  ZoneId? zoneId;
  ZoneId? stateId;
  ZoneId? cityId;
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
  ZoneId? createdBy;
  String? createdByType;

  Agents(
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
      this.deviceId,
      this.createdBy,
      this.createdByType});

  Agents.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    agentId = json['agentId'];
    zoneId =
        json['zoneId'] != null ? new ZoneId.fromJson(json['zoneId']) : null;
    stateId =
        json['stateId'] != null ? new ZoneId.fromJson(json['stateId']) : null;
    cityId =
        json['cityId'] != null ? new ZoneId.fromJson(json['cityId']) : null;
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
    createdBy = json['createdBy'] != null
        ? new ZoneId.fromJson(json['createdBy'])
        : null;
    createdByType = json['createdByType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['agentId'] = this.agentId;
    if (this.zoneId != null) {
      data['zoneId'] = this.zoneId!.toJson();
    }
    if (this.stateId != null) {
      data['stateId'] = this.stateId!.toJson();
    }
    if (this.cityId != null) {
      data['cityId'] = this.cityId!.toJson();
    }
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
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy!.toJson();
    }
    data['createdByType'] = this.createdByType;
    return data;
  }
}

class ZoneId {
  String? sId;
  String? name;

  ZoneId({this.sId, this.name});

  ZoneId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}
