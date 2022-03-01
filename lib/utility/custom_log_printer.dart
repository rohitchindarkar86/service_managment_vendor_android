
import 'package:vendor_app/utility/app_constant.dart';

class CustomLogPrinter{

  //For Debug Log Print
  static printDebugLog(val){
    if(AppConstant.is_debug_logs_on) {
      print('Degub Log:-' + val);
    }
  }
  //For Info Log Print
  static printInfoLog(val){
    if(AppConstant.is_info_logs_on) {
      print('Info Log:-' + val);
    }
  }

  //For Info Log Print
  static printExceptionLog(val){
    if(AppConstant.is_exception_logs_on) {
      print('Exception Log:-' + val);
    }
  }
}