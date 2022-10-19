import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:vendor_app/modules/dashboard/inventory_add/index.dart';
import 'package:meta/meta.dart';

import '../../../models/add_inventory/add_inventory_model.dart';
import '../../../models/apiResponseHandlerModel.dart';
import '../../../models/login/user_details_model.dart';
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

class AddInventoryEvent extends InventoryAddEvent {
  AddInventoryModel addInventoryModel = AddInventoryModel();
  AddInventoryEvent (this.addInventoryModel);
  @override
  Stream<InventoryAddState> applyAsync(
      {InventoryAddState? currentState, InventoryAddBloc? bloc}) async* {
    try {

      yield LoadingInventoryAddState(1);
      var bodyJson ={
        "customerCode": addInventoryModel.customerCode,
        "applianceTypeCode": addInventoryModel.applianceTypeCode,
        "brandCode": addInventoryModel.brandCode,
        "baseWarrantyYears": addInventoryModel.baseWarrantyYears,
        "extendedWarrantyYears": addInventoryModel.extendedWarrantyYears,
        "applianceinWarranty": addInventoryModel.applianceinWarranty,
        "serialNumber": addInventoryModel.serialNumber,
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

      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadTechnicianLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorInventoryAddState( _.toString());
    }
  }
}
