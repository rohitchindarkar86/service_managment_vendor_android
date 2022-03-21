import 'package:flutter/material.dart';
import 'package:vendor_app/style/style.dart';
import 'package:vendor_app/utility/hex_color.dart';

class ForgotEmailSuccessWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ForgotEmailSuccessWidgetState();
}

class ForgotEmailSuccessWidgetState extends State<ForgotEmailSuccessWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.35,
            margin: EdgeInsets.symmetric(horizontal: 24),
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height *0.05,
                ),
                Container(
                  width: 45,
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/forgot_email_img.png'),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 16, left: 24, right: 24),
                    child: GestureDetector(
                      onTap: (){

                      },
                      child:   RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Please check your email',
                              style: TextStyle(fontFamily: Style().font_medium(),fontSize: 16,color: HexColor('#000000')),
                            ),
                          ],
                        ),
                      ),
                    )

                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 16, left: 24, right: 24),
                    child: GestureDetector(
                      onTap: (){

                      },
                      child:   RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'We ‘ve sent an email to\nup**********gmail.com with instructions to\nreset your password.',
                              style: TextStyle(fontFamily: Style().font_regular(),fontSize: 14,color: HexColor('#393838')),
                            ),
                          ],
                        ),
                      ),
                    )

                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  margin: EdgeInsets.only(top: 24, left: 24, right: 24),
                  child: ElevatedButton(
                    child: Text('SIGN IN'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: HexColor('ED8F2D'),
                        // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                        textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}