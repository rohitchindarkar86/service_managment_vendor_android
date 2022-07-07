import 'package:equatable/equatable.dart';

abstract class TechnicianLoginState extends Equatable {
  TechnicianLoginState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnTechnicianLoginState extends TechnicianLoginState {

  UnTechnicianLoginState();

  @override
  String toString() => 'UnTechnicianLoginState';
}

/// Initialized
class InTechnicianLoginState extends TechnicianLoginState {
  InTechnicianLoginState(this.hello);
  
  final String hello;

  @override
  String toString() => 'InTechnicianLoginState $hello';

  @override
  List<Object> get props => [hello];
}

class ErrorTechnicianLoginState extends TechnicianLoginState {
  ErrorTechnicianLoginState(this.errorMessage);
 
  final String errorMessage;
  
  @override
  String toString() => 'ErrorTechnicianLoginState';

  @override
  List<Object> get props => [errorMessage];
}

class LoadingTechnicianLoginState extends TechnicianLoginState {
  LoadingTechnicianLoginState();

  @override
  String toString() => 'LoadingTechnicianLoginState';

  @override
  List<Object> get props => [];
}
class TechnicianLoginSuccessState extends TechnicianLoginState {
  String data;
  TechnicianLoginSuccessState(this.data);

  @override
  String toString() => 'TechnicianLoginSuccessState';

  @override
  List<Object> get props => [];
}

class ForgotPasswordSuccessState extends TechnicianLoginState {
  String data;
  ForgotPasswordSuccessState(this.data);

  @override
  String toString() => 'TechnicianLoginSuccessState';

  @override
  List<Object> get props => [];
}

class TechnicianLoginErrorState extends TechnicianLoginState {
  String errorMsg;
  TechnicianLoginErrorState(this.errorMsg);

  @override
  String toString() => 'TechnicianLoginSuccessState';

  @override
  List<Object> get props => [];
}
