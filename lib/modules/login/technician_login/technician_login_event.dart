import 'dart:async';
import 'dart:developer' as developer;

import 'package:vendor_app/modules/login/repository/login_repository.dart';
import 'package:vendor_app/modules/login/technician_login/index.dart';
import 'package:meta/meta.dart';

import '../../../models/apiResponseHandlerModel.dart';

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

class TechnicianApiLoginEvent extends TechnicianLoginEvent {

  String userName;
  String password;
  TechnicianApiLoginEvent(this.userName,this.password);
  @override
  Stream<TechnicianLoginState> applyAsync(
      {TechnicianLoginState? currentState, TechnicianLoginBloc? bloc}) async* {
    try {
      yield LoadingTechnicianLoginState();
      var body = {
        "UserName":userName,
        "Password":password
      };
      ApiResponseHandlerModel response = await LoginRepository.loginEvent(body);

      if(response.status == "S") {
        yield TechnicianLoginSuccessState(response.data.toString());
      }else{

      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadTechnicianLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorTechnicianLoginState( _.toString());
    }
  }
}


class ForgotPasswordApiLoginEvent extends TechnicianLoginEvent {

  String emailId;
  String password;
  ForgotPasswordApiLoginEvent(this.emailId,this.password);
  @override
  Stream<TechnicianLoginState> applyAsync(
      {TechnicianLoginState? currentState, TechnicianLoginBloc? bloc}) async* {
    try {
      yield LoadingTechnicianLoginState();
      var body = {
        "userName":emailId,
        "passwordOTP":password
      };
      ApiResponseHandlerModel response = await LoginRepository.forgotPasswordEvent(body);

      if(response.status == "S") {
        yield ForgotPasswordSuccessState(response.data.toString());
      }else{

      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadTechnicianLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorTechnicianLoginState( _.toString());
    }
  }
}
