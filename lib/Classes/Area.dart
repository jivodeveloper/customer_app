class Area {

  var getId;
  var flag;
  var result;

  Area({this.getId,this.flag,this.result});

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      getId: json['GetId'],
      flag: json['flag'],
      result: json['Result'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GetId'] = this.getId;
    data['flag'] = this.flag;
    data['Result'] = this.result;
    return data;
  }

}