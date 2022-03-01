import 'package:flutter/material.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;

    switch(settings.name){

      // case LoginScreen.routeName:
      //   return MaterialPageRoute(builder: (builder) => LoginScreenPage(),);

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