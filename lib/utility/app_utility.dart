
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../utility/hex_color.dart';
class AppUtility{

  static AppUtility appUtility = AppUtility();
  static AppUtility getInstance(){
    return appUtility;
  }

  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor:  HexColor('ED8F2D'),
        textColor: Colors.white,
        fontSize: 16.0);
  }

}