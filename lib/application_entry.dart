import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vendor_app/app_themes/dark_theme/dark_theme.dart';
import 'package:vendor_app/app_themes/light_theme/light_theme.dart';
import 'package:vendor_app/route_generator.dart';
import 'package:vendor_app/utility/app_theme_handler/app_theme_handler.dart';
import 'package:vendor_app/utility/custom_log_printer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';


class EntryApplication extends StatefulWidget {
  final String initialRoute;
  const EntryApplication(this.initialRoute);

  @override
  _EntryApplicationState createState() {
    return _EntryApplicationState(this.initialRoute);
  }
}

class _EntryApplicationState extends State<EntryApplication>
    with WidgetsBindingObserver {
  String initialRoute;
  _EntryApplicationState(this.initialRoute);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);

  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return ValueListenableBuilder(
      valueListenable: Hive.box(THEME_PREF_STORAGE_BOX).listenable(),
      builder: (context, box1, widget) {
        var themeMode;
        themeMode = box.get("themeMode", defaultValue: true);
        return Material(
          child: Directionality(
            textDirection: ui.TextDirection.ltr,
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    initialRoute: this.initialRoute,
                    onGenerateRoute: RouteGenerator.generateRoute,
                    themeMode: themeMode ? ThemeMode.light : ThemeMode.light,
                    theme: lightTheme,
                    darkTheme: darkTheme,
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        CustomLogPrinter.printDebugLog('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        if (kReleaseMode)
        CustomLogPrinter.printDebugLog('appLifeCycleState resumed');
        break;
      case AppLifecycleState.paused:
        CustomLogPrinter.printDebugLog('appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
        CustomLogPrinter.printDebugLog('appLifeCycleState detached');
        break;
    }
  }


}
