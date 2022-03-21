import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:vendor_app/modules/login/technician_login/index.dart';

class TechnicianLoginBloc extends Bloc<TechnicianLoginEvent, TechnicianLoginState> {

  TechnicianLoginBloc(TechnicianLoginState initialState) : super(initialState){
   on<TechnicianLoginEvent>((event, emit) {
      return emit.forEach<TechnicianLoginState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          developer.log('$error', name: 'TechnicianLoginBloc', error: error, stackTrace: stackTrace);
          return ErrorTechnicianLoginState(error.toString());
        },
      );
    });
  }
}
