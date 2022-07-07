import 'dart:async';
import 'dart:developer' as developer;

import 'package:vendor_app/modules/login/otp_verification/index.dart';
import 'package:meta/meta.dart';

import '../../../models/apiResponseHandlerModel.dart';
import '../repository/login_repository.dart';

@immutable
abstract class OtpVerificationEvent {
  Stream<OtpVerificationState> applyAsync(
      {OtpVerificationState currentState, OtpVerificationBloc bloc});
}

class UnOtpVerificationEvent extends OtpVerificationEvent {
  @override
  Stream<OtpVerificationState> applyAsync({OtpVerificationState? currentState, OtpVerificationBloc? bloc}) async* {
    yield UnOtpVerificationState();
  }
}

class LoadOtpVerificationEvent extends OtpVerificationEvent {
   
  @override
  Stream<OtpVerificationState> applyAsync(
      {OtpVerificationState? currentState, OtpVerificationBloc? bloc}) async* {
    try {
      yield UnOtpVerificationState();
      await Future.delayed(const Duration(seconds: 1));
      yield InOtpVerificationState('Hello world');
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadOtpVerificationEvent', error: _, stackTrace: stackTrace);
      yield ErrorOtpVerificationState( _.toString());
    }
  }
}

class GetOtpApiLoginEvent extends OtpVerificationEvent {

  String emailId;
  String otp;
  GetOtpApiLoginEvent(this.emailId,this.otp);
  @override
  Stream<OtpVerificationState> applyAsync(
      {OtpVerificationState? currentState, OtpVerificationBloc? bloc}) async* {
    try {
      yield LoadingOtpVerificationState();
      var body = {
        "userName":emailId,
        "passwordOTP":otp
      };
      ApiResponseHandlerModel response = await LoginRepository.getPasswordEvent(body);

      if(response.status =="S"){
        yield SuccessOtpVerificationState(response.data.toString());
      }

    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadTechnicianLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorOtpVerificationState( _.toString());
    }
  }
}
