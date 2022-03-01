import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:vendor_app/models/network_helper_error_model.dart';
import 'package:vendor_app/utility/app_constant.dart';


import 'network_connectivity.dart';

var dio = Dio();


class NetworkHelper {
  static Future<dynamic> getData(
      {@required String ?apiUrl,
        Map<String, String> ?params,
        Map<String, String> ?headers,
        dynamic onTimeOut,
        Duration? cache_duration,
        bool ?forcerefreshcache,
        bool ?is_sslpin_enable,
        bool isxmlresponse=false,
        int ?time_out_inseconds}) async {
    String url;
    var timeout = Duration(
        seconds: time_out_inseconds == null
            ? AppConstant.networkTimeOut
            : time_out_inseconds);
    if (params!.isEmpty) {
      url = apiUrl!;
    } else {
      var value = params.entries
          .map<String>((e) => '${e.key}=${e.value}')
          .toList()
          .join('&');
      url = '$apiUrl?$value';
    }
    bool isInternetAvailabel = await CheckConnectivity().checkInternet();
    if (!isInternetAvailabel) {
      NetworkHelperErrModel networkErr = new NetworkHelperErrModel();

      networkErr.statusCode = 400;
      networkErr.message = "kindly check your internet connection";
      return networkErr;
    }
    try {
      final response = await dio
          .get(url,
         options:  cache_duration==null || forcerefreshcache==null?null:buildCacheOptions(
           cache_duration,
           forceRefresh: forcerefreshcache
        ),
      )
          .timeout(timeout, onTimeout: onTimeOut);
      http.Response rs;
      if (isxmlresponse == true)
        rs = new http.Response(response.data, response.statusCode!);
      else
        rs = new http.Response(jsonEncode(response.data), response.statusCode!);
      return rs;
    } catch (e) {
      NetworkHelperErrModel networkErr = new NetworkHelperErrModel();
      networkErr.statusCode = 505;  //for dio exception
      if (e is DioError) {
        networkErr.message = exception_handle(e).toString();
      } else {
        networkErr.message = "Error ${e}";
      }
      return networkErr;
    }
  }

  static Future<dynamic> postData(
      {@required String? apiUrl,
        String? body,
        Map<String, dynamic>? headers,
        dynamic? onTimeOut,
        Duration? cache_duration,
        bool? forcerefreshcache,
        bool? is_sslpin_enable,
        int? time_out_inseconds,
        bool shouldRetry = false,
        bool isxmlresponse =false,
        int retryCount = 0}) async {
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

    var timeout = Duration(
        seconds: time_out_inseconds == null
            ? AppConstant.networkTimeOut
            : time_out_inseconds);

    try {

      final response = await dio
          .post(
        apiUrl!,
        data: body,
        options:  cache_duration==null || forcerefreshcache==null?null:buildCacheOptions(
            cache_duration,
            forceRefresh: forcerefreshcache
        ),
      )  .timeout(timeout, onTimeout: onTimeOut);


      http.Response rs;
      if (isxmlresponse == true)
        rs = new http.Response(response.data.toString(), response.statusCode!);
      else
        rs = new http.Response(jsonEncode(response.data), response.statusCode!);
      return rs;
    } catch (e) {

      if (shouldRetry) {
        return postData(
            apiUrl: apiUrl,
            body: body,
            headers: headers,
            onTimeOut: onTimeOut,
            cache_duration: cache_duration,
            forcerefreshcache: forcerefreshcache,

            is_sslpin_enable: is_sslpin_enable,
            time_out_inseconds: time_out_inseconds ?? 60,
            shouldRetry: shouldRetry,
            retryCount: ++retryCount);
      }

      else {

        NetworkHelperErrModel networkErr = new NetworkHelperErrModel();
        networkErr.statusCode = 505;  //for dio exception
        if (e is DioError) {
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
