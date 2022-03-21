import 'dart:async';
import 'dart:developer' as developer;

import 'package:vendor_app/modules/login/technician_login/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TechnicianLoginEvent {
  Stream<TechnicianLoginState> applyAsync(
      {TechnicianLoginState currentState, TechnicianLoginBloc bloc});
}

class UnTechnicianLoginEvent extends TechnicianLoginEvent {
  @override
  Stream<TechnicianLoginState> applyAsync({TechnicianLoginState? currentState, TechnicianLoginBloc? bloc}) async* {
    yield UnTechnicianLoginState();
  }
}

class LoadTechnicianLoginEvent extends TechnicianLoginEvent {
   
  @override
  Stream<TechnicianLoginState> applyAsync(
      {TechnicianLoginState? currentState, TechnicianLoginBloc? bloc}) async* {
    try {
      yield UnTechnicianLoginState();
      await Future.delayed(const Duration(seconds: 1));
      yield InTechnicianLoginState('Hello world');
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadTechnicianLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorTechnicianLoginState( _.toString());
    }
  }
}
