import 'package:flutter/material.dart';
import 'package:vendor_app/utility/hex_color.dart';


class Style {


  static Container cardDivider = Container(
    width: double.infinity,
    height: 10.0,
    color: Color.fromRGBO(222, 221, 222, 100.0),
  );
  static Container contentDivider = Container(
    margin: EdgeInsets.only(top: 10.0),
    width: double.infinity,
    height: 2.0,
    color: HexColor("#e5e5e5"),
  );


  String font_regular() {
    return 'roboto_regular';
  }

  String font_light() {
    return 'roboto_light';
  }

  String font_bold() {
    return 'roboto_bold';
  }

  String font_medium() {
    return 'roboto_medium';
  }



}
