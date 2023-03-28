import 'package:equatable/equatable.dart';

import '../../../../models/profile/notification_list_model.dart';

abstract class NotificationState extends Equatable {
  NotificationState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnNotificationState extends NotificationState {

  UnNotificationState();

  @override
  String toString() => 'UnChangePasswordState';
}

/// Initialized
class InNotificationState extends NotificationState {
  InNotificationState(this.hello);
  
  final String hello;

  @override
  String toString() => 'InNotificationState $hello';

  @override
  List<Object> get props => [hello];
}

class LoaderNotificationState extends NotificationState {
  LoaderNotificationState();
  @override
  String toString() => 'LoaderChangePasswordState';
}

class SuccessNotificationState extends NotificationState {
  List<NotificationListModel> userNotificationListModel;
  SuccessNotificationState(this.userNotificationListModel);
  @override
  String toString() => 'SuccessNotificationState';
}


class ErrorNotificationState extends NotificationState {
  ErrorNotificationState(this.errorMessage);
 
  final String errorMessage;
  
  @override
  String toString() => 'ErrorChangePasswordState';

  @override
  List<Object> get props => [errorMessage];
}
