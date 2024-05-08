import 'package:vendor_app/app_themes/custom_tab_underline_indicator.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app/utility/hex_color.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),
  primarySwatch: MaterialColor(
    Colors.blue.value,
    <int, Color>{
      50: Colors.blue[50]!,
      100: Colors.blue[100]!,
      200: Colors.blue[200]!,
      300: Colors.blue[300]!,
      400: Colors.blue[400]!,
      500: Colors.blue[500]!,
      600: Colors.blue[600]!,
      700: Colors.blue[700]!,
      800: Colors.blue[800]!,
      900: Colors.blue[900]!
    },
  ),
  tabBarTheme: TabBarTheme(
    indicator: CustomTabUnderlineIndicator(
        color: const Color.fromARGB(255, 30, 146, 241), radius: 15.0),

    // UnderlineTabIndicator(
    //     borderSide: const BorderSide(
    //         width: 3.2, color: Color.fromARGB(255, 30, 146, 241))),
    indicatorSize: TabBarIndicatorSize.label,
    labelColor: Colors.black,
    unselectedLabelColor: const Color.fromARGB(255, 149, 154, 170),
    labelStyle: const TextStyle(
      fontFamily: "lato_medium",
      fontSize: 18.0,
    ),
    unselectedLabelStyle: const TextStyle(
      fontFamily: "lato_medium",
      fontSize: 18.0,
    ),
  ),
  radioTheme: RadioThemeData(
      fillColor: MaterialStateColor.resolveWith((states) => Colors.blue)),
  colorScheme: ColorScheme(
      background: const Color(0XFFf9fbff),
      brightness: Brightness.light,
      error: Colors.white,
      onBackground: Colors.black,
      onError: Colors.black,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black,
      primary: HexColor('#ED8F2D'),
      // primaryVariant: Colors.blue[700],
      secondary: HexColor('0C3469'),
      // secondaryVariant: Color(0xFF7c8295),
      surface: const Color(0XFFFFFFFF)),
  // primaryColorBrightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0XFFf9fbff),
  backgroundColor: HexColor('F5F7F9'),
  hintColor: Colors.grey,
  // buttonTheme: const ButtonThemeData(buttonColor: Colors.blue),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 14.0,
      fontFamily: "lato_regular",
      color: Colors.black,
    ),
    headline1: TextStyle(
      fontFamily: "lato_medium",
      fontSize: 16.0,
      color: Colors.black,
    ),
    headline3: TextStyle(
      fontSize: 12.0,
      fontFamily: "lato_regular",
      color: Colors.black,
    ),
  ),
  dividerColor: const Color(0Xffeaedf4),
  cardColor: const Color(0XFFFFFFFF),
  iconTheme: const IconThemeData(color: Colors.blue),
  appBarTheme: const AppBarTheme(
      backgroundColor: Color(0XFFf9fbff),
      shadowColor: Colors.black12,
      elevation: 5.0,
      iconTheme: IconThemeData(color: Colors.blue),
      titleTextStyle: TextStyle(color: Colors.black)),
  chipTheme: const ChipThemeData(
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    disabledColor: Colors.white,
    secondarySelectedColor: Colors.blue,
    selectedColor: Colors.blue,
    labelStyle: TextStyle(
        fontSize: 14.0, fontFamily: "lato_regular", color: Colors.black),
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    secondaryLabelStyle: TextStyle(
        fontSize: 14.0, fontFamily: "lato_regular", color: Colors.white),
  ),
  bottomAppBarColor: const Color(0xFFeff1f5),
  shadowColor: const Color(0xFFeff1f5),
  dropdownMenuTheme:DropdownMenuThemeData(textStyle: TextStyle(fontSize: 16)),

);

