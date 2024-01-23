class GetStateByZoneModel {
  List<States>? states;

  GetStateByZoneModel({this.states});

  GetStateByZoneModel.fromJson(Map<String, dynamic> json) {
    states = json["states"] == null
        ? null
        : (json["states"] as List).map((e) => States.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (states != null) {
      _data["states"] = states?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class States {
  String? id;
  String? name;
  ZoneId? zoneId;
  String? createdAt;
  String? updatedAt;
  int? v;

  States(
      {this.id,
      this.name,
      this.zoneId,
      this.createdAt,
      this.updatedAt,
      this.v});

  States.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
    zoneId = json["zoneId"] == null ? null : ZoneId.fromJson(json["zoneId"]);
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["name"] = name;
    if (zoneId != null) {
      _data["zoneId"] = zoneId?.toJson();
    }
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}

class ZoneId {
  String? id;
  String? name;

  ZoneId({this.id, this.name});

  ZoneId.fromJson(Map<String, dynamic> json) {
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
