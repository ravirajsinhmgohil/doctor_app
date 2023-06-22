class SocialLinkResponse {
  int? id;
  String? title;
  String? link;
  int? hospitalId;
  String? status;
  String? createdAt;
  String? updatedAt;
  Hospital? hospital;

  SocialLinkResponse(
      {this.id,
      this.title,
      this.link,
      this.hospitalId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.hospital});

  SocialLinkResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    link = json['link'];
    hospitalId = json['hospitalId'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    hospital = json['hospital'] != null
        ? new Hospital.fromJson(json['hospital'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['link'] = this.link;
    data['hospitalId'] = this.hospitalId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.hospital != null) {
      data['hospital'] = this.hospital!.toJson();
    }
    return data;
  }
}

class Hospital {
  int? id;
  String? hospitalName;
  String? address;
  int? cityId;
  String? contactNo;
  int? hospitalTypeId;
  int? userId;
  String? siteUrl;
  String? category;
  String? hospitalLogo;
  String? hospitalTime;
  String? services;
  String? status;
  String? createdAt;
  String? updatedAt;

  Hospital(
      {this.id,
      this.hospitalName,
      this.address,
      this.cityId,
      this.contactNo,
      this.hospitalTypeId,
      this.userId,
      this.siteUrl,
      this.category,
      this.hospitalLogo,
      this.hospitalTime,
      this.services,
      this.status,
      this.createdAt,
      this.updatedAt});

  Hospital.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hospitalName = json['hospitalName'];
    address = json['address'];
    cityId = json['cityId'];
    contactNo = json['contactNo'];
    hospitalTypeId = json['hospitalTypeId'];
    userId = json['userId'];
    siteUrl = json['siteUrl'];
    category = json['category'];
    hospitalLogo = json['hospitalLogo'];
    hospitalTime = json['hospitalTime'];
    services = json['services'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hospitalName'] = this.hospitalName;
    data['address'] = this.address;
    data['cityId'] = this.cityId;
    data['contactNo'] = this.contactNo;
    data['hospitalTypeId'] = this.hospitalTypeId;
    data['userId'] = this.userId;
    data['siteUrl'] = this.siteUrl;
    data['category'] = this.category;
    data['hospitalLogo'] = this.hospitalLogo;
    data['hospitalTime'] = this.hospitalTime;
    data['services'] = this.services;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
