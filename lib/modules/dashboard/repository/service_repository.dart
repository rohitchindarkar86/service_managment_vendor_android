import 'dart:convert';

import '../../../models/apiResponseHandlerModel.dart';
import '../../../models/service_request/service_list_model.dart';
import '../../../utility/app_constant.dart';
import '../../../utility/network/network_helper.dart';

ServiceRepository? serviceRepository;

class ServiceRepository {
  //Api Call For  Login
  static Future<dynamic> serviceListEvent(bodyJson) async {
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
          apiUrl: AppConstant.GET_SERVICE_REQUEST,
          body: bodyJson.toString(),
          onTimeOut: () {
            throw Exception('Timeout occurred');
          });
      var jsonResponse;
      if (response.statusCode == 400) {
        apiResponseHandler.data = [];
        apiResponseHandler.message = response.message;
        apiResponseHandler.status = "F";
        return apiResponseHandler;
      } else if (response.statusCode == 200) {

        var jsonResponse = response.data;
        List<ServiceListModel> serviceList = List<ServiceListModel>.from(jsonResponse.map((x) => ServiceListModel.fromJson(x)));

          apiResponseHandler.data = serviceList;
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

  //Updated Service Request
  static Future<dynamic> updateServiceRequestEvent(bodyJson) async {
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
          apiUrl: AppConstant.UPDATE_SERVICE_REQUEST,
          body: bodyJson.toString(),
          onTimeOut: () {
            throw Exception('Timeout occurred');
          });
      var jsonResponse;
      if (response.statusCode == 400) {
        apiResponseHandler.data = [];
        apiResponseHandler.message = response.message;
        apiResponseHandler.status = "F";
        return apiResponseHandler;
      } else if (response.statusCode == 200) {

        var jsonResponse = response.data;

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
