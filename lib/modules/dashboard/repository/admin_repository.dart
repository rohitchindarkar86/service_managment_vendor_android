import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../models/apiResponseHandlerModel.dart';
import '../../../models/service_request/order_book_list_model.dart';
import '../../../models/service_request/service_list_model.dart';
import '../../../utility/app_constant.dart';
import '../../../utility/network/network_helper.dart';
import 'package:path_provider/path_provider.dart';
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
