class HomeDashboardRepoModel {
  int? holdCount;
  int? repoCount;
  int? releaseCount;

  HomeDashboardRepoModel({this.holdCount, this.repoCount, this.releaseCount});

  HomeDashboardRepoModel.fromJson(Map<String, dynamic> json) {
    holdCount = json["holdCount"];
    repoCount = json["repoCount"];
    releaseCount = json["releaseCount"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["holdCount"] = holdCount;
    _data["repoCount"] = repoCount;
    _data["releaseCount"] = releaseCount;
    return _data;
  }
}
