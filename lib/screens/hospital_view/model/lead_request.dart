class LeadRequest {
  String? userId;
  String? hospitalId;
  String? type;

  LeadRequest({this.userId, this.hospitalId, this.type});

  LeadRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    hospitalId = json['hospitalId'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['hospitalId'] = this.hospitalId;
    data['type'] = this.type;
    return data;
  }
}
