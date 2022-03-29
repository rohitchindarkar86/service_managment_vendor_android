import 'dart:async';
import 'dart:developer' as developer;

import 'package:vendor_app/modules/dashboard/reached_service_details/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ReachedServiceDetailsEvent {
  Stream<ReachedServiceDetailsState> applyAsync(
      {ReachedServiceDetailsState currentState, ReachedServiceDetailsBloc bloc});
}

class UnReachedServiceDetailsEvent extends ReachedServiceDetailsEvent {
  @override
  Stream<ReachedServiceDetailsState> applyAsync({ReachedServiceDetailsState? currentState, ReachedServiceDetailsBloc? bloc}) async* {
    yield UnReachedServiceDetailsState();
  }
}

class LoadReachedServiceDetailsEvent extends ReachedServiceDetailsEvent {
   
  @override
  Stream<ReachedServiceDetailsState> applyAsync(
      {ReachedServiceDetailsState? currentState, ReachedServiceDetailsBloc? bloc}) async* {
    try {
      yield UnReachedServiceDetailsState();
      await Future.delayed(const Duration(seconds: 1));
      yield InReachedServiceDetailsState('Hello world');
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadReachedServiceDetailsEvent', error: _, stackTrace: stackTrace);
      yield ErrorReachedServiceDetailsState( _.toString());
    }
  }
}
