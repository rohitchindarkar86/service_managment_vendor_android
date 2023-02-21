import 'dart:async';
import 'dart:developer' as developer;
import 'package:vendor_app/modules/admin/admin_dashboard/admin_dashboard_bloc.dart';
import 'package:vendor_app/modules/admin/admin_dashboard/admin_dashboard_state.dart';
import 'package:vendor_app/modules/admin/admin_dashboard/index.dart';
import 'package:meta/meta.dart';



@immutable
abstract class AdminDashboardEvent {
  Stream<AdminDashboardState> applyAsync(
      {AdminDashboardState currentState, AdminDashboardBloc bloc});
}

class UnDashboardEvent extends AdminDashboardEvent {
  @override
  Stream<AdminDashboardState> applyAsync({AdminDashboardState? currentState, AdminDashboardBloc? bloc}) async* {
    yield UnDashboardState();
  }
}

class LoadDashboardEvent extends AdminDashboardEvent {
   
  @override
  Stream<AdminDashboardState> applyAsync(
      {AdminDashboardState? currentState, AdminDashboardBloc? bloc}) async* {
    try {
      yield UnDashboardState();
      await Future.delayed(const Duration(seconds: 1));
      yield InDashboardState('Hello world');
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadDashboardEvent', error: _, stackTrace: stackTrace);
      yield ErrorDashboardState( _.toString());
    }
  }
}




