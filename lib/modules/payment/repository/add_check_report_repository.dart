import 'dart:convert';

import '../../../models/apiResponseHandlerModel.dart';
import '../../../models/service_request/service_list_model.dart';
import '../../../utility/app_constant.dart';
import '../../../utility/network/network_helper.dart';

AddCheckReportRepository? paymentRepository;

class AddCheckReportRepository {

  static Future<dynamic> updateServiceCheckReportEvent(bodyJson) async {
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
          apiUrl: AppConstant.ServiceRequestAddCheckReports,
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

        if(jsonResponse != null  ) {
          if(jsonResponse['isAddSuccess']) {
            apiResponseHandler.data = jsonResponse;
            apiResponseHandler.message = 'success';
            apiResponseHandler.status = "S";
          }else{
            apiResponseHandler.data = jsonResponse;
            apiResponseHandler.message = jsonResponse['message'];
            apiResponseHandler.status = "F";
          }
          return apiResponseHandler;
        }else{
          apiResponseHandler.data = jsonResponse;
          apiResponseHandler.message = jsonResponse['message'];
          apiResponseHandler.status = "F";
          return apiResponseHandler;
        }
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

  static Future<dynamic> updateActionEvent(bodyJson) async {
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
          apiUrl: AppConstant.ServiceRequestAddActions,
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

        if(jsonResponse != null  ) {
          if(jsonResponse['isAddSuccess']) {
            apiResponseHandler.data = jsonResponse;
            apiResponseHandler.message = 'success';
            apiResponseHandler.status = "S";
          }else{
            apiResponseHandler.data = jsonResponse;
            apiResponseHandler.message = jsonResponse['message'];
            apiResponseHandler.status = "F";
          }
          return apiResponseHandler;
        }else{
          apiResponseHandler.data = jsonResponse;
          apiResponseHandler.message = jsonResponse['message'];
          apiResponseHandler.status = "F";
          return apiResponseHandler;
        }
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

  static Future<dynamic> updateSparePartsEvent(bodyJson) async {
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
          apiUrl: AppConstant.ServiceRequestAddParts,
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

        if(jsonResponse != null  ) {
          if(jsonResponse['isAddSuccess']) {
            apiResponseHandler.data = jsonResponse;
            apiResponseHandler.message = 'success';
            apiResponseHandler.status = "S";
          }else{
            apiResponseHandler.data = jsonResponse;
            apiResponseHandler.message = jsonResponse['message'];
            apiResponseHandler.status = "F";
          }
          return apiResponseHandler;
        }else{
          apiResponseHandler.data = jsonResponse;
          apiResponseHandler.message = jsonResponse['message'];
          apiResponseHandler.status = "F";
          return apiResponseHandler;
        }
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
