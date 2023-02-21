import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:vendor_app/modules/admin/admin_dashboard/admin_dashboard_event.dart';
import 'package:vendor_app/modules/admin/admin_dashboard/admin_dashboard_state.dart';


class AdminDashboardBloc extends Bloc<AdminDashboardEvent, AdminDashboardState> {

  AdminDashboardBloc(AdminDashboardState initialState) : super(initialState){
   on<AdminDashboardEvent>((event, emit) {
      return emit.forEach<AdminDashboardState>(
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
