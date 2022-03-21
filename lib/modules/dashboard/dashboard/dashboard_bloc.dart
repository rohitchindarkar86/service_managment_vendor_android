import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:vendor_app/modules/dashboard/dashboard/index.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {

  DashboardBloc(DashboardState initialState) : super(initialState){
   on<DashboardEvent>((event, emit) {
      return emit.forEach<DashboardState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          developer.log('$error', name: 'DashboardBloc', error: error, stackTrace: stackTrace);
          return ErrorDashboardState(error.toString());
        },
      );
    });
  }
}
