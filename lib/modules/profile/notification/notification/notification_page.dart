import 'package:flutter/material.dart';
import 'package:vendor_app/modules/profile/notification/notification/index.dart';

class NotificationPage extends StatefulWidget {
  static const String routeName = '/notification';

  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final _notificationBloc = NotificationBloc(UnNotificationState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationScreen(notificationBloc: _notificationBloc),
    );
  }
}
