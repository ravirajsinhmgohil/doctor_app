import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String token = 'token';
  static const String userLoginData = 'userLoginData';

  static const String cityData = 'cityId';
  static Future<void> setToken({required String userToken}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(token, userToken);
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(token) ?? '';
  }

  static Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> setCity({required String selectedId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(cityData, selectedId);
  }

  static Future<String> getCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(cityData) ?? '';
  }

  static Future<void> removeCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(cityData);
  }

  static Future<void> setLoginData({required String loginData}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(userLoginData, loginData);
  }

  static Future<String> getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(userLoginData) ?? '';
  }

  static Future<void> updateLoginData({required String loginData}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(loginData).then((value) async {
      await prefs.setString(userLoginData, loginData);
    });
  }
}
