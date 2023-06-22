class UpdateNumberRequest {
  String? userId;
  String? contactNumber;

  UpdateNumberRequest({this.userId, this.contactNumber});

  UpdateNumberRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    contactNumber = json['contactNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['contactNumber'] = contactNumber;
    return data;
  }
}
