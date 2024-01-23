class GetCityByStateModel {
  List<Cities>? cities;

  GetCityByStateModel({this.cities});

  GetCityByStateModel.fromJson(Map<String, dynamic> json) {
    cities = json["cities"] == null
        ? null
        : (json["cities"] as List).map((e) => Cities.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (cities != null) {
      _data["cities"] = cities?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Cities {
  String? id;
  String? name;
  StateId? stateId;
  String? createdAt;
  String? updatedAt;
  int? v;

  Cities(
      {this.id,
      this.name,
      this.stateId,
      this.createdAt,
      this.updatedAt,
      this.v});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
    stateId =
        json["stateId"] == null ? null : StateId.fromJson(json["stateId"]);
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["name"] = name;
    if (stateId != null) {
      _data["stateId"] = stateId?.toJson();
    }
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}

class StateId {
  String? id;
  String? name;

  StateId({this.id, this.name});

  StateId.fromJson(Map<String, dynamic> json) {
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
