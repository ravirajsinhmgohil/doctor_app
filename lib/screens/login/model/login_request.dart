class LoginRequest {
  String? email;
  String? name;

  LoginRequest({this.email, this.name});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    return data;
  }
}
