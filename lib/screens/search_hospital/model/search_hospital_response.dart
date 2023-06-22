class SearchHospitalResponse {
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
  String? status;
  String? createdAt;
  String? updatedAt;
  String? city;
  List<String>? doctor;

  SearchHospitalResponse(
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
      this.status,
      this.createdAt,
      this.updatedAt,
      this.city,
      this.doctor});

  SearchHospitalResponse.fromJson(Map<String, dynamic> json) {
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
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    city = json['city'];
    doctor = json['doctor'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hospitalName'] = hospitalName;
    data['address'] = address;
    data['cityId'] = cityId;
    data['contactNo'] = contactNo;
    data['hospitalTypeId'] = hospitalTypeId;
    data['userId'] = userId;
    data['siteUrl'] = siteUrl;
    data['category'] = category;
    data['hospitalLogo'] = hospitalLogo;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['city'] = city;
    data['doctor'] = doctor;
    return data;
  }
}
