import 'dart:convert';

import 'package:doctor_app/utils/api_helper.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  static Future<dynamic> get({required String uri}) async {
    var url = Uri.parse(Api.baseUrl + uri);
    print(url);
    var response = await http.get(url);

    print('STATUS___${response.statusCode}');
    try {
      return jsonDecode(response.body);
    } catch (e) {
      print('error -- ${e.toString()}');
      return response.body;
    }
  }

  static Future<dynamic> post({
    required String uri,
    Object? body,
  }) async {
    var url = Uri.parse(Api.baseUrl + uri);
    var response = await http.post(url, body: body);
    print(response.statusCode);
    try {
      return jsonDecode(response.body);
    } catch (e) {
      return response.body;
    }
  }
}
