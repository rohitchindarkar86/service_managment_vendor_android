import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:vendor_app/modules/payment/confirm_payment/index.dart';

class ConfirmPaymentBloc extends Bloc<ConfirmPaymentEvent, ConfirmPaymentState> {

  ConfirmPaymentBloc(ConfirmPaymentState initialState) : super(initialState){
   on<ConfirmPaymentEvent>((event, emit) {
      return emit.forEach<ConfirmPaymentState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          developer.log('$error', name: 'ConfirmPaymentBloc', error: error, stackTrace: stackTrace);
          return ErrorConfirmPaymentState(error.toString());
        },
      );
    });
  }
}
