import 'package:flutter/material.dart';
import 'package:vendor_app/modules/dashboard/dashboard/dashboard_page.dart';

import 'modules/login/technician_login/technician_login_page.dart';
import 'modules/splash_screen/splash_screen.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;

    switch(settings.name){

      case '/splash':
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
          // settings omitted to hide route name
        );

      case TechnicianLoginPage.routeName:
        return MaterialPageRoute(builder: (builder) => TechnicianLoginPage(),);

        case DashboardPage.routeName:
        return MaterialPageRoute(builder: (builder) => DashboardPage(),);

    default:
      return errorRoute();
    }
  }

  static Route<dynamic> errorRoute(){

    return MaterialPageRoute(builder: (builder){
      return Scaffold(
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }
}