class GetZoneModel {
  List<Zones>? zones;

  GetZoneModel({this.zones});

  GetZoneModel.fromJson(Map<String, dynamic> json) {
    zones = json["zones"] == null
        ? null
        : (json["zones"] as List).map((e) => Zones.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (zones != null) {
      _data["zones"] = zones?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Zones {
  String? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? v;

  Zones({this.id, this.name, this.createdAt, this.updatedAt, this.v});

  Zones.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["name"] = name;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["__v"] = v;
    return _data;
  }
}
