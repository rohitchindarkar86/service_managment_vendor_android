
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vendor_app/generated/locale_keys.g.dart';
import 'package:vendor_app/style/style.dart';
import 'package:vendor_app/utility/hex_color.dart';

import '../utility/app_utility.dart';

class LogoutOverlay extends StatefulWidget {
  String fromScreen;
  LogoutOverlay(this.fromScreen, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => LogoutOverlayState();
}

class LogoutOverlayState extends State<LogoutOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 450));
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
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(15.0),
              height: 180.0,
              decoration: ShapeDecoration(
                  color: HexColor('#FFFFFF'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 20.0, right: 20.0),
                    child: Text(
                      widget.fromScreen == 'Logout'?'Are you sure,you want to Logout?':LocaleKeys.ExitHeadingText.tr(),
                      style: TextStyle(color: Colors.black,fontFamily:  Style().font_regular(), fontSize: 16.0),
                    ),
                  ),
                  const SizedBox(height: 3,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ButtonTheme(
                            height: 35.0,
                            minWidth: 110.0,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: HexColor('ED8F2D'),
                                  // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              child: Text(
                                widget.fromScreen == 'Logout'?"Logout":LocaleKeys.ExitExitBtn.tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: HexColor('#FFFFFF'),
                                    fontFamily: Style().font_medium(),
                                    fontSize: 14.0),
                              ),
                              onPressed: () {
                                widget.fromScreen == 'Logout'?
                                AppUtility.logoutUser(context): SystemNavigator.pop();
                              },
                            )),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 10.0, top: 10.0, bottom: 10.0),
                          child:  ButtonTheme(
                              height: 35.0,
                              minWidth: 110.0,
                              child: ElevatedButton(
                                child: Text(
                                  LocaleKeys.ExitCancelBtn.tr(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: HexColor('#FFFFFF'),
                                      fontFamily: Style().font_medium(),
                                      fontSize: 14.0),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: HexColor('ED8F2D'),
                                    // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        color: HexColor('ED8F2D'),
                                        fontWeight: FontWeight.bold)),
                              ))
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}