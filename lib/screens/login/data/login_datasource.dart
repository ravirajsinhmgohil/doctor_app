import 'package:doctor_app/screens/login/model/login_request.dart';
import 'package:doctor_app/utils/api_helper.dart';
import 'package:doctor_app/utils/http_helper.dart';

class LoginDatasource {
  Future<dynamic> doLogin({required LoginRequest loginRequest}) async {
    return await HttpHelper.post(uri: Api.login, body: loginRequest.toJson());
  }
}
