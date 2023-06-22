import 'package:doctor_app/utils/api_helper.dart';
import 'package:doctor_app/utils/http_helper.dart';

class HomeDatasource {
  Future<dynamic> getCityList() async {
    return await HttpHelper.get(uri: Api.cityList);
  }

  Future<dynamic> getSliderImages() async {
    return await HttpHelper.get(uri: '${Api.slider}/');
  }

  Future<dynamic> getHospitalType() async {
    return await HttpHelper.get(uri: Api.hospitalType);
  }

  Future<dynamic> getHospitalList() async {
    return await HttpHelper.get(uri: Api.hospital);
  }

  Future<dynamic> getHospitalListById({required String hospitalTypeId}) async {
    return await HttpHelper.get(
        uri: '${Api.hospitalByhospitalType}/$hospitalTypeId');
  }
}
