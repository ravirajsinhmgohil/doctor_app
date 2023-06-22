class DoctorResponse {
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
  Specialist? specialist;

  DoctorResponse(
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
      this.updatedAt,
      this.specialist});

  DoctorResponse.fromJson(Map<String, dynamic> json) {
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
    specialist = json['specialist'] != null
        ? new Specialist.fromJson(json['specialist'])
        : null;
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
    if (this.specialist != null) {
      data['specialist'] = this.specialist!.toJson();
    }
    return data;
  }
}

class Specialist {
  int? id;
  String? specialistName;
  String? status;
  String? createdAt;
  String? updatedAt;

  Specialist(
      {this.id,
      this.specialistName,
      this.status,
      this.createdAt,
      this.updatedAt});

  Specialist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    specialistName = json['specialistName'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['specialistName'] = this.specialistName;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
