import 'package:connectivity_plus/connectivity_plus.dart';

class CheckConnectivity {
  Future<bool> checkInternet() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        return true;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }


  }
}
