class ImageResponse {
  int? id;
  int? hospitalId;
  String? title;
  String? photo;
  String? status;
  String? createdAt;
  String? updatedAt;

  ImageResponse(
      {this.id,
      this.hospitalId,
      this.title,
      this.photo,
      this.status,
      this.createdAt,
      this.updatedAt});

  ImageResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hospitalId = json['hospitalId'];
    title = json['title'];
    photo = json['photo'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hospitalId'] = hospitalId;
    data['title'] = title;
    data['photo'] = photo;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
