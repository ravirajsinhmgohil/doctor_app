import 'package:doctor_app/screens/hospital_view/model/lead_request.dart';
import 'package:doctor_app/utils/api_helper.dart';
import 'package:doctor_app/utils/http_helper.dart';

class HospitalViewDatasource {
  Future<void> getHospitalProfile({required String hospitalID}) async {
    return await HttpHelper.get(uri: '${Api.hospitalProfile}/$hospitalID');
  }

  Future<void> getHospitalServices({required String hospitalID}) async {
    return await HttpHelper.get(uri: '${Api.hospitalServices}/$hospitalID');
  }

  Future<void> getGallary({required String hospitalId}) async {
    return await HttpHelper.get(uri: '${Api.hospitalGallary}/$hospitalId');
  }

  Future<void> getDoctors({required String hospitalId}) async {
    return await HttpHelper.get(uri: '${Api.doctor}/$hospitalId');
  }

  Future<void> getFacilities({required String hospitalId}) async {
    return await HttpHelper.get(uri: '${Api.facility}/$hospitalId');
  }

  Future<void> getSocialLinks({required String hospitalId}) async {
    return await HttpHelper.get(uri: '${Api.hospitalSocialLink}/${hospitalId}');
  }

  Future<void> addLead({required LeadRequest leadRequest}) async {
    return await HttpHelper.post(
        uri: '${Api.addLead}', body: leadRequest.toJson());
  }
}
