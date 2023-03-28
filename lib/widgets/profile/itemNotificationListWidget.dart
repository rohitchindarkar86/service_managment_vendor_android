import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/profile/notification_list_model.dart';
import '../../style/style.dart';



class ItemNotificationServiceListWidget extends StatelessWidget{
  NotificationListModel notificationListModel;

  ItemNotificationServiceListWidget(this.notificationListModel);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
        padding: const EdgeInsets.only(top: 8,left: 16,right: 16),
        color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 2,
          ),
          Container(child: Text('${notificationListModel.title}',maxLines:3,style: TextStyle(fontFamily: Style().font_bold(),fontSize: 16,color: Theme.of(context).colorScheme.secondary),)),
          SizedBox(
            height: 4,
          ),
          Container(child: Text('${notificationListModel.body.toString().toUpperCase()}',maxLines:3,style: TextStyle(fontFamily: Style().font_regular(),fontSize: 12,color: Theme.of(context).colorScheme.secondary),)),
          SizedBox(
            height: 16,
          ),
          Container(child: Text('${notificationListModel.time.toString().toUpperCase()}',maxLines:1,style: TextStyle(fontFamily: Style().font_regular(),fontSize: 12,color:Colors.black38),)),

          SizedBox(
            height: 8,
          ),
        ],
      )


    );
  }
}