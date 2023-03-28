import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:vendor_app/modules/profile/notification/notification/index.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {

  NotificationBloc(NotificationState initialState) : super(initialState){
   on<NotificationEvent>((event, emit) {
      return emit.forEach<NotificationState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          developer.log('$error', name: 'NotificationBlocBloc', error: error, stackTrace: stackTrace);
          return ErrorNotificationState(error.toString());
        },
      );
    });
  }
}
