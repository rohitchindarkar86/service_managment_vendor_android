import 'dart:async';
import 'dart:developer' as developer;

import 'package:vendor_app/modules/dashboard/dashboard/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DashboardEvent {
  Stream<DashboardState> applyAsync(
      {DashboardState currentState, DashboardBloc bloc});
}

class UnDashboardEvent extends DashboardEvent {
  @override
  Stream<DashboardState> applyAsync({DashboardState? currentState, DashboardBloc? bloc}) async* {
    yield UnDashboardState();
  }
}

class LoadDashboardEvent extends DashboardEvent {
   
  @override
  Stream<DashboardState> applyAsync(
      {DashboardState? currentState, DashboardBloc? bloc}) async* {
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
