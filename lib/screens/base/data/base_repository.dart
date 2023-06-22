import 'package:doctor_app/screens/base/data/base_datasource.dart';
import 'package:doctor_app/screens/base/models/update_number_request.dart';

class BaseRepository {
  final BaseDatasource datasource;

  BaseRepository({required this.datasource});
  Future<dynamic> updateNumber(
      {required UpdateNumberRequest updateNumberRequest}) async {
    return datasource.updateNumber(updateNumberRequest: updateNumberRequest);
  }
}
