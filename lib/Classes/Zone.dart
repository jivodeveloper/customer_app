class Zone {

  var getId;
  var flag;
  var result;

  Zone({this.getId,this.flag,this.result});

  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
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