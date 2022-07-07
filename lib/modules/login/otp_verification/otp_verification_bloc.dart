import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:vendor_app/modules/login/otp_verification/index.dart';

class OtpVerificationBloc extends Bloc<OtpVerificationEvent, OtpVerificationState> {

  OtpVerificationBloc(OtpVerificationState initialState) : super(initialState){
   on<OtpVerificationEvent>((event, emit) {
      return emit.forEach<OtpVerificationState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          developer.log('$error', name: 'OtpVerificationBloc', error: error, stackTrace: stackTrace);
          return ErrorOtpVerificationState(error.toString());
        },
      );
    });
  }
}
