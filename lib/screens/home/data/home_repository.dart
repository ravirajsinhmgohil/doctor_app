import 'package:doctor_app/screens/home/data/home_datasource.dart';

class HomeRepository {
  final HomeDatasource datasource;

  HomeRepository({required this.datasource});
  Future<dynamic> getCityList() async {
    return datasource.getCityList();
  }

  Future<dynamic> getSliderImage() async {
    return datasource.getSliderImages();
  }

  Future<dynamic> getHospitalTypeList() async {
    return datasource.getHospitalType();
  }

  Future<dynamic> getHospitalList() async {
    return datasource.getHospitalList();
  }

  Future<dynamic> getHospitalListById({required String hospitalTypeId}) async {
    return datasource.getHospitalListById(hospitalTypeId: hospitalTypeId);
  }
}
