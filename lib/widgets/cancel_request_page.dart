
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor_app/modules/dashboard/dashboard/dashboard_page.dart';
import 'package:vendor_app/style/style.dart';
import 'package:vendor_app/utility/hex_color.dart';

class CancelRequestPage extends StatefulWidget {
  static const String routeName = '/cancelRequestPage';

  const CancelRequestPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => CancelRequestPageState();
}

class CancelRequestPageState extends State<CancelRequestPage>
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
                        child: Lottie.asset('assets/lottie_anim/cancel_request.json')),
                    SizedBox(
                      height:MediaQuery.of(context).size.height * 0.05 ,
                    ),
                    Text(
                      'Your Service is Cancelled\nSuccessfully.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: Style().font_medium(),
                        color: HexColor('000000')
                      ),
                    ),
                    SizedBox(
                      height:MediaQuery.of(context).size.height * 0.05 ,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
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
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: ElevatedButton(
                  child: const Text('Go To Dashboard'),
                  onPressed: () {
                   Navigator.pushNamedAndRemoveUntil(context, DashboardPage.routeName, (route) => false);

                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor('F11212'),
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