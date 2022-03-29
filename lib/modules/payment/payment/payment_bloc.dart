import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:vendor_app/modules/payment/payment/index.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {

  PaymentBloc(PaymentState initialState) : super(initialState){
   on<PaymentEvent>((event, emit) {
      return emit.forEach<PaymentState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          developer.log('$error', name: 'PaymentBloc', error: error, stackTrace: stackTrace);
          return ErrorPaymentState(error.toString());
        },
      );
    });
  }
}
