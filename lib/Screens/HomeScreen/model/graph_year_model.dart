class GraphYearModel {
  List<Data>? data;

  GraphYearModel({this.data});

  GraphYearModel.fromJson(Map<String, dynamic> json) {
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
  int? month;
  int? totalVehicle;

  Data({this.month, this.totalVehicle});

  Data.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    totalVehicle = json['totalVehicle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['totalVehicle'] = this.totalVehicle;
    return data;
  }
}
