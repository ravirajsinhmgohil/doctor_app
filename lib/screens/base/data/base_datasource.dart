import 'package:doctor_app/screens/base/models/update_number_request.dart';
import 'package:doctor_app/utils/api_helper.dart';
import 'package:doctor_app/utils/http_helper.dart';

class BaseDatasource {
  Future<dynamic> updateNumber(
      {required UpdateNumberRequest updateNumberRequest}) async {
    return HttpHelper.post(

      
        uri: Api.updateNumber, body: updateNumberRequest.toJson());
  }
}
