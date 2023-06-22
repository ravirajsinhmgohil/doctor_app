import 'package:doctor_app/screens/search_hospital/data/search_hospital_datasource.dart';

class SearchedHospitalRepository {
  final SearchHospitalDatasource datasource;

  SearchedHospitalRepository({required this.datasource});
  Future<dynamic> searchedHospital(
      {required String hospitalId, required String searchedText}) async {
    return datasource.getSearchedHospital(
        hospitalId: hospitalId, searchedText: searchedText);
  }
}
