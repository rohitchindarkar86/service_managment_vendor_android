import 'dart:async';
import 'dart:developer' as developer;

import 'package:vendor_app/modules/dashboard/inventory_add/index.dart';
import 'package:meta/meta.dart';

import '../../../models/add_inventory/add_inventory_model.dart';
import '../../../models/apiResponseHandlerModel.dart';
import '../../../models/login/user_details_model.dart';
import '../../../models/service_request/service_list_model.dart';
import '../../../utility/app_utility.dart';
import '../../login/repository/master_repository.dart';
import '../repository/service_repository.dart';

@immutable
abstract class InventoryAddEvent {
  Stream<InventoryAddState> applyAsync(
      {InventoryAddState currentState, InventoryAddBloc bloc});
}

class UnInventoryAddEvent extends InventoryAddEvent {
  @override
  Stream<InventoryAddState> applyAsync({InventoryAddState? currentState, InventoryAddBloc? bloc}) async* {
    yield UnInventoryAddState();
  }
}

class LoadInventoryAddEvent extends InventoryAddEvent {
   
  @override
  Stream<InventoryAddState> applyAsync(
      {InventoryAddState? currentState, InventoryAddBloc? bloc}) async* {
    try {
      yield UnInventoryAddState();
      await Future.delayed(const Duration(seconds: 1));
      yield InInventoryAddState('Hello world');
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadInventoryAddEvent', error: _, stackTrace: stackTrace);
      yield ErrorInventoryAddState( _.toString());
    }
  }
}

class ApplianceSubTypeEvent extends InventoryAddEvent {
  int applianceCode;
  ApplianceSubTypeEvent (this.applianceCode);
  @override
  Stream<InventoryAddState> applyAsync(
      {InventoryAddState? currentState, InventoryAddBloc? bloc}) async* {
    try {

      var bodyJson ={
        "code": applianceCode,
      };
      yield LoadingInventoryAddState(1);
      ApiResponseHandlerModel response = await MasterRepository.ApplianceSubTypeMasterList(bodyJson);

      if(response.status == "S") {
        yield SuccessSubApplianceFetch();
      }else{

      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadTechnicianLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorInventoryAddState( _.toString());
    }
  }
}

class BrandEvent extends InventoryAddEvent {
  BrandEvent ();
  @override
  Stream<InventoryAddState> applyAsync(
      {InventoryAddState? currentState, InventoryAddBloc? bloc}) async* {
    try {

      var bodyJson ={
        "masterDataName": "brand",
        "usePaging": false,
        "pageSize": 0,
        "currentIndex": 0
      };
      yield LoadingInventoryAddState(1);
      ApiResponseHandlerModel response = await MasterRepository.brandMasterList(bodyJson);

      if(response.status == "S") {
        yield SuccessBrandFetch();
      }else{

      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadTechnicianLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorInventoryAddState( _.toString());
    }
  }
}

class RefrigerantMasterEvent extends InventoryAddEvent {
  RefrigerantMasterEvent ();
  @override
  Stream<InventoryAddState> applyAsync(
      {InventoryAddState? currentState, InventoryAddBloc? bloc}) async* {
    try {

      var bodyJson ={
        "masterDataName": "Refrigerant",
        "usePaging": false,
        "pageSize": 0,
        "currentIndex": 0
      };
      yield LoadingInventoryAddState(1);
      ApiResponseHandlerModel response = await MasterRepository.refrigerantMasterList(bodyJson);

      if(response.status == "S") {
        yield RefrigerantFetch();
      }else{

      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadTechnicianLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorInventoryAddState( _.toString());
    }
  }
}

class UnitQuantityMasterEvent extends InventoryAddEvent {
  UnitQuantityMasterEvent ();
  @override
  Stream<InventoryAddState> applyAsync(
      {InventoryAddState? currentState, InventoryAddBloc? bloc}) async* {
    try {

      var bodyJson ={
        "masterDataName": "UnitQuantity",
        "usePaging": false,
        "pageSize": 0,
        "currentIndex": 0
      };
      yield LoadingInventoryAddState(1);
      ApiResponseHandlerModel response = await MasterRepository.UnitQtyMasterList(bodyJson);

      if(response.status == "S") {
        yield UnitQuantityFetch();
      }else{

      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadTechnicianLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorInventoryAddState( _.toString());
    }
  }
}

class AddInventoryEvent extends InventoryAddEvent {
  AddInventoryModel addInventoryModel = AddInventoryModel();
  ServiceListModel serviceListModel;
  AddInventoryEvent (this.addInventoryModel,this.serviceListModel);
  @override
  Stream<InventoryAddState> applyAsync(
      {InventoryAddState? currentState, InventoryAddBloc? bloc}) async* {
    try {

      yield LoadingInventoryAddState(1);
      var bodyJson ={
        "serviceRequestCode":serviceListModel.serviceRequestCode,
        "serviceRequestDetailCode":serviceListModel.serviceRequestDetailCode,
        "userApplianceCode":serviceListModel.userApplianceCode,
        "customerCode": addInventoryModel.customerCode,
        "applianceTypeCode": addInventoryModel.applianceTypeCode,
        "applianceSubTypeCode": addInventoryModel.applianceSubTypeCode,
        "unitQuantityCode": addInventoryModel.unitQuantityCode,
        "refrigerantCode": addInventoryModel.refrigerantCode,
        "modelNumber": addInventoryModel.modelNumber,
        "brandCode": addInventoryModel.brandCode,
        "baseWarrantyYears": addInventoryModel.baseWarrantyYears,
        "extendedWarrantyYears": addInventoryModel.extendedWarrantyYears,
        "applianceinWarranty": addInventoryModel.applianceinWarranty,
        "serialNumber": addInventoryModel.serialNumber,
        "serialNumber_2": addInventoryModel.serialNumber_2,
        "manufacturingDate": addInventoryModel.manufacturingDate,
        "userApplianceUniqueCode": addInventoryModel.userApplianceUniqueCode
      };
      // f3034500-3191-40d4-8ed2-75c79356f7a4

      ApiResponseHandlerModel response = await ServiceRepository.addInventoryRequestEvent(bodyJson);


      if(response.status == "S") {
        String keyTOSetData = userDetailsModel!.vendorUserCode.toString() +'_'+ addInventoryModel.serviceRequestCode.toString();
        AppUtility.insertToLocal(keyTOSetData,'Data Added to Inventory');
        yield SuccessAddInventoryFetch();
      }else{
        yield ErrorInventoryAddState(response.message);
      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadTechnicianLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorInventoryAddState( _.toString());
    }
  }
}
