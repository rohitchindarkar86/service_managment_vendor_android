import 'package:flutter/material.dart';
import 'package:vendor_app/style/style.dart';

import '../../utility/hex_color.dart';

class AppHeaderWidget extends StatelessWidget{
  String headerText;
  Function backPress;
  AppHeaderWidget(this.headerText,this.backPress, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54.withOpacity(0.1),
                blurRadius: 15.0,
                offset: const Offset(0.0, 0.75)
            )
          ],
          color: HexColor('#ED8F2D'),
        ),
        width: MediaQuery
            .of(context)
            .size
            .width,
        padding: const EdgeInsets.symmetric(
            horizontal: 16),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment
          //     .spaceBetween,
          crossAxisAlignment: CrossAxisAlignment
              .center,
          children: [
            GestureDetector(
              onTap: (){
                backPress();
              },
              child: const Icon(Icons.arrow_back,
                color: Colors.white,),
            ),
            const SizedBox(width: 16,),
            Expanded(
              child: Container(
                alignment: Alignment
                    .centerLeft,
                child: Text(
                    headerText,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: Style()
                            .font_bold(),
                        color: Colors.white)),
              ),
            ),
          ],
        )
    );
  }
}