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
//Check Report Master Data
class CheckReportsMasterEvent extends ServiceReportEvent {

  int applianceCode;
  CheckReportsMasterEvent(this.applianceCode);
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

        yield CheckReportState(actionTakenMasterModel);

      }else if(response.status == 'F'){

      }

    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadTechnicianLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorServiceReportState( _.toString());
    }
  }
}
//Action Taken i.e Part price Master Data
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
        List<SpareMasterModel> actionTakenMasterModel = [];
        try {
         actionTakenMasterModel = spareMasterModelFromJson(
              json.encode(jsonResponse));
          yield SparePartsState(actionTakenMasterModel);
        }catch(e){
          yield SparePartsState(actionTakenMasterModel);

        }

      }else if(response.status == 'F'){

      }

    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadTechnicianLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorServiceReportState( _.toString());
    }
  }
}
//Status Data
class StatusMasterEvent extends ServiceReportEvent {

  StatusMasterEvent();
  @override
  Stream<ServiceReportState> applyAsync(
      {ServiceReportState? currentState, ServiceReportBloc? bloc}) async* {
    try {
      // yield LoaderState();

        var response = [
          {
            "key": 7,
            "value": "SVCPFR",
            "description": "Service Pending For Repairs"
          },
          {
            "key": 8,
            "value": "SVCPFP",
            "description": "Service Pending For Parts"
          },{
            "key": 9,
            "value": "SVCPFP",
            "description": "Service Complete"
          },
        ];
        var jsonResponse = response;
        List<ActionTakenMasterModel> statusMasterModel = actionTakenMasterModelFromJson(json.encode(jsonResponse));
        yield StatusState(statusMasterModel);

    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadTechnicianLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorServiceReportState( _.toString());
    }
  }
}

//Check Report Update
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

//Update Spare Parts / Action Taken
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

//Update Status
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
        yield UpdateSuccessServiceStatusState(statusCode);

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