import 'package:flutter/material.dart';
import 'package:vendor_app/utility/hex_color.dart';

extension darkThemeExtension on ColorScheme {
  Color get whiteColor => (this.brightness == Brightness.dark)
      ? HexColor("#000000")
      : HexColor("#FFFFFF");

  //----------------------Common bg data----------------
  Color get normalPageBgColor => (this.brightness == Brightness.dark)
      ? HexColor("#172040")
      : HexColor("#FFFFFF");
  Color get secondaryBlueBgColor => (this.brightness == Brightness.dark)
      ? HexColor("#1c2754")
      : HexColor("#FFFFFF");
  Color get secondaryCardBoxShadowColor => (this.brightness == Brightness.dark)
      ? HexColor("#061034")
      : HexColor("#eff1f5");
  Color get bottomBarShadowColor => (this.brightness == Brightness.dark)
      ? HexColor("#061034")
      : HexColor("#eff1f5");

  //----------------------Icon color data---------------------
  Color get iconBlueColor => (this.brightness == Brightness.dark)
      ? HexColor("#959aaa")
      : HexColor("#1e92f1");

  //------------------------Common black color data----------------------
  Color get blackColor => (this.brightness == Brightness.dark)
      ? HexColor("#FFFFFF")
      : HexColor("#000000");
  Color get blackColor1 => (this.brightness == Brightness.dark)
      ? HexColor("#FFFFFF")
      : HexColor("#222222");
  Color get blackColor2 => (this.brightness == Brightness.dark)
      ? HexColor("#FFFFFF")
      : HexColor("#404040");
  Color get blackColor3 => (this.brightness == Brightness.dark)
      ? HexColor("#FFFFFF")
      : HexColor("#10131d");
  Color get blackColor4 => (this.brightness == Brightness.dark)
      ? HexColor("#FFFFFF")
      : HexColor("#202020");
  Color get blackColor5 => (this.brightness == Brightness.dark)
      ? HexColor("#FFFFFF")
      : HexColor("#262626");

  Color get lightGreyColor => (this.brightness == Brightness.dark)
      ? HexColor("#FFFFFF")
      : HexColor("#555555");
  Color get lightGreyBgColor => (this.brightness == Brightness.dark)
      ? HexColor("#1c2754")
      : HexColor("#f9fbff");
  Color get greyColor1 => (this.brightness == Brightness.dark)
      ? HexColor("#FFFFFF")
      : HexColor("#808080");

  //----------------Login theme data--------------------
  Color? get registerTouchDialogBgColor1 =>
      (this.brightness == Brightness.dark) ? Color(0xFF1c2754) : null;

  //----------------Fund Limit theme data--------------------
  Color get cardBgColor1 => (this.brightness == Brightness.dark)
      ? Color(0xFF1c2754)
      : HexColor("#FFFFFF");
  Color get cardGreyTextColor => (this.brightness == Brightness.dark)
      ? HexColor("#959aaa")
      : HexColor("#000000");
  Color get primaryTextColor => (this.brightness == Brightness.dark)
      ? HexColor("#1e92f1")
      : HexColor("#FFFFFF");
  Color get primarybgColor => (this.brightness == Brightness.dark)
      ? HexColor("#e3f1fd")
      : HexColor("#56A5D1");

  //----------------Portfolio theme data--------------------
  Color get divderColor1 => (this.brightness == Brightness.dark)
      ? HexColor("#303956")
      : HexColor("#eaedf4");
  Color get bgColor1 => (this.brightness == Brightness.dark)
      ? HexColor("#172040")
      : HexColor("#FBFBFB");

  //-----------------footer theme data------------------
  Color get footerBgColor => (this.brightness == Brightness.dark)
      ? HexColor("#10131d")
      : HexColor("#FFFFFF");
  Color get footerBoxShadowColor => (this.brightness == Brightness.dark)
      ? HexColor("#959aaa")
      : HexColor("#eff1f5");

  //-----------------marquee theme data------------------
  Color get marqueeTextColor => (this.brightness == Brightness.dark)
      ? HexColor("#FFFFFF")
      : HexColor("#656565");

  //----------------watchlist theme data--------------------

  Color get marketIndicesBgColor => (this.brightness == Brightness.dark)
      ? HexColor("#1c2754")
      : HexColor("#F7F7F7");
  Color get setAlertBgColor => (this.brightness == Brightness.dark)
      ? HexColor("#636980")
      : HexColor("#215299");

  //---------------market theme data----------------

  Color get advanceScreenerBgColor => (this.brightness == Brightness.dark)
      ? HexColor("#304d5c")
      : HexColor("#dff4ff");
  Color get eventCalenderShadowColor => (this.brightness == Brightness.dark)
      ? HexColor("#172040")
      : HexColor("#eaedf4");

  //---------------mf theme data----------------

  Color get customRadioBtnBgColor => (this.brightness == Brightness.dark)
      ? HexColor("#000000")
      : HexColor("#ffffff");
  Color get customRadioBtnTextColor => (this.brightness == Brightness.dark)
      ? HexColor("#ffffff")
      : HexColor("#10131d");
  Color get customRadioBtnBorderColor => (this.brightness == Brightness.dark)
      ? HexColor("#c7cbd5")
      : HexColor("#c7cbd5");
  Color get customRadioSelectedBtnBgColor =>
      (this.brightness == Brightness.dark)
          ? HexColor("#ffffff")
          : HexColor("#000000");
  Color get customRadioSelectedBtnTextColor =>
      (this.brightness == Brightness.dark)
          ? HexColor("#10131d")
          : HexColor("#ffffff");
  Color get customRadioSelectedBtnBorderColor =>
      (this.brightness == Brightness.dark)
          ? HexColor("#c7cbd5")
          : HexColor("#c7cbd5");

  //---------------- order placement theme data--------------------

  Color? get highlightedDataBgColor => (this.brightness == Brightness.dark)
      ? HexColor("#1c2754")
      : Colors.grey[300];

//---------------getQuote theme data----------------
  Color get darkBgColor1 => (this.brightness == Brightness.dark)
      ? Color(0xFF1c2754)
      : HexColor('#FFFFFF');
  Color get darkBgColor2 => (this.brightness == Brightness.dark)
      ? Color(0xFF1c2754)
      : HexColor('#FBFBFB');
  Color get darkBgColor3 => (this.brightness == Brightness.dark)
      ? Color(0xFF1c2754)
      : HexColor('#EFF6FF');
  Color get darkBgColor4 => (this.brightness == Brightness.dark)
      ? Color(0XFF172040)
      : HexColor('#FBFBFB');
  Color get darkBgColor5 => (this.brightness == Brightness.dark)
      ? Color(0xFF1c2754)
      : HexColor('#FAFAFA');

//---------------IPO theme data----------------
  Color get greyBgColor1 => (this.brightness == Brightness.dark)
      ? Color(0xFF1c2754)
      : HexColor('#EEEEEE');

  //---------------Fliter theme data----------------
  Color get appBarColor1 => (this.brightness == Brightness.dark)
      ? Color(0xFF172040)
      : HexColor('#f9fbff');

  //---------------Shimmer----------------
  Color? get shimmerBaseColor1 => (this.brightness == Brightness.dark)
      ? Colors.grey[100]?.withOpacity(
          0.2,
        )
      : Colors.grey[300];
  Color? get shimmerHighLightColor1 => (this.brightness == Brightness.dark)
      ? Colors.grey[300]
      : Colors.grey[100];

//-----------------GetQuote Details theme data---------------------
  Color get gridBgColor1 => (this.brightness == Brightness.dark)
      ? HexColor("#303956")
      : HexColor("#FBFBFB");
  Color get listGridIconColor1 => (this.brightness == Brightness.dark)
      ? HexColor("#1e92f1")
      : HexColor("#222222");

//----------------------stock sip order book------------------------------

  Color get stockSipHighlightedBgColor => (this.brightness == Brightness.dark)
      ? HexColor("#1c2754")
      : HexColor("#E6E6E6");
}
