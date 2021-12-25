
class ModelCount {
  String? pageIndex;
  int? totalCounter;

  ModelCount({
      this.pageIndex, 
      this.totalCounter});

  ModelCount.fromJson(dynamic json) {
    pageIndex = json["pageIndex"];
    totalCounter = json["totalCounter"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["pageIndex"] = pageIndex;
    map["totalCounter"] = totalCounter;
    return map;
  }

}