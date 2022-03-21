import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vendor_app/application_entry.dart';
import 'package:vendor_app/language/l10n.dart';
import 'package:vendor_app/utility/app_theme_handler/app_theme_handler.dart';

final AppThemeHandler appThemeHandler = AppThemeHandler();
Future<void> main() async{
  await application();
}


Future<void> application() async{
  await runZonedGuarded(() async{
    WidgetsFlutterBinding.ensureInitialized();

    await EasyLocalization.ensureInitialized();
    await Hive.initFlutter();
    await appThemeHandler.getApiLevel();

    runApp(EasyLocalization(
        child: EntryApplication('/splash'),
        supportedLocales: L10n.locales,
        fallbackLocale: L10n.locales.first,
        path: 'assets/translations')
    );
  } ,(error,stackTrace){

  });
}