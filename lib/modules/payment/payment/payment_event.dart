import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:vendor_app/modules/login/repository/master_repository.dart';
import 'package:vendor_app/modules/payment/payment/index.dart';
import 'package:meta/meta.dart';

import '../../../models/apiResponseHandlerModel.dart';
import '../../../models/master/action_taken_master_model.dart';

@immutable
abstract class PaymentEvent {
  Stream<PaymentState> applyAsync(
      {PaymentState currentState, PaymentBloc bloc});
}

class UnPaymentEvent extends PaymentEvent {
  @override
  Stream<PaymentState> applyAsync({PaymentState? currentState, PaymentBloc? bloc}) async* {
    yield UnPaymentState();
  }
}

class LoadPaymentEvent extends PaymentEvent {
   
  @override
  Stream<PaymentState> applyAsync(
      {PaymentState? currentState, PaymentBloc? bloc}) async* {
    try {
      yield UnPaymentState();
      await Future.delayed(const Duration(seconds: 1));
      yield InPaymentState('Hello world');
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadPaymentEvent', error: _, stackTrace: stackTrace);
      yield ErrorPaymentState( _.toString());
    }
  }
}



