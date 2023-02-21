import 'dart:convert';

import '../../../models/apiResponseHandlerModel.dart';
import '../../../models/master/brand_master_model.dart';
import '../../../models/master/refrigerant_master_model.dart';
import '../../../models/master/sub_applicance_master_model.dart';
import '../../../models/master/unit_qty_master_model.dart';
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
          apiUrl: AppConstant.GET_SERVICE_MASTER_DATA_BY_NAME,
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
          apiUrl: AppConstant.GET_MASTER_DATA_SPAREPARTS,
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

  // Gas Type -Refrigerant
  static Future<dynamic> refrigerantMasterList(bodyJson) async {
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

        golbalRefrigerantMasterModel = List<RefrigerantMasterModel>.from(
            jsonResponse.map((x) => RefrigerantMasterModel.fromJson(x)));
        apiResponseHandler.data = golbalRefrigerantMasterModel;
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

  // Unit Qty Master
  static Future<dynamic> UnitQtyMasterList(bodyJson) async {
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

        golbalUnitQtyMasterModel = List<UnitQtyMasterModel>.from(
            jsonResponse.map((x) => UnitQtyMasterModel.fromJson(x)));
        apiResponseHandler.data = golbalUnitQtyMasterModel;
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


  // Appliance Sub Type Master
  static Future<dynamic> ApplianceSubTypeMasterList(bodyJson) async {
    bodyJson =  json.encode(bodyJson);
    var apiResponseHandler =  ApiResponseHandlerModel();
    try {

      final response = await NetworkHelper.CallApiServer(
          headers: {
            "accept": "*/*",
            "Content-Type": "application/json",
            'Authorization': 'Bearer ${AppConstant.userTokken}',
          },
          apiMode: "POST",
          apiUrl: AppConstant.GET_MASTER_APPLIANCE_SUB_TYPE,
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

        golbalSubApplianceMasterModel = List<SubApplianceMasterModel>.from(
            jsonResponse.map((x) => SubApplianceMasterModel.fromJson(x)));
        apiResponseHandler.data = golbalSubApplianceMasterModel;
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
