
class HomeDashBoardModel {
    int? holdCount;
    int? repoCount;
    int? releaseCount;
    int? searchCount;

    HomeDashBoardModel({this.holdCount, this.repoCount, this.releaseCount, this.searchCount});

    HomeDashBoardModel.fromJson(Map<String, dynamic> json) {
        holdCount = json["holdCount"];
        repoCount = json["repoCount"];
        releaseCount = json["releaseCount"];
        searchCount = json["searchCount"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["holdCount"] = holdCount;
        _data["repoCount"] = repoCount;
        _data["releaseCount"] = releaseCount;
        _data["searchCount"] = searchCount;
        return _data;
    }
}