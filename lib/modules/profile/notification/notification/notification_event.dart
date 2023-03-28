import 'dart:async';
import 'dart:developer' as developer;

import 'package:vendor_app/modules/login/repository/login_repository.dart';
import 'package:vendor_app/modules/profile/notification/notification/index.dart';
import 'package:meta/meta.dart';

import '../../../../models/apiResponseHandlerModel.dart';
import '../../../../models/login/user_details_model.dart';


@immutable
abstract class NotificationEvent {
  Stream<NotificationState> applyAsync(
      {NotificationState currentState, NotificationBloc bloc});
}

class UnNotificationEvent extends NotificationEvent {
  @override
  Stream<NotificationState> applyAsync({NotificationState? currentState, NotificationBloc? bloc}) async* {
    yield UnNotificationState();
  }
}

class LoadNotificationEvent extends NotificationEvent {
   
  @override
  Stream<NotificationState> applyAsync(
      {NotificationState? currentState, NotificationBloc? bloc}) async* {
    try {
      yield UnNotificationState();
      await Future.delayed(const Duration(seconds: 1));
      yield InNotificationState('Hello world');
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadChangePasswordEvent', error: _, stackTrace: stackTrace);
      yield ErrorNotificationState( _.toString());
    }
  }
}


class GetUserNotificationEvent extends NotificationEvent {

  GetUserNotificationEvent();

  @override
  Stream<NotificationState> applyAsync(
      {NotificationState? currentState, NotificationBloc? bloc}) async* {
    try {
      // yield LoadingMyAddressState(1);

      var body ={
        // "code":userDetailsModel?.userCode
        "code":1
      };

      ApiResponseHandlerModel response = await LoginRepository.getNotificationEvent(body);

      if(response.status == "S") {
        yield SuccessNotificationState(response.data);
      }if(response.status == "F"){
        if(response.message =="No Addresses Found for this User."){
          yield ErrorNotificationState(response.message);
        }
        // yield ErrorMessageState(response.message);
      }else {

      }

    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadChangePasswordEvent', error: _, stackTrace: stackTrace);
      yield ErrorNotificationState( _.toString());
    }
  }
}

