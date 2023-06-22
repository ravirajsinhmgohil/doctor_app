class SliderResponse {
  int? id;
  String? title;
  String? image;
  String? place;
  String? navigate;
  String? status;
  String? createdAt;
  String? updatedAt;

  SliderResponse(
      {this.id,
      this.title,
      this.image,
      this.place,
      this.navigate,
      this.status,
      this.createdAt,
      this.updatedAt});

  SliderResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    place = json['place'];
    navigate = json['navigate'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['place'] = place;
    data['navigate'] = navigate;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
