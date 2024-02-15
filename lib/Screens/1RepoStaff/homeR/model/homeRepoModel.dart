class HomeDashboardRepoModel {
  int? holdCount;
  int? repoCount;
  int? releaseCount;
  int? totalOnlineData;

  HomeDashboardRepoModel({this.holdCount, this.repoCount, this.releaseCount});

  HomeDashboardRepoModel.fromJson(Map<String, dynamic> json) {
    holdCount = json["holdCount"];
    repoCount = json["repoCount"];
    releaseCount = json["releaseCount"];
    totalOnlineData = json["totalOnlineData"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["holdCount"] = holdCount;
    _data["repoCount"] = repoCount;
    _data["releaseCount"] = releaseCount;
    _data["totalOnlineData"] = totalOnlineData;
    return _data;
  }
}
