import 'dart:async';
import 'dart:developer' as developer;

import 'package:vendor_app/modules/profile/view_profile/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ViewProfileEvent {
  Stream<ViewProfileState> applyAsync(
      {ViewProfileState currentState, ViewProfileBloc bloc});
}

class UnViewProfileEvent extends ViewProfileEvent {
  @override
  Stream<ViewProfileState> applyAsync({ViewProfileState? currentState, ViewProfileBloc? bloc}) async* {
    yield UnViewProfileState();
  }
}

class LoadViewProfileEvent extends ViewProfileEvent {
   
  @override
  Stream<ViewProfileState> applyAsync(
      {ViewProfileState? currentState, ViewProfileBloc? bloc}) async* {
    try {
      yield UnViewProfileState();
      await Future.delayed(const Duration(seconds: 1));
      yield InViewProfileState('Hello world');
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadViewProfileEvent', error: _, stackTrace: stackTrace);
      yield ErrorViewProfileState( _.toString());
    }
  }
}
