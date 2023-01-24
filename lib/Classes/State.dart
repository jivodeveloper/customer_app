class State {

  var id;
  var state;

  State({this.id,this.state});

  factory State.fromJson(Map<String, dynamic> json) {
    return State(
      id: json['Id'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['state'] = this.state;
    return data;
  }

}