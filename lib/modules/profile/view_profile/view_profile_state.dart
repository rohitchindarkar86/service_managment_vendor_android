import 'package:equatable/equatable.dart';

abstract class ViewProfileState extends Equatable {
  ViewProfileState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnViewProfileState extends ViewProfileState {

  UnViewProfileState();

  @override
  String toString() => 'UnViewProfileState';
}

/// Initialized
class InViewProfileState extends ViewProfileState {
  InViewProfileState(this.hello);
  
  final String hello;

  @override
  String toString() => 'InViewProfileState $hello';

  @override
  List<Object> get props => [hello];
}

class ErrorViewProfileState extends ViewProfileState {
  ErrorViewProfileState(this.errorMessage);
 
  final String errorMessage;
  
  @override
  String toString() => 'ErrorViewProfileState';

  @override
  List<Object> get props => [errorMessage];
}
