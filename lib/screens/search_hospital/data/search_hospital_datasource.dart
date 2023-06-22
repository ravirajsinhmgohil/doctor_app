import 'package:doctor_app/utils/api_helper.dart';
import 'package:doctor_app/utils/http_helper.dart';

class SearchHospitalDatasource {
  Future<dynamic> getSearchedHospital(
      {required String hospitalId, required String searchedText}) async {
    return await HttpHelper.get(
        uri: '${Api.hospitalSearch}/$hospitalId/$searchedText');
  }
}
