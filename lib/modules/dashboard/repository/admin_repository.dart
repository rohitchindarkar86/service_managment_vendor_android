import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../utility/app_constant.dart';

AdminRepository? adminRepository;

class AdminRepository {

  static Future<http.Response> apiCall(bodyJson) async {
    bodyJson =  json.encode(bodyJson);
    final url = Uri.parse(AppConstant.generate_qr_code);
    final headers = {
      "accept": "*/*",
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${AppConstant.userTokken}',
    };
    final response = await http.post(url, headers: headers,body: bodyJson);
    return response;
  }


}
