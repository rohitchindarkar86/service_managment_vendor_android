import 'package:equatable/equatable.dart';

abstract class ConfirmPaymentState extends Equatable {
  ConfirmPaymentState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnConfirmPaymentState extends ConfirmPaymentState {

  UnConfirmPaymentState();

  @override
  String toString() => 'UnConfirmPaymentState';
}

/// Initialized
class InConfirmPaymentState extends ConfirmPaymentState {
  InConfirmPaymentState(this.hello);
  
  final String hello;

  @override
  String toString() => 'InConfirmPaymentState $hello';

  @override
  List<Object> get props => [hello];
}

class ErrorConfirmPaymentState extends ConfirmPaymentState {
  ErrorConfirmPaymentState(this.errorMessage);
 
  final String errorMessage;
  
  @override
  String toString() => 'ErrorConfirmPaymentState';

  @override
  List<Object> get props => [errorMessage];
}
