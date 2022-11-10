import 'dart:convert';

import '../../../models/apiResponseHandlerModel.dart';
import '../../../models/master/brand_master_model.dart';
import '../../../utility/app_constant.dart';
import '../../../utility/network/network_helper.dart';

MasterRepository? loginRepository;

class MasterRepository {

  // ServiceComplaint Action Taken
  static Future<dynamic> pincodeDataEvent(bodyJson) async {
    bodyJson =  json.encode(bodyJson);
    var apiResponseHandler =  ApiResponseHandlerModel();
    try {
      final response = await NetworkHelper.CallApiServer(
          // headers: headers,
          apiMode: "GET",
          apiUrl: AppConstant.GET_MASTER_DATA_PINCODE,
          body: bodyJson.toString(),
          onTimeOut: () {
            throw Exception('Timeout occurred');
          });

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
        apiResponseHandler.data = [];
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

  // brand Master
  static Future<dynamic> brandMasterList(bodyJson) async {
    bodyJson =  json.encode(bodyJson);
    var apiResponseHandler =  ApiResponseHandlerModel();
    try {
      final response = await NetworkHelper.CallApiServer(
        // headers: headers,
          apiMode: "POST",
          apiUrl: AppConstant.GET_MASTER_DATA_BY_NAME,
          body: bodyJson.toString(),
          onTimeOut: () {
            throw Exception('Timeout occurred');
          });

      if (response.statusCode == 400) {
        apiResponseHandler.data = [];
        apiResponseHandler.message = response.message;
        apiResponseHandler.status = "F";
        return apiResponseHandler;
      } else if (response.statusCode == 200) {

        var jsonResponse = response.data;

        golbalBrandMasterModel = List<BrandMasterModel>.from(
            jsonResponse.map((x) => BrandMasterModel.fromJson(x)));
        apiResponseHandler.data = golbalBrandMasterModel;
        apiResponseHandler.message = 'success';
        apiResponseHandler.status = "S";

        return apiResponseHandler;
      } else {
        apiResponseHandler.data = [];
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

  // ServiceComplaint Action Taken
  static Future<dynamic> actionTakenEvent(bodyJson) async {
    bodyJson =  json.encode(bodyJson);
    var apiResponseHandler =  ApiResponseHandlerModel();
    try {
      final response = await NetworkHelper.CallApiServer(
        // headers: headers,
          apiMode: "POST",
          apiUrl: AppConstant.GET_MASTER_DATA_BY_NAME,
          body: bodyJson.toString(),
          onTimeOut: () {
            throw Exception('Timeout occurred');
          });

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
        apiResponseHandler.data = [];
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

  // ServiceComplaint Action Taken
  static Future<dynamic> partsReplacedEvent(bodyJson) async {
    bodyJson =  json.encode(bodyJson);
    var apiResponseHandler =  ApiResponseHandlerModel();
    try {
      final response = await NetworkHelper.CallApiServer(
        // headers: headers,
          apiMode: "POST",
          apiUrl: AppConstant.SERVICE_REQUEST_ADD_PARTS,
          body: bodyJson.toString(),
          onTimeOut: () {
            throw Exception('Timeout occurred');
          });

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
        apiResponseHandler.data = [];
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
