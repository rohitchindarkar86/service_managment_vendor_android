import 'dart:convert';

import '../../../models/apiResponseHandlerModel.dart';
import '../../../utility/DeviceInfo.dart';
import '../../../utility/app_constant.dart';
import '../../../utility/network/network_helper.dart';

MasterRepository? loginRepository;

class MasterRepository {

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


}
