import 'package:equatable/equatable.dart';

import '../../../models/master/action_taken_master_model.dart';
import '../../../models/master/spare_parts_master_model.dart';

abstract class ServiceReportState extends Equatable {
  ServiceReportState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnServiceReportState extends ServiceReportState {

  UnServiceReportState();

  @override
  String toString() => 'UnServiceReportState';
}

/// Initialized
class InServiceReportState extends ServiceReportState {
  InServiceReportState(this.hello);
  
  final String hello;

  @override
  String toString() => 'InServiceReportState $hello';

  @override
  List<Object> get props => [hello];
}

class ErrorServiceReportState extends ServiceReportState {
  ErrorServiceReportState(this.errorMessage);
 
  final String errorMessage;
  
  @override
  String toString() => 'ErrorServiceReportState';

  @override
  List<Object> get props => [errorMessage];
}

class CheckReportState extends ServiceReportState {
  List<ActionTakenMasterModel> checkReportMasterModel;
  CheckReportState(this.checkReportMasterModel);

}
class StatusState extends ServiceReportState {
  List<ActionTakenMasterModel> statusMasterModel;
  StatusState(this.statusMasterModel);

}
class SparePartsState extends ServiceReportState {
  List<SpareMasterModel> sparePartsMasterModel;
  SparePartsState(this.sparePartsMasterModel);

}

class ActionTBTSuccessState extends ServiceReportState {
  ActionTBTSuccessState();
}

class ActionSuccessState extends ServiceReportState {
  ActionSuccessState();
}

class SparePartsSuccessState extends ServiceReportState {
  SparePartsSuccessState();
}
class UpdateSuccessServiceStatusState extends ServiceReportState {
  int statusCode;
  UpdateSuccessServiceStatusState(this.statusCode);
}
class LoaderState extends ServiceReportState {
  LoaderState();
}

