class BlogResponse {
  int? id;
  String? blogger;
  String? title;
  String? detail;
  String? photo;
  int? doctorId;
  String? status;
  String? createdAt;
  String? updatedAt;
  Doctor? doctor;

  BlogResponse(
      {this.id,
      this.blogger,
      this.title,
      this.detail,
      this.photo,
      this.doctorId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.doctor});

  BlogResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    blogger = json['doctorName'];
    title = json['title'];
    detail = json['detail'];
    photo = json['photo'];
    doctorId = json['doctorId'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctorName'] = this.blogger;
    data['title'] = this.title;
    data['detail'] = this.detail;
    data['photo'] = this.photo;
    data['doctorId'] = this.doctorId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    return data;
  }
}

class Doctor {
  int? id;
  int? hospitalId;
  String? doctorName;
  String? contactNo;
  int? specialistId;
  int? userId;
  String? photo;
  String? experience;
  String? registerNumber;
  String? status;
  String? createdAt;
  String? updatedAt;

  Doctor(
      {this.id,
      this.hospitalId,
      this.doctorName,
      this.contactNo,
      this.specialistId,
      this.userId,
      this.photo,
      this.experience,
      this.registerNumber,
      this.status,
      this.createdAt,
      this.updatedAt});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hospitalId = json['hospitalId'];
    doctorName = json['doctorName'];
    contactNo = json['contactNo'];
    specialistId = json['specialistId'];
    userId = json['userId'];
    photo = json['photo'];
    experience = json['experience'];
    registerNumber = json['registerNumber'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hospitalId'] = this.hospitalId;
    data['doctorName'] = this.doctorName;
    data['contactNo'] = this.contactNo;
    data['specialistId'] = this.specialistId;
    data['userId'] = this.userId;
    data['photo'] = this.photo;
    data['experience'] = this.experience;
    data['registerNumber'] = this.registerNumber;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
