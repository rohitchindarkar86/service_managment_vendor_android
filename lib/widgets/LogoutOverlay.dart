
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vendor_app/generated/locale_keys.g.dart';
import 'package:vendor_app/style/style.dart';
import 'package:vendor_app/utility/hex_color.dart';

class LogoutOverlay extends StatefulWidget {
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
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(15.0),
              height: 180.0,

              decoration: ShapeDecoration(
                  color: HexColor('ED8F2D'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 30.0, left: 20.0, right: 20.0),
                        child: Text(
                          "${LocaleKeys.ExitHeadingText.tr()}",
                          style: TextStyle(color: Colors.white,fontFamily:  Style().font_regular(), fontSize: 16.0),
                        ),
                      )),
                  Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ButtonTheme(
                                height: 35.0,
                                minWidth: 110.0,
                                child: RaisedButton(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  splashColor: Colors.white.withAlpha(40),
                                  child: Text(
                                    '${LocaleKeys.ExitExitBtn.tr()}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: HexColor('ED8F2D'),
                                        fontFamily: Style().font_medium(),
                                        fontSize: 14.0),
                                  ),
                                  onPressed: () {
                                    SystemNavigator.pop();
                                  },
                                )),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 10.0, top: 10.0, bottom: 10.0),
                              child:  ButtonTheme(
                                  height: 35.0,
                                  minWidth: 110.0,
                                  child: RaisedButton(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0)),
                                    splashColor: Colors.white.withAlpha(40),
                                    child: Text(
                                      '${LocaleKeys.ExitCancelBtn.tr()}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: HexColor('ED8F2D'),
                                          fontFamily: Style().font_medium(),
                                          fontSize: 14.0),
                                    ),
                                    onPressed: () {
                                     Navigator.pop(context);
                                    },
                                  ))
                          ),
                        ],
                      ))
                ],
              )),
        ),
      ),
    );
  }
}