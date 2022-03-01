import 'package:vendor_app/app_themes/custom_tab_underline_indicator.dart';
import 'package:flutter/material.dart';

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
          color: Color.fromARGB(255, 30, 146, 241), radius: 15.0),

      // UnderlineTabIndicator(
      //     borderSide: const BorderSide(
      //         width: 3.2, color: Color.fromARGB(255, 30, 146, 241))),
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: Colors.black,
      unselectedLabelColor: Color.fromARGB(255, 149, 154, 170),
      labelStyle: TextStyle(
        fontFamily: "roboto_medium",
        fontSize: 18.0,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: "roboto_medium",
        fontSize: 18.0,
      ),
    ),
    radioTheme: RadioThemeData(
        fillColor: MaterialStateColor.resolveWith((states) => Colors.blue)),
    colorScheme: ColorScheme(
        background: Color(0XFFf9fbff),
        brightness: Brightness.light,
        error: Colors.white,
        onBackground: Colors.black,
        onError: Colors.black,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.black,
        primary: Colors.blue,
        primaryVariant: Colors.blue[700],
        secondary: Color(0XFF959aaa),
        secondaryVariant: Color(0xFF7c8295),
        surface: Color(0XFFFFFFFF)),
    primaryColorBrightness: Brightness.light,
    scaffoldBackgroundColor: Color(0XFFf9fbff),
    backgroundColor: Color(0XFFf9fbff),
    hintColor: Colors.grey,
    buttonTheme: ButtonThemeData(buttonColor: Colors.blue),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 20.0,
        fontFamily: "roboto_medium",
        color: Color(0XFFc7cbd5),
      ),
      headline1: TextStyle(
        fontFamily: "roboto_medium",
        fontSize: 20.0,
        color: Colors.black,
      ),
      headline3: TextStyle(
        fontSize: 14.0,
        fontFamily: "roboto_regular",
        color: Colors.black,
      ),
    ),
    dividerColor: Color(0Xffeaedf4),
    cardColor: Color(0XFFFFFFFF),
    iconTheme: IconThemeData(color: Colors.blue),
    appBarTheme: AppBarTheme(
        backgroundColor: Color(0XFFf9fbff),
        shadowColor: Colors.black12,
        elevation: 5.0,
        iconTheme: IconThemeData(color: Colors.blue),
        titleTextStyle: TextStyle(color: Colors.black)),
    chipTheme: ChipThemeData(
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      disabledColor: Colors.white,
      secondarySelectedColor: Colors.blue,
      selectedColor: Colors.blue,
      labelStyle: TextStyle(
          fontSize: 14.0, fontFamily: "roboto_regular", color: Colors.black),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      secondaryLabelStyle: TextStyle(
          fontSize: 14.0, fontFamily: "roboto_regular", color: Colors.white),
    ),
    bottomAppBarColor: Color(0xFFeff1f5),
    shadowColor: Color(0xFFeff1f5));
