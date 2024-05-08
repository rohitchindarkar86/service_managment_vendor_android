import 'package:vendor_app/app_themes/custom_tab_underline_indicator.dart';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    visualDensity: VisualDensity(vertical: 0.5, horizontal: 0.5),
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

      //  UnderlineTabIndicator(
      //     borderSide: const BorderSide(
      //         width: 3.2, color: Color.fromARGB(255, 30, 146, 241))),
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: Colors.white,
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
        background: Color(0XFF172040),
        brightness: Brightness.dark,
        error: Colors.black,
        onBackground: Colors.white,
        onError: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        primary: Colors.blue,
        secondary: Color(0XFF172040),
        surface: Color(0XFF172040)),
    // primaryColorBrightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0XFF172040),
    textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: 20.0,
          fontFamily: "roboto_medium",
          color: Color(0XFFc7cbd5),
        ),
        headline1: TextStyle(
          fontFamily: "roboto_medium",
          fontSize: 20.0,
          color: Colors.white,
        ),
        headline3: TextStyle(
          fontSize: 14.0,
          fontFamily: "roboto_regular",
          color: Colors.white,
        )),
    backgroundColor: Color(0XFF172040),
    dividerColor: Color(0XFF303956),
    cardColor: Color(0xFF1c2754),
    hintColor: Color(0XFFc7cbd5),
    iconTheme: IconThemeData(color: Color(0XFFc7cbd5)),
    appBarTheme: AppBarTheme(
        backgroundColor: Color(0XFF172040),
        shadowColor: Colors.black12,
        elevation: 5.0,
        iconTheme: IconThemeData(color: Color(0XFFc7cbd5)),
        titleTextStyle: TextStyle(color: Colors.white)),
    buttonTheme: ButtonThemeData(buttonColor: Colors.blue),
    chipTheme: ChipThemeData(
      backgroundColor: Color(0XFF172040),
      brightness: Brightness.dark,
      disabledColor: Color(0XFF172040),
      labelStyle: TextStyle(
          fontSize: 14.0, fontFamily: "roboto_regular", color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      secondaryLabelStyle: TextStyle(
          fontSize: 14.0, fontFamily: "roboto_regular", color: Colors.white),
      secondarySelectedColor: Colors.blue,
      selectedColor: Colors.blue,
    ),
    shadowColor: Color(0xFF061034), bottomAppBarTheme: BottomAppBarTheme(color: Color(0xFF10131d)));
