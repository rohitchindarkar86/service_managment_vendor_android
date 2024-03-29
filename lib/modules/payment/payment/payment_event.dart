import 'dart:async';
import 'dart:developer' as developer;
import 'package:vendor_app/modules/payment/payment/index.dart';
import 'package:meta/meta.dart';
import 'package:vendor_app/modules/payment/repository/payment_repository.dart';
import '../../../models/apiResponseHandlerModel.dart';
import '../../../models/service_request/service_list_model.dart';
import '../../dashboard/repository/service_repository.dart';

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
  double amount;
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
  ServiceListModel serviceList;
  PaymentCheckRequestEvent(this.qr_id,this.serviceList);
  @override
  Stream<PaymentState> applyAsync(
      {PaymentState? currentState, PaymentBloc? bloc}) async* {
    try {
      yield LoaderPaymentState();

      var body = {
        "serviceRequestCode": serviceList.serviceRequestCode,
        "serviceRequestDetailsCode": serviceList.serviceRequestDetailCode,
        "serviceRequestSeriesCode": serviceList.serviceRequestSeriesCode
    };
      ApiResponseHandlerModel response = await PaymentRepository.qrCodeCheckEvent(body);

      if(response.status == 'S') {

          print(''+response.data.toString());
          yield PaymentCheckRazaroPayState(response.data['is_Success']);
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

class UpdateServiceRequestStatusEvent extends PaymentEvent {

  int serviceRequestCode;
  int statusCode;
  UpdateServiceRequestStatusEvent(this.serviceRequestCode,this.statusCode);
  @override
  Stream<PaymentState> applyAsync(
      {PaymentState? currentState, PaymentBloc? bloc}) async* {
    try {

      yield LoaderPaymentState();
      var body = {
        // "code": userDetailsModel?.userCode
        "serviceRequestCode": serviceRequestCode,
        "statusCode": statusCode
      };
      ApiResponseHandlerModel response = await ServiceRepository.updateServiceRequestEvent(body);

      if(response.status == 'S') {
        // var jsonResponse = json.decode(response.data.toString());

        yield UpdateSuccessServiceStatusState(response.data.toString());
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

class PaymentDetailsEvent extends PaymentEvent {

  ServiceListModel serviceList;
  PaymentDetailsEvent(this.serviceList);
  @override
  Stream<PaymentState> applyAsync(
      {PaymentState? currentState, PaymentBloc? bloc}) async* {
    try {

      yield LoaderPaymentState();
      var body = {
        "serviceRequestCode": serviceList.serviceRequestCode,
        "serviceRequestSeriesCode": serviceList.serviceRequestSeriesCode
      };
      ApiResponseHandlerModel response = await PaymentRepository.paymentDetailsEvent(body);

      if(response.status == 'S') {
        // var jsonResponse = json.decode(response.data.toString());
        if(response.data['isSuccess']){
          if(response.data['serviceStatusSysCode'] == 5){
            yield PaymentDetailsState(double.parse(response.data['partList'][0]['part_Price'].toString()));

          }
          yield PaymentDetailsState(double.parse(response.data['paymentAmount'].toString()));
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



