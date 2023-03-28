// To parse this JSON data, do
//
//     final notificationListModel = notificationListModelFromJson(jsonString);

import 'dart:convert';

List<NotificationListModel> notificationListModelFromJson(String str) => List<NotificationListModel>.from(json.decode(str).map((x) => NotificationListModel.fromJson(x)));

String notificationListModelToJson(List<NotificationListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationListModel {
  NotificationListModel({
    required this.title,
    required this.body,
    required this.time,
  });

  String title;
  String body;
  String time;

  factory NotificationListModel.fromJson(Map<String, dynamic> json) => NotificationListModel(
    title: json["title"] ?? '',
    body: json["body"]?? '',
    time: json["time"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "body": body,
    "time": time,
  };
}
