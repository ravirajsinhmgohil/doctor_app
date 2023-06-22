import 'package:doctor_app/screens/login/data/login_datasource.dart';
import 'package:doctor_app/screens/login/model/login_request.dart';

class LoginRepository {
  final LoginDatasource datasource;

  LoginRepository({required this.datasource});
  Future<dynamic> doLogin({required LoginRequest loginRequest}) async {
    return datasource.doLogin(loginRequest: loginRequest);
  }
}
