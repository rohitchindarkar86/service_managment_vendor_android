import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:vendor_app/modules/payment/service_report/index.dart';
import 'package:meta/meta.dart';

import '../../../models/apiResponseHandlerModel.dart';
import '../../../models/master/action_taken_master_model.dart';
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