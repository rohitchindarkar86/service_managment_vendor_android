import 'package:equatable/equatable.dart';

abstract class OtpVerificationState extends Equatable {
  OtpVerificationState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnOtpVerificationState extends OtpVerificationState {

  UnOtpVerificationState();

  @override
  String toString() => 'UnOtpVerificationState';
}

/// Initialized
class InOtpVerificationState extends OtpVerificationState {
  InOtpVerificationState(this.hello);
  
  final String hello;

  @override
  String toString() => 'InOtpVerificationState $hello';

  @override
  List<Object> get props => [hello];
}

class ErrorOtpVerificationState extends OtpVerificationState {
  ErrorOtpVerificationState(this.errorMessage);
 
  final String errorMessage;
  
  @override
  String toString() => 'ErrorOtpVerificationState';

  @override
  List<Object> get props => [errorMessage];
}

class LoadingOtpVerificationState extends OtpVerificationState {
  LoadingOtpVerificationState();

  @override
  String toString() => 'LoadingOtpVerificationState';
}

class SuccessOtpVerificationState extends OtpVerificationState {
  String password;
  SuccessOtpVerificationState(this.password);

  @override
  String toString() => 'SuccessOtpVerificationState';
}
