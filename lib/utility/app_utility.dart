
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../utility/hex_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modules/login/technician_login/technician_login_page.dart';
import '../style/style.dart';

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

  static FToast? fToast;
  static ShowToast(BuildContext context, Color bgColor, String message,
      Color textColor, int toastTimeSec) {
    fToast = FToast();
    fToast?.init(context);
    fToast?.showToast(
        child: Container(
          //height: 80,
          width: MediaQuery
              .of(context)
              .size
              .width,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: bgColor,
          ),
          child: Text(
            "${message}",
            //overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16,
                color: HexColor("FFFFFF"), //textColor,
                fontFamily: Style().font_regular()),
          ),
        ),
        toastDuration: Duration(seconds: toastTimeSec),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            bottom: 8,
            left: 8,
            right: 8,
          );
        });
  }

  static logoutUser(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    Navigator.pushNamedAndRemoveUntil(context, TechnicianLoginPage.routeName, (route) => false);
  }

  static insertToLocal(String key, object) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, object.toString());
  }

  static DataFromLocal(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }
  static validateEmail(email){
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    return emailValid;
  }
  static serviceColorPicker(int? serviceStatusCode){
    switch(serviceStatusCode){
      case 1:
        return HexColor('#C0392B');
      case 2:
        return HexColor('#D35400');
      case 3:
        return HexColor('#FFC300');
      case 4:
        return HexColor('#FF5733');
      case 5:
        return HexColor('#C70039');
      case 6:
        return HexColor('#8E44AD');
        case 7:
        return HexColor('#2471A3');
        case 8:
        return HexColor('#228B22');
      case 9:
        return HexColor('#2471A3');
      case 10:
        return HexColor('#A9DFBF');
      case 11:
        return HexColor('#C0392B');

      default:
        return HexColor('#D6DBDF');
    }
  }
}