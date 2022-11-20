import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor_app/modules/login/repository/master_repository.dart';
import 'package:vendor_app/modules/payment/payment/index.dart';
import 'package:meta/meta.dart';
import 'package:vendor_app/modules/payment/repository/payment_repository.dart';

import '../../../models/apiResponseHandlerModel.dart';
import '../../../models/master/action_taken_master_model.dart';

@immutable
abstract class PaymentEvent {
  Stream<PaymentState> applyAsync(
      {PaymentState currentState, PaymentBloc bloc});
}

class UnPaymentEvent extends PaymentEvent {
  @override
  Stream<PaymentState> applyAsync({PaymentState? currentState, PaymentBloc? bloc}) async* {
    yield UnPaymentState();
  }
}

class LoadPaymentEvent extends PaymentEvent {
   
  @override
  Stream<PaymentState> applyAsync(
      {PaymentState? currentState, PaymentBloc? bloc}) async* {
    try {
      yield UnPaymentState();
      await Future.delayed(const Duration(seconds: 1));
      yield InPaymentState('Hello world');
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadPaymentEvent', error: _, stackTrace: stackTrace);
      yield ErrorPaymentState( _.toString());
    }
  }
}

class PaymentGenerateRequestEvent extends PaymentEvent {

  int serviceRequestCode;
  int serviceRequestDetailsCode;
  String serviceRequestSeriesCode;
  int amount;
  PaymentGenerateRequestEvent(this.serviceRequestCode,this.serviceRequestDetailsCode,this.serviceRequestSeriesCode,this.amount);
  @override
  Stream<PaymentState> applyAsync(
      {PaymentState? currentState, PaymentBloc? bloc}) async* {
    try {
      yield LoaderPaymentState();

      var body = {
      "serviceRequestCode": serviceRequestCode,
      "serviceRequestDetailsCode": serviceRequestDetailsCode,
      "serviceRequestSeriesCode": serviceRequestSeriesCode,
    "payment_amount": (amount * 100)
    };
      ApiResponseHandlerModel response = await PaymentRepository.qrCodeGenerateEvent(body);

      if(response.status == 'S') {

        if(response.data['image_url'] != null ||response.data['image_url'] ==''){
          String razorQRCode =response.data['image_url'];
          String razorQRCode_id =response.data['id'];
          yield UpdateRazaroPayState(razorQRCode,razorQRCode_id);
        }else{
          yield ErrorPaymentState( response.message ??"Something went wrong please try after sometimes");
        }

      } else if(response.status == 'F'){
        yield ErrorPaymentState( response.message ??"Something went wrong please try after sometimes");
      }else{
        yield ErrorPaymentState( "Something went wrong please try after sometimes");
      }

    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadTechnicianLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorPaymentState( _.toString());
    }
  }
}
class PaymentCheckRequestEvent extends PaymentEvent {

  String qr_id;
  PaymentCheckRequestEvent(this.qr_id);
  @override
  Stream<PaymentState> applyAsync(
      {PaymentState? currentState, PaymentBloc? bloc}) async* {
    try {
      yield LoaderPaymentState();

      var body = {
      "param": qr_id
    };
      ApiResponseHandlerModel response = await PaymentRepository.qrCodeCheckEvent(body);

      if(response.status == 'S') {

          print(''+response.data.toString());

      } else if(response.status == 'F'){
        yield ErrorPaymentState( response.message ??"Something went wrong please try after sometimes");
      }else{
        yield ErrorPaymentState( "Something went wrong please try after sometimes");
      }

    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadTechnicianLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorPaymentState( _.toString());
    }
  }
}



