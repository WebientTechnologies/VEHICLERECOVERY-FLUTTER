class HomeDashBoardModel {
  int? holdCount;
  int? repoCount;
  int? releaseCount;
  int? searchCount;
  int? totalOnlineData;
  String? lastId;

  HomeDashBoardModel({
    this.holdCount,
    this.repoCount,
    this.releaseCount,
    this.searchCount,
    this.totalOnlineData,
    this.lastId,
  });

  HomeDashBoardModel.fromJson(Map<String, dynamic> json) {
    holdCount = json["holdCount"];
    repoCount = json["repoCount"];
    releaseCount = json["releaseCount"];
    searchCount = json["searchCount"];
    totalOnlineData = json["totalOnlineData"];
    lastId = json["lastId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["holdCount"] = holdCount ?? 0.0;
    _data["repoCount"] = repoCount ?? 0.0;
    _data["releaseCount"] = releaseCount ?? 0.0;
    _data["searchCount"] = searchCount ?? 0.0;
    _data["totalOnlineData"] = totalOnlineData ?? 0.0;
    _data["lastId"] = lastId ?? '';
    return _data;
  }
}
