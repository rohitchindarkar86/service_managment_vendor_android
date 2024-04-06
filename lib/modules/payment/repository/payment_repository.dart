import 'dart:convert';

import '../../../models/apiResponseHandlerModel.dart';
import '../../../utility/app_constant.dart';
import '../../../utility/network/network_helper.dart';

PaymentRepository? paymentRepository;

class PaymentRepository {

  static Future<dynamic> paymentDetailsEvent(bodyJson) async {
    bodyJson =  json.encode(bodyJson);
    var apiResponseHandler =  ApiResponseHandlerModel();
    try {
      final response = await NetworkHelper.CallApiServer(
          headers:{
            "accept": "*/*",
            "Content-Type": "application/json",
            'Authorization': 'Bearer ${AppConstant.userTokken}',
          },
          apiMode: "POST",
          apiUrl: AppConstant.PAYMENT_DETAILS,
          body: bodyJson.toString(),
          onTimeOut: () {
            throw Exception('Timeout occurred');
          });
      var jsonResponse;
      jsonResponse = response.data;
      if (response.statusCode == 400) {
        apiResponseHandler.data = [];
        apiResponseHandler.message = '${jsonResponse['message']} - ${jsonResponse['validationStatuses'][0]['validationMessage']} ';
        apiResponseHandler.status = "F";
        return apiResponseHandler;
      } else if (response.statusCode == 200) {


        apiResponseHandler.data = jsonResponse;
        apiResponseHandler.message = 'success';
        apiResponseHandler.status = "S";
        return apiResponseHandler;

      } else {
        apiResponseHandler.data = jsonResponse;
        apiResponseHandler.message = "fail";
        apiResponseHandler.status = "F";
        return apiResponseHandler;
      }
    } catch (e) {
      apiResponseHandler.data = [];
      apiResponseHandler.message =
      "Something went wrong, please try after some time";
      apiResponseHandler.status = "E";
      return apiResponseHandler;
    }
  }

  static Future<dynamic> qrCodeGenerateEvent(bodyJson) async {
    bodyJson =  json.encode(bodyJson);
    var apiResponseHandler =  ApiResponseHandlerModel();
    try {
      final response = await NetworkHelper.CallApiServer(
          headers:{
            "accept": "*/*",
            "Content-Type": "application/json",
            'Authorization': 'Bearer ${AppConstant.userTokken}',
          },
          apiMode: "POST",
          apiUrl: AppConstant.PAYMENT_QR_GENERATE,
          body: bodyJson.toString(),
          onTimeOut: () {
            throw Exception('Timeout occurred');
          });
      var jsonResponse;
       jsonResponse = response.data;
      if (response.statusCode == 400) {
        apiResponseHandler.data = [];
        apiResponseHandler.message = '${jsonResponse['message']} - ${jsonResponse['validationStatuses'][0]['validationMessage']} ';
        apiResponseHandler.status = "F";
        return apiResponseHandler;
      } else if (response.statusCode == 200) {


          apiResponseHandler.data = jsonResponse;
          apiResponseHandler.message = 'success';
          apiResponseHandler.status = "S";
          return apiResponseHandler;

      } else {
        apiResponseHandler.data = jsonResponse;
        apiResponseHandler.message = "fail";
        apiResponseHandler.status = "F";
        return apiResponseHandler;
      }
    } catch (e) {
      apiResponseHandler.data = [];
      apiResponseHandler.message =
      "Something went wrong, please try after some time";
      apiResponseHandler.status = "E";
      return apiResponseHandler;
    }
  }

  static Future<dynamic> qrCodeCheckEvent(bodyJson) async {
    bodyJson =  json.encode(bodyJson);
    var apiResponseHandler =  ApiResponseHandlerModel();
    try {
      final response = await NetworkHelper.CallApiServer(
          headers:{
            "accept": "*/*",
            "Content-Type": "application/json",
            'Authorization': 'Bearer ${AppConstant.userTokken}',
          },
          apiMode: "POST",
          apiUrl: AppConstant.PAYMENT_CHECK,
          body: bodyJson.toString(),
          onTimeOut: () {
            throw Exception('Timeout occurred');
          });
      var jsonResponse;
       jsonResponse = response.data;
      if (response.statusCode == 400) {
        apiResponseHandler.data = [];
        apiResponseHandler.message = '${jsonResponse['message']} - ${jsonResponse['validationStatuses'][0]['validationMessage']} ';
        apiResponseHandler.status = "F";
        return apiResponseHandler;
      } else if (response.statusCode == 200) {


          apiResponseHandler.data = jsonResponse;
          apiResponseHandler.message = 'success';
          apiResponseHandler.status = "S";
          return apiResponseHandler;

      } else {
        apiResponseHandler.data = jsonResponse;
        apiResponseHandler.message = "fail";
        apiResponseHandler.status = "F";
        return apiResponseHandler;
      }
    } catch (e) {
      apiResponseHandler.data = [];
      apiResponseHandler.message =
      "Something went wrong, please try after some time";
      apiResponseHandler.status = "E";
      return apiResponseHandler;
    }
  }


}
