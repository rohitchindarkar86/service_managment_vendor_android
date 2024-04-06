
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor_app/modules/dashboard/dashboard/dashboard_page.dart';
import 'package:vendor_app/modules/login/technician_login/index.dart';
import 'package:vendor_app/style/style.dart';
import 'package:vendor_app/utility/hex_color.dart';

class SuccessPasswordPage extends StatefulWidget {
  static const String routeName = '/successPasswordPage';

  const SuccessPasswordPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SuccessPasswordPageState();
}

class SuccessPasswordPageState extends State<SuccessPasswordPage>
    with SingleTickerProviderStateMixin {


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    var password = arguments['password'] ?? '';
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushNamedAndRemoveUntil(context, DashboardPage.routeName, (route) => false);
          return true;
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child:Column(
            children: [
              Expanded(child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  children: [
                    SizedBox(
                      height:MediaQuery.of(context).size.height * 0.15 ,
                    ),
                    SizedBox(
                        height: 180,
                        child: Lottie.asset('assets/lottie_anim/success_request.json')),
                    SizedBox(
                      height:MediaQuery.of(context).size.height * 0.05 ,
                    ),
                    Text(
                      'Your Password is\n$password.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: Style().font_medium(),
                        color: HexColor('000000')
                      ),
                    ),


                  ],
                ),
              ),),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: ElevatedButton(
                  child: const Text('Go To Login'),
                  onPressed: () {
                   Navigator.pushNamedAndRemoveUntil(context, TechnicianLoginPage.routeName, (route) => false);

                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor('008d00'),
                      // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(
                height: 12,
              )
            ],
          )
        ),
      ),
    );
  }
}