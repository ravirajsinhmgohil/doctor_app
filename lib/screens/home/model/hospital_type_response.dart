class HospitalTypeResponse {
  bool? isAll;
  int? id;
  String? typeName;
  String? status;
  String? createdAt;
  String? updatedAt;

  HospitalTypeResponse({
    this.id,
    this.typeName,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  HospitalTypeResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeName = json['typeName'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['typeName'] = typeName;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
