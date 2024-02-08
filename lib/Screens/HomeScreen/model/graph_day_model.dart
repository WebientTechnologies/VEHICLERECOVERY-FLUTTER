class GraphDayModel {
  List<Data>? data;

  GraphDayModel({this.data});

  GraphDayModel.fromJson(Map<String, dynamic> json) {
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
  String? time;
  int? totalHoldVehicle;

  Data({this.time, this.totalHoldVehicle});

  Data.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    totalHoldVehicle = json['totalHoldVehicle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['totalHoldVehicle'] = this.totalHoldVehicle;
    return data;
  }
}
