import 'dart:async';
import 'dart:developer' as developer;

import 'package:vendor_app/modules/payment/confirm_payment/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ConfirmPaymentEvent {
  Stream<ConfirmPaymentState> applyAsync(
      {ConfirmPaymentState currentState, ConfirmPaymentBloc bloc});
}

class UnConfirmPaymentEvent extends ConfirmPaymentEvent {
  @override
  Stream<ConfirmPaymentState> applyAsync({ConfirmPaymentState? currentState, ConfirmPaymentBloc? bloc}) async* {
    yield UnConfirmPaymentState();
  }
}

class LoadConfirmPaymentEvent extends ConfirmPaymentEvent {
   
  @override
  Stream<ConfirmPaymentState> applyAsync(
      {ConfirmPaymentState? currentState, ConfirmPaymentBloc? bloc}) async* {
    try {
      yield UnConfirmPaymentState();
      await Future.delayed(const Duration(seconds: 1));
      yield InConfirmPaymentState('Hello world');
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadConfirmPaymentEvent', error: _, stackTrace: stackTrace);
      yield ErrorConfirmPaymentState( _.toString());
    }
  }
}
