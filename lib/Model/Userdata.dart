class Userdata {

    var getId;
    var flag;
    var result;

    Userdata({this.getId,this.flag,this.result});

    factory Userdata.fromJson(Map<String, dynamic> json) {
        return Userdata(
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