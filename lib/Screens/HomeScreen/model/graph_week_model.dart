class GraphWeekModel {
  List<Data>? data;

  GraphWeekModel({this.data});

  GraphWeekModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? count;
  String? day;
  int? totalVehicle;

  Data({this.count, this.day, this.totalVehicle});

  Data.fromJson(Map<String, dynamic> json) {
    day = json['range'];
    totalVehicle = json['totalVehicle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['range'] = this.day;
    data['totalVehicle'] = this.totalVehicle;
    return data;
  }
}
