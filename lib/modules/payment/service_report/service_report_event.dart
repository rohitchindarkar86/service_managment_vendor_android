import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:vendor_app/modules/payment/service_report/index.dart';
import 'package:meta/meta.dart';

import '../../../models/apiResponseHandlerModel.dart';
import '../../../models/master/action_taken_master_model.dart';
import '../../../models/master/spare_parts_master_model.dart';
import '../../dashboard/repository/service_repository.dart';
import '../../login/repository/master_repository.dart';
import '../repository/add_check_report_repository.dart';

@immutable
abstract class ServiceReportEvent {
  Stream<ServiceReportState> applyAsync(
      {ServiceReportState currentState, ServiceReportBloc bloc});
}

class UnServiceReportEvent extends ServiceReportEvent {
  @override
  Stream<ServiceReportState> applyAsync({ServiceReportState? currentState, ServiceReportBloc? bloc}) async* {
    yield UnServiceReportState();
  }
}

class LoadServiceReportEvent extends ServiceReportEvent {
   
  @override
  Stream<ServiceReportState> applyAsync(
      {ServiceReportState? currentState, ServiceReportBloc? bloc}) async* {
    try {
      yield UnServiceReportState();
      await Future.delayed(const Duration(seconds: 1));
      yield InServiceReportState('Hello world');
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadServiceReportEvent', error: _, stackTrace: stackTrace);
      yield ErrorServiceReportState( _.toString());
    }
  }
}

class ActionTakenMasterEvent extends ServiceReportEvent {

  int applianceCode;
  ActionTakenMasterEvent(this.applianceCode);
  @override
  Stream<ServiceReportState> applyAsync(
      {ServiceReportState? currentState, ServiceReportBloc? bloc}) async* {
    try {
      yield LoaderState();
      var body = {
        "masterDataName": "ServiceCheckReport",
        "applianceCode": applianceCode,
        "usePaging": false,
        "pageSize": 0,
        "currentIndex": 0
      };
      ApiResponseHandlerModel response = await MasterRepository.actionTakenEvent(body);

      if(response.status == 'S') {

        var jsonResponse = response.data;
        List<ActionTakenMasterModel> actionTakenMasterModel = actionTakenMasterModelFromJson(json.encode(jsonResponse));

        print("dsdf");
        yield ActionTakenState(actionTakenMasterModel);

      }else if(response.status == 'F'){

      }

    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadTechnicianLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorServiceReportState( _.toString());
    }
  }
}

class ActionMasterEvent extends ServiceReportEvent {

  int applianceCode;
  ActionMasterEvent(this.applianceCode);
  @override
  Stream<ServiceReportState> applyAsync(
      {ServiceReportState? currentState, ServiceReportBloc? bloc}) async* {
    try {
      yield LoaderState();
      var body = {
        "masterDataName": "ServiceAction",
        "applianceCode": applianceCode,
        "usePaging": false,
        "pageSize": 0,
        "currentIndex": 0
      };
      ApiResponseHandlerModel response = await MasterRepository.actionTakenEvent(body);

      if(response.status == 'S') {

        var jsonResponse = response.data;
        List<ActionTakenMasterModel> actionTakenMasterModel = actionTakenMasterModelFromJson(json.encode(jsonResponse));

        print("dsdf");
        yield ActionState(actionTakenMasterModel);

      }else if(response.status == 'F'){

      }

    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadTechnicianLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorServiceReportState( _.toString());
    }
  }
}

class PartsReplacedMasterEvent extends ServiceReportEvent {
  int applianceCode;
  PartsReplacedMasterEvent(this.applianceCode);
  @override
  Stream<ServiceReportState> applyAsync(
      {ServiceReportState? currentState, ServiceReportBloc? bloc}) async* {
    try {
      // yield LoaderState();
      var body = {
        "code": applianceCode
      };
      ApiResponseHandlerModel response = await MasterRepository.partsReplacedEvent(body);

      if(response.status == 'S') {

        var jsonResponse = response.data;
        List<SpareMasterModel> actionTakenMasterModel = spareMasterModelFromJson(json.encode(jsonResponse));

        print("dsdf");
        yield SparePartsState(actionTakenMasterModel);

      }else if(response.status == 'F'){

      }

    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadTechnicianLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorServiceReportState( _.toString());
    }
  }
}

class UpdateServiceCheckReportEvent extends ServiceReportEvent {

  int serviceRequestCode;
  int serviceRequestDetailCode;
  List<int>sparePartCodeList;
  UpdateServiceCheckReportEvent(this.serviceRequestCode,this.serviceRequestDetailCode,this.sparePartCodeList);
  @override
  Stream<ServiceReportState> applyAsync(
      {ServiceReportState? currentState, ServiceReportBloc? bloc}) async* {
    try {
      yield LoaderState();
      var body = {
        "serviceRequestCode": serviceRequestCode,
        "serviceRequestDetailCode": serviceRequestDetailCode,
        "checkReportCodeList": sparePartCodeList
      };
      ApiResponseHandlerModel response = await AddCheckReportRepository.updateServiceCheckReportEvent(body);

      if(response.status == 'S') {

        yield ActionTBTSuccessState();

      }else if(response.status == 'F'){
        yield ErrorServiceReportState(response.message);
      }

    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadTechnicianLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorServiceReportState( _.toString());
    }
  }
}

class UpdateActionEvent extends ServiceReportEvent {

  int serviceRequestCode;
  int serviceRequestDetailCode;
  List<int>sparePartCodeList;
  UpdateActionEvent(this.serviceRequestCode,this.serviceRequestDetailCode,this.sparePartCodeList);
  @override
  Stream<ServiceReportState> applyAsync(
      {ServiceReportState? currentState, ServiceReportBloc? bloc}) async* {
    try {
      yield LoaderState();
      var body = {
        "serviceRequestCode": serviceRequestCode,
        "serviceRequestDetailCode": serviceRequestDetailCode,
        "actionTakenCodeList": sparePartCodeList
      };
      ApiResponseHandlerModel response = await AddCheckReportRepository.updateActionEvent(body);

      if(response.status == 'S') {

        yield ActionSuccessState();

      }else if(response.status == 'F'){
        yield ErrorServiceReportState(response.message);
      }

    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadTechnicianLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorServiceReportState( _.toString());
    }
  }
}

class UpdateSparePartsEvent extends ServiceReportEvent {

  int serviceRequestCode;
  int serviceRequestDetailCode;
  List<int>sparePartCodeList;
  UpdateSparePartsEvent(this.serviceRequestCode,this.serviceRequestDetailCode,this.sparePartCodeList);
  @override
  Stream<ServiceReportState> applyAsync(
      {ServiceReportState? currentState, ServiceReportBloc? bloc}) async* {
    try {
      yield LoaderState();
      var body = {
        "serviceRequestCode": serviceRequestCode,
        "serviceRequestDetailCode": serviceRequestDetailCode,
        "sparePartCodeList": sparePartCodeList
      };
      ApiResponseHandlerModel response = await AddCheckReportRepository.updateSparePartsEvent(body);

      if(response.status == 'S') {

        yield SparePartsSuccessState();

      }else if(response.status == 'F'){
        yield ErrorServiceReportState(response.message);
      }

    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadTechnicianLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorServiceReportState( _.toString());
    }
  }
}

class UpdateServiceRequestEvent extends ServiceReportEvent {

  int serviceRequestCode;
  int statusCode;
  UpdateServiceRequestEvent(this.serviceRequestCode,this.statusCode);
  Stream<ServiceReportState> applyAsync(
      {ServiceReportState? currentState, ServiceReportBloc? bloc}) async* {
    try {
      ApiResponseHandlerModel response = await changeStatusApiCall(serviceRequestCode,statusCode);


      if(response.status == 'S') {
        // var jsonResponse = json.decode(response.data.toString());
        ApiResponseHandlerModel response1 = await changeStatusApiCall(serviceRequestCode,9);
        if(response1.status == 'S') {

          yield UpdateSuccessServiceStatusState(statusCode);
        } else if(response1.status == 'F'){
          yield ErrorServiceReportState( response1.message ??"Something went wrong please try after sometimes");
        }else{
          yield ErrorServiceReportState( "Something went wrong please try after sometimes");
        }

      } else if(response.status == 'F'){
        yield ErrorServiceReportState( response.message ??"Something went wrong please try after sometimes");
      }else{
        yield ErrorServiceReportState( "Something went wrong please try after sometimes");
      }

    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadTechnicianLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorServiceReportState( _.toString());
    }
  }

  changeStatusApiCall(serviceRequestCode,statusCode) async {
    var body = {
      // "code": userDetailsModel?.userCode
      "serviceRequestCode": serviceRequestCode,
      "statusCode": statusCode
    };
    ApiResponseHandlerModel response = await ServiceRepository.updateServiceRequestEvent(body);

    return response;
  }
}