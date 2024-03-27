import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vendor_app/application_entry.dart';
import 'package:vendor_app/language/l10n.dart';
import 'package:vendor_app/utility/app_constant.dart';
import 'package:vendor_app/utility/app_theme_handler/app_theme_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:package_info_plus/package_info_plus.dart';


final AppThemeHandler appThemeHandler = AppThemeHandler();
 AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.high,
  description: 'This channel is used for important notifications.'
);
 FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
bool isFlutterLocalNotificationsInitialized = false;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  _initConfig();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.instance.getToken().then((token){
    AppConstant.fcmTokken = token!;
  });

  await application();
}


Future<void> application() async{
  await runZonedGuarded(() async{
    WidgetsFlutterBinding.ensureInitialized();
    ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
    SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
    await EasyLocalization.ensureInitialized();
    await Hive.initFlutter();
    await appThemeHandler.getApiLevel();

    runApp(EasyLocalization(
        child: const EntryApplication('/splash'),
        supportedLocales: L10n.locales,
        fallbackLocale: L10n.locales.first,
        path: 'assets/translations')
    );
  } ,(error,stackTrace){

  });
}
final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

Future<void> _initConfig() async {
  await _remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(
        seconds: 1), // a fetch will wait up to 10 seconds before timing out
    minimumFetchInterval: const Duration(
        seconds:
        10), // fetch parameters will be cached for a maximum of 1 hour
  ));

  _fetchConfig();
}

// Fetching, caching, and activating remote config
void _fetchConfig() async {
  // PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //
  //
  // AppConstant.remoteConfigAppVersionCode = int.parse(packageInfo.buildNumber);
  // AppConstant.appVersionCode = int.parse(packageInfo.buildNumber);
  //
  // await _remoteConfig.fetchAndActivate();
  // AppConstant.remoteConfigAppVersionCode = _remoteConfig.getInt('app_version_code');
  // AppConstant.isForceUpdate = _remoteConfig.getBool('is_force_update');

}
