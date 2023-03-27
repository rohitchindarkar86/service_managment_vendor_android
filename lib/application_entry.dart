import 'dart:async';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:vendor_app/app_themes/dark_theme/dark_theme.dart';
import 'package:vendor_app/app_themes/light_theme/light_theme.dart';
import 'package:vendor_app/route_generator.dart';
import 'package:vendor_app/utility/app_theme_handler/app_theme_handler.dart';
import 'package:vendor_app/utility/custom_log_printer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vendor_app/utility/hex_color.dart';


class EntryApplication extends StatefulWidget {
  final String initialRoute;
  const  EntryApplication(this.initialRoute);

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
  void initState()  {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: "@mipmap/ic_launcher",
              ),
            ));
      }
  });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
          // context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            }, context: context);
      }
    });

    getToken();

        }
  String? token;
  getToken() async {
    token = (await FirebaseMessaging.instance.getToken())!;
    print("Token:- "+token.toString());
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
        // var themeMode;
        // themeMode = box.get("themeMode", defaultValue: true);
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
                    // themeMode: themeMode ? ThemeMode.light : ThemeMode.light,
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


  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    await setupFlutterNotifications();
    showFlutterNotification(message);
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    print('Handling a background message ${message.messageId}');
  }

  /// Create a [AndroidNotificationChannel] for heads up notifications
  late AndroidNotificationChannel channel;

  bool isFlutterLocalNotificationsInitialized = false;

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

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: '@drawable/ic_noti',
            color: HexColor('#F44336'),
          ),
        ),
      );
    }
  }

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  FlutterLocalNotificationsPlugin ?fltNotification;


}
