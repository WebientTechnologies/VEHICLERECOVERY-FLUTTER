class DashboardModel {
  List<Dashboard>? dashboard;

  DashboardModel({this.dashboard});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    if (json['dashboard'] != null) {
      dashboard = <Dashboard>[];
      json['dashboard'].forEach((v) {
        dashboard!.add(new Dashboard.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dashboard != null) {
      data['dashboard'] = this.dashboard!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dashboard {
  String? sId;
  int? onlineDataCount;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Dashboard(
      {this.sId,
      this.onlineDataCount,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Dashboard.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    onlineDataCount = json['onlineDataCount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['onlineDataCount'] = this.onlineDataCount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
