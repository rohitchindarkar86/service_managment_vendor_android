import 'package:flutter/material.dart';

import '../../models/profile/notification_list_model.dart';
import '../../style/style.dart';



class ItemNotificationServiceListWidget extends StatelessWidget{
  NotificationListModel notificationListModel;

  ItemNotificationServiceListWidget(this.notificationListModel, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.only(top: 8,left: 16,right: 16),
        color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 2,
          ),
          Text(notificationListModel.title,maxLines:3,style: TextStyle(fontFamily: Style().font_bold(),fontSize: 16,color: Theme.of(context).colorScheme.secondary),),
          const SizedBox(
            height: 4,
          ),
          Text(notificationListModel.body.toString().toUpperCase(),maxLines:3,style: TextStyle(fontFamily: Style().font_regular(),fontSize: 12,color: Theme.of(context).colorScheme.secondary),),
          const SizedBox(
            height: 16,
          ),
          Text(notificationListModel.time.toString().toUpperCase(),maxLines:1,style: TextStyle(fontFamily: Style().font_regular(),fontSize: 12,color:Colors.black38),),

          const SizedBox(
            height: 8,
          ),
        ],
      )


    );
  }
}