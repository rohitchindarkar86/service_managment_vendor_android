import 'package:flutter/material.dart';
import 'package:vendor_app/modules/dashboard/dashboard/dashboard_page.dart';
import 'package:vendor_app/utility/hex_color.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../../style/style.dart';
import '../../utility/app_constant.dart';
import '../login/technician_login/technician_login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    getUserData();

  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width *0.35,
                        alignment: Alignment.center,
                        child: Image.asset('assets/images/app_logo.png'),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Place',
                                style: TextStyle(fontFamily: Style().font_bold(),fontSize: 30,color: HexColor('#ED8F2D')),
                              ),
                              TextSpan(text: ' Your Service ',style: TextStyle(fontFamily: Style().font_regular(),fontSize: 30,color: HexColor('000000'))),
                            ],
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  getUserData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? userToken = '';
    userToken = sharedPreferences.getString("userToken")??"";

    if(userToken != "" ) {
      AppConstant.userTokken = userToken;
    }
    Timer(
        Duration(seconds: 5),
            () => Navigator.pushNamed(context, userToken == "" ?TechnicianLoginPage.routeName:DashboardPage.routeName));
  }
}