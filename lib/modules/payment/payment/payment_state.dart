import 'package:equatable/equatable.dart';

abstract class PaymentState extends Equatable {
  PaymentState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnPaymentState extends PaymentState {

  UnPaymentState();

  @override
  String toString() => 'UnPaymentState';
}

/// Initialized
class InPaymentState extends PaymentState {
  InPaymentState(this.hello);
  
  final String hello;

  @override
  String toString() => 'InPaymentState $hello';

  @override
  List<Object> get props => [hello];
}

class ErrorPaymentState extends PaymentState {
  ErrorPaymentState(this.errorMessage);
 
  final String errorMessage;
  
  @override
  String toString() => 'ErrorPaymentState';

  @override
  List<Object> get props => [errorMessage];
}
