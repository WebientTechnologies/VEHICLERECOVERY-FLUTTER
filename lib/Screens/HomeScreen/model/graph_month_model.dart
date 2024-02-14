class GraphMonthModel {
  List<Data>? data;

  GraphMonthModel({this.data});

  GraphMonthModel.fromJson(Map<String, dynamic> json) {
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
  String? date;
  int? totalVehicle;

  Data({this.date, this.totalVehicle});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    totalVehicle = json['totalVehicle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['totalVehicle'] = this.totalVehicle;
    return data;
  }
}
