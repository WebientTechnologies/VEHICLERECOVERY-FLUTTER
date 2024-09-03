class GetAllRepoAgentModel {
  List<Agents>? agents;

  GetAllRepoAgentModel({this.agents});

  GetAllRepoAgentModel.fromJson(Map<String, dynamic> json) {
    agents = json["agents"] == null
        ? null
        : (json["agents"] as List).map((e) => Agents.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (agents != null) {
      _data["agents"] = agents?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Agents {
  String? id;
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
  String? createdBy;
  String? createdByType;
  String? createdAt;
  String? updatedAt;

  Agents(
      {
      this.id,
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
      this.createdBy,
      this.createdByType,
      this.createdAt,
      this.updatedAt,
      });

  Agents.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    agentId = json["agentId"];
    zoneId = json["zoneId"];
    stateId =
        json["stateId"];
    cityId = json["cityId"];
    name = json["name"];
    mobile = json["mobile"];
    alternativeMobile = json["alternativeMobile"];
    email = json["email"];
    panCard = json["panCard"];
    aadharCard = json["aadharCard"];
    addressLine1 = json["addressLine1"];
    addressLine2 = json["addressLine2"];
    state = json["state"];
    city = json["city"];
    pincode = json["pincode"];
    username = json["username"];
    password = json["password"];
    status = json["status"];
    createdBy = json["createdBy"] == null
        ? null
        : '';
    createdByType = json["createdByType"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["agentId"] = agentId;
      _data["zoneId"] = zoneId;
    
      _data["stateId"] = stateId;
    
      _data["cityId"] = cityId;
    
    _data["name"] = name;
    _data["mobile"] = mobile;
    _data["alternativeMobile"] = alternativeMobile;
    _data["email"] = email;
    _data["panCard"] = panCard;
    _data["aadharCard"] = aadharCard;
    _data["addressLine1"] = addressLine1;
    _data["addressLine2"] = addressLine2;
    _data["state"] = state;
    _data["city"] = city;
    _data["pincode"] = pincode;
    _data["username"] = username;
    _data["password"] = password;
    _data["status"] = status;
      _data["createdBy"] = createdBy;
    
    _data["createdByType"] = createdByType;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
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

