import 'package:equatable/equatable.dart';

import '../../../models/master/action_taken_master_model.dart';

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

class UpdateRazaroPayState extends PaymentState {
  UpdateRazaroPayState(this.razorQRCode,this.razorQRCode_id);

  final String razorQRCode;
  final String razorQRCode_id;

  @override
  String toString() => 'ErrorPaymentState';
}

class PaymentCheckRazaroPayState extends PaymentState {
  PaymentCheckRazaroPayState(this.statusCode);

  final int statusCode;


  @override
  String toString() => 'ErrorPaymentState';
}

class LoaderPaymentState extends PaymentState {
  LoaderPaymentState();
  @override
  String toString() => 'ErrorPaymentState';

}

class UpdateSuccessServiceStatusState extends PaymentState {
  String successMsg;
  UpdateSuccessServiceStatusState(this.successMsg);

  @override
  String toString() => 'ServiceListingState';

}
class PaymentDetailsState extends PaymentState {
  var amountDetails;
  PaymentDetailsState(this.amountDetails);

  @override
  String toString() => 'PaymentDetailsState';

}

