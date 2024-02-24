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
    _data["holdCount"] = holdCount ?? 0.0;
    _data["repoCount"] = repoCount ?? 0.0;
    _data["releaseCount"] = releaseCount ?? 0.0;
    _data["totalOnlineData"] = totalOnlineData ?? 0.0;
    return _data;
  }
}
