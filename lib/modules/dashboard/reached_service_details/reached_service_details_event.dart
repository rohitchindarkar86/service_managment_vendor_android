import 'dart:async';
import 'dart:developer' as developer;

import 'package:vendor_app/modules/dashboard/reached_service_details/index.dart';
import 'package:meta/meta.dart';

import '../../../models/apiResponseHandlerModel.dart';
import '../repository/service_repository.dart';

@immutable
abstract class ReachedServiceDetailsEvent {
  Stream<ReachedServiceDetailsState> applyAsync(
      {ReachedServiceDetailsState currentState, ReachedServiceDetailsBloc bloc});
}

class UnReachedServiceDetailsEvent extends ReachedServiceDetailsEvent {
  @override
  Stream<ReachedServiceDetailsState> applyAsync({ReachedServiceDetailsState? currentState, ReachedServiceDetailsBloc? bloc}) async* {
    yield UnReachedServiceDetailsState();
  }
}

class LoadReachedServiceDetailsEvent extends ReachedServiceDetailsEvent {
   
  @override
  Stream<ReachedServiceDetailsState> applyAsync(
      {ReachedServiceDetailsState? currentState, ReachedServiceDetailsBloc? bloc}) async* {
    try {
      yield UnReachedServiceDetailsState();
      await Future.delayed(const Duration(seconds: 1));
      yield InReachedServiceDetailsState('Hello world');
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadReachedServiceDetailsEvent', error: _, stackTrace: stackTrace);
      yield ErrorReachedServiceDetailsState( _.toString());
    }
  }
}

class GetInventoryEvent extends ReachedServiceDetailsEvent {

  String qrString;
  GetInventoryEvent(this.qrString);

@override
Stream<ReachedServiceDetailsState> applyAsync(
    {ReachedServiceDetailsState? currentState, ReachedServiceDetailsBloc? bloc}) async* {
    try {

      // yield LoadingInventoryAddState(1);
      var bodyJson ={
        "param": qrString
      };


      ApiResponseHandlerModel response = await ServiceRepository.getInventoryRequestEvent(bodyJson);


      if(response.status == "S") {

      }else{

      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadTechnicianLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorReachedServiceDetailsState( _.toString());
    }
  }
}

class UpdateServiceRequestEvent extends ReachedServiceDetailsEvent {

  int? serviceRequestCode;
  int? statusCode;
  UpdateServiceRequestEvent(this.serviceRequestCode,this.statusCode);
  @override
  Stream<ReachedServiceDetailsState> applyAsync(
      {ReachedServiceDetailsState? currentState, ReachedServiceDetailsBloc? bloc}) async* {
    try {

      yield LoadingListDetailsState();
      var body = {
        // "code": userDetailsModel?.userCode
        "serviceRequestCode": serviceRequestCode,
        "statusCode": statusCode
      };
      ApiResponseHandlerModel response = await ServiceRepository.updateServiceRequestEvent(body);

      if(response.status == 'S') {
        // var jsonResponse = json.decode(response.data.toString());

        yield UpdateSuccessServiceDetailsState(response.data.toString());
      } else if(response.status == 'F'){
        yield UpdateErrorServiceDetailsState( response.message ??"Something went wrong please try after sometimes");
      }else{
        yield UpdateErrorServiceDetailsState( "Something went wrong please try after sometimes");
      }

    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadTechnicianLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorReachedServiceDetailsState( _.toString());
    }
  }
}