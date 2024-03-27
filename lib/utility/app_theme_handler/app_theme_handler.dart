import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive_flutter/hive_flutter.dart';

const String THEME_PREF_STORAGE_BOX = "THEME_BOX";
var box;
class AppThemeHandler {
  int _androidSdkVersion=0;
  String _iosVersion='';

  AppThemeHandler() {

  }

  Future<void> getApiLevel() async {
    var isBoxExists = await Hive.boxExists(THEME_PREF_STORAGE_BOX);

    if (isBoxExists) {
      await Hive.openBox(THEME_PREF_STORAGE_BOX);
      box = Hive.box(THEME_PREF_STORAGE_BOX);
      await box.put(
          "themeMode",
          SchedulerBinding.instance.window.platformBrightness == Brightness.dark
              ? false
              : false);
      return;
    }
    await Hive.openBox(THEME_PREF_STORAGE_BOX);
    if (Platform.isAndroid) {

    } else if (Platform.isIOS) {

    }

    await _checkThemePref();
  }

  Future<void> _checkThemePref() async {
    if ((_androidSdkVersion >= 29) ||
        (_iosVersion.isNotEmpty &&
            double.parse(_iosVersion) >= 13.0)) {
       box = Hive.box(THEME_PREF_STORAGE_BOX);
      await box.put(
          "themeMode",
          SchedulerBinding.instance.window.platformBrightness == Brightness.dark
              ? false
              : false);
    }
  }
}
