
import 'package:flutter/material.dart';

import '../../style/style.dart';
import '../../utility/hex_color.dart';

class ProfileWidget{

  static idLableWidget(lable){
    return Container(
      child: Text(lable,style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#80000000')),),
    );
  }

  static idTexteWidget(lable){
    return Container(
      child: Text(lable, textAlign:TextAlign.center,style: TextStyle(fontSize: 16,fontFamily: Style().font_medium(),color: HexColor('#BF000000')),),
    );
  }
  static profileLableTextWidget(lable,text){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
         border: Border.all(color: HexColor('464646').withOpacity(0.3)),

      ),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Container(
          height: 35,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 8),
            child: Text(lable,style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('#ED8F2D')),)),
          Divider(
            height: 2,
            thickness: 1,
            color:  HexColor('464646').withOpacity(0.3),
          ),
          Container(
            height: 35,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 8),
            child: Text(text,style: TextStyle(fontSize: 14,fontFamily: Style().font_medium(),color: HexColor('#000000')),),)

        ],
      )

    );
  }
}