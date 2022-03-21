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
