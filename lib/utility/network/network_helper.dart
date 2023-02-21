import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:vendor_app/models/network_helper_error_model.dart';
import 'package:vendor_app/utility/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'network_connectivity.dart';

var dio = Dio();


class NetworkHelper {

  static Future<dynamic> CallApiServer(
      {
        @required String? apiUrl,
        @required String? apiMode,
        String? body,
        Map<String, dynamic>? headers,
        Function? onTimeOut,
        bool shouldRetry = false,
        int retryCount = 0,
        int timeOut= 60  //in seconds
      }) async {

    bool isInternetAvailabel = await CheckConnectivity().checkInternet();
    if (!isInternetAvailabel) {
      NetworkHelperErrModel networkErr = new NetworkHelperErrModel();
      networkErr.statusCode = 0;
      networkErr.message = "kindly check your internet connection";
      return networkErr;
    }
    if (retryCount == 2) {
      NetworkHelperErrModel networkErr = new NetworkHelperErrModel();
      networkErr.statusCode = 300;
      networkErr.message =
      "Sorry!We are unable to service your request.Please try again later";
      return networkErr;
    }

    try {

      final response = await dio.request(apiUrl!,
        data: body,
        options: Options(
          method: apiMode,
          receiveTimeout: timeOut*1000,
          sendTimeout:timeOut*1000 ,
          headers:{
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${AppConstant.userTokken}',
        },
        ),
      );
      print(response.data);
      if(response.statusCode==200 || response.statusCode==201)
        return response;
      else{
        NetworkHelperErrModel errormodel = new NetworkHelperErrModel();
        if(response.statusCode==401 ||response.statusCode==403 ||response.statusCode==404 || response.statusCode==500){
          errormodel.statusCode=response.statusCode;
          errormodel.message=response.data['description']??"Server Error!";
        }
        else{
          errormodel.statusCode=500;
          errormodel.message="Server Error!";
        }
        return errormodel;
      }

    }

    catch (e) {
      if (shouldRetry) {
        return
          CallApiServer(
              apiUrl: apiUrl,
              body: body,
              headers: headers,
              onTimeOut: onTimeOut,
              shouldRetry: shouldRetry,
              retryCount: ++retryCount);
      }
      else {
        NetworkHelperErrModel networkErr = new NetworkHelperErrModel();
        networkErr.statusCode = 505;  //for dio exception
        if (e is DioError) {
          if(e.response!= null){
            return e.response;
          }
          networkErr.message = exception_handle(e).toString();
        } else {
          networkErr.message = "Error ${e}";
        }
        return networkErr;
      }
    }
  }

  static Future<dynamic> CallApiServer1(
      {
        @required String? apiUrl,
        @required String? apiMode,
        String? body,
        Map<String, dynamic>? headers,
        Function? onTimeOut,
        bool shouldRetry = false,
        int retryCount = 0,
        int timeOut= 60  //in seconds
      }) async {

    bool isInternetAvailabel = await CheckConnectivity().checkInternet();
    if (!isInternetAvailabel) {
      NetworkHelperErrModel networkErr = new NetworkHelperErrModel();
      networkErr.statusCode = 0;
      networkErr.message = "kindly check your internet connection";
      return networkErr;
    }
    if (retryCount == 2) {
      NetworkHelperErrModel networkErr = new NetworkHelperErrModel();
      networkErr.statusCode = 300;
      networkErr.message =
      "Sorry!We are unable to service your request.Please try again later";
      return networkErr;
    }

    try {

      final response = await dio.request(apiUrl!,
        data: body,
        options: Options(
          method: apiMode,
          receiveTimeout: timeOut*1000,
          sendTimeout:timeOut*1000 ,
          headers:{
            "Content-Type": "application/json",
            'Authorization': 'Bearer ${AppConstant.userTokken}',
          },
        ),
      );
      print(response.data);
      if(response.statusCode==200 || response.statusCode==201)
        return response;
      else{
        NetworkHelperErrModel errormodel = new NetworkHelperErrModel();
        if(response.statusCode==401 ||response.statusCode==403 ||response.statusCode==404 || response.statusCode==500){
          errormodel.statusCode=response.statusCode;
          errormodel.message=response.data['description']??"Server Error!";
        }
        else{
          errormodel.statusCode=500;
          errormodel.message="Server Error!";
        }
        return errormodel;
      }

    }

    catch (e) {
      if (shouldRetry) {
        return
          CallApiServer(
              apiUrl: apiUrl,
              body: body,
              headers: headers,
              onTimeOut: onTimeOut,
              shouldRetry: shouldRetry,
              retryCount: ++retryCount);
      }
      else {
        NetworkHelperErrModel networkErr = new NetworkHelperErrModel();
        networkErr.statusCode = 505;  //for dio exception
        if (e is DioError) {
          if(e.response!= null){
            return e.response;
          }
          networkErr.message = exception_handle(e).toString();
        } else {
          networkErr.message = "Error ${e}";
        }
        return networkErr;
      }
    }
  }
}

String? message;
exception_handle(DioError dioError) {

  switch (dioError.type) {
    case DioErrorType.cancel:
      return "Request to API server was cancelled";
      break;
    case DioErrorType.connectTimeout:
      message = "Connection timeout with API server";
      break;
    case DioErrorType.receiveTimeout:
      message = "Receive timeout in connection with API server";
      break;
    case DioErrorType.response:
      message = dioError.response?.statusCode.toString();
      break;
    case DioErrorType.sendTimeout:
      message = "Send timeout in connection with API server";
      break;
    default:
      message = "Something went wrong";
      break;
  }
  return message;
}
