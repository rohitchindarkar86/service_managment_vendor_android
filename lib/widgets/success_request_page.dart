
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor_app/generated/locale_keys.g.dart';
import 'package:vendor_app/modules/dashboard/dashboard/dashboard_page.dart';
import 'package:vendor_app/style/style.dart';
import 'package:vendor_app/utility/hex_color.dart';

class SuccessRequestPage extends StatefulWidget {
  static const String routeName = '/successRequestPage';
  @override
  State<StatefulWidget> createState() => SuccessRequestPageState();
}

class SuccessRequestPageState extends State<SuccessRequestPage>
    with SingleTickerProviderStateMixin {


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(context, DashboardPage.routeName, (route) => false);
          return true;
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          child:Column(
            children: [
              Expanded(child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  children: [
                    SizedBox(
                      height:MediaQuery.of(context).size.height * 0.15 ,
                    ),
                    Container(
                        height: 180,
                        child: Lottie.asset('assets/lottie_anim/success_request.json')),
                    SizedBox(
                      height:MediaQuery.of(context).size.height * 0.05 ,
                    ),
                    Container(
                      child: Text(
                        'Your Service is Completed\nSuccessfully.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: Style().font_medium(),
                          color: HexColor('000000')
                        ),
                      ),
                    ),
                    SizedBox(
                      height:MediaQuery.of(context).size.height * 0.05 ,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 36),
                      child: Text(
                        'Go to dashboard for your next service to serve best service to the customer.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: Style().font_regular(),
                            color: HexColor('000000')
                        ),
                      ),
                    )
                  ],
                ),
              ),),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: ElevatedButton(
                  child: Text('Go To Dashboard'),
                  onPressed: () {
                   Navigator.pushNamedAndRemoveUntil(context, DashboardPage.routeName, (route) => false);

                  },
                  style: ElevatedButton.styleFrom(
                      primary: HexColor('008d00'),
                      // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 12,
              )
            ],
          )
        ),
      ),
    );
  }
}