import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:vendor_app/modules/payment/service_report/index.dart';
import 'package:meta/meta.dart';

import '../../../models/apiResponseHandlerModel.dart';
import '../../../models/master/action_taken_master_model.dart';
import '../../../models/master/spare_parts_master_model.dart';
import '../../login/repository/master_repository.dart';

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

  ActionTakenMasterEvent();
  @override
  Stream<ServiceReportState> applyAsync(
      {ServiceReportState? currentState, ServiceReportBloc? bloc}) async* {
    try {
      // yield LoadingDashboardState();
      var body = {
        "masterDataName": "ServiceComplaint",
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

class PartsReplacedMasterEvent extends ServiceReportEvent {

  PartsReplacedMasterEvent();
  @override
  Stream<ServiceReportState> applyAsync(
      {ServiceReportState? currentState, ServiceReportBloc? bloc}) async* {
    try {
      yield LoaderState();
      var body = {
        "code": 0
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

class AddPartsEvent extends ServiceReportEvent {

  int serviceRequestCode;
  int serviceRequestDetailCode;
  List<int>sparePartCodeList;
  AddPartsEvent(this.serviceRequestCode,this.serviceRequestDetailCode,this.sparePartCodeList);
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