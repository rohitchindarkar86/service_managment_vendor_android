import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendor_app/modules/profile/notification/notification/index.dart';

import '../../../../models/profile/notification_list_model.dart';
import '../../../../style/style.dart';
import '../../../../utility/hex_color.dart';
import '../../../../widgets/AppLoader.dart';
import '../../../../widgets/app_header.dart';
import '../../../../widgets/profile/itemNotificationListWidget.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({
    required NotificationBloc notificationBloc,
    Key? key,
  })  : _notificationBloc = notificationBloc,
        super(key: key);

  final NotificationBloc _notificationBloc;

  @override
  NotificationScreenState createState() {
    return NotificationScreenState();
  }
}

class NotificationScreenState extends State<NotificationScreen> {
  NotificationScreenState();


  bool appLoader =false;
  List<NotificationListModel>? userNotificationListModel=[];
  @override
  void initState() {
    super.initState();

    widget._notificationBloc.add(GetUserNotificationEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationBloc, NotificationState>(
        bloc: widget._notificationBloc,
        listener: (BuildContext context,
            NotificationState currentState,) {

          if(currentState is LoaderNotificationState){
            appLoader =true;
          }
          if(currentState is SuccessNotificationState){
            appLoader =false;
            userNotificationListModel = currentState.userNotificationListModel;
          }
        },
        builder: (BuildContext context,
            NotificationState currentState,) {
          return SafeArea(
            child: Container(
                color: HexColor('#F1F9FE'),
              padding: EdgeInsets.only(),
              child: Stack(
                children: [
                  Column(
                    children: <Widget>[
                      AppHeaderWidget('Notification',(){
                        Navigator.pop(context);}),
                      Expanded(child:
                        userNotificationListModel!.isNotEmpty ?
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index){
                            return ItemNotificationServiceListWidget(userNotificationListModel![index]);
                          },
                          itemCount: userNotificationListModel!.length,
                        )
                        :Center(
                          child:Text('No Notification',style: TextStyle(fontFamily: Style().font_bold(),fontSize: 14,color: Colors.black38),),)
                      )

                    ],
                  ),
                  appLoader ? AppLoader():Container()
                ],
              )

            ),
          );

  });
  }


}
