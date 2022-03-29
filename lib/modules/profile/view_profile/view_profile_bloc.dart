import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:vendor_app/modules/profile/view_profile/index.dart';

class ViewProfileBloc extends Bloc<ViewProfileEvent, ViewProfileState> {

  ViewProfileBloc(ViewProfileState initialState) : super(initialState){
   on<ViewProfileEvent>((event, emit) {
      return emit.forEach<ViewProfileState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          developer.log('$error', name: 'ViewProfileBloc', error: error, stackTrace: stackTrace);
          return ErrorViewProfileState(error.toString());
        },
      );
    });
  }
}
