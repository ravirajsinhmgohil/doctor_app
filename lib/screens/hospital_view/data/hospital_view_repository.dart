import 'package:doctor_app/screens/hospital_view/model/lead_request.dart';

import 'hospital_view_datasource.dart';

class HospitalViewRepository {
  final HospitalViewDatasource datasource;

  HospitalViewRepository({required this.datasource});
  Future<dynamic> getHospitalProfile({required String hospitalId}) async {
    return datasource.getHospitalProfile(hospitalID: hospitalId);
  }

  Future<dynamic> getHospitalServices({required String hospitalId}) async {
    return datasource.getHospitalServices(hospitalID: hospitalId);
  }

  Future<dynamic> getGallary({required String hospitalId}) async {
    return datasource.getGallary(hospitalId: hospitalId);
  }

  Future<dynamic> getDoctors({required String hospitalId}) async {
    return datasource.getDoctors(hospitalId: hospitalId);
  }

  Future<dynamic> getFacilities({required String hospitalId}) async {
    return datasource.getFacilities(hospitalId: hospitalId);
  }

  Future<dynamic> getSocialLinks({required String hospitalId}) async {
    return datasource.getSocialLinks(hospitalId: hospitalId);
  }

  Future<dynamic> addLead({required LeadRequest leadRequest}) async {
    return datasource.addLead(leadRequest: leadRequest);
  }
}
