import 'package:equatable/equatable.dart';

import '../../../models/service_request/service_list_model.dart';

abstract class DashboardState extends Equatable {
  DashboardState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnDashboardState extends DashboardState {

  UnDashboardState();

  @override
  String toString() => 'UnDashboardState';
}

/// Initialized
class InDashboardState extends DashboardState {
  InDashboardState(this.hello);
  
  final String hello;

  @override
  String toString() => 'InDashboardState $hello';

  @override
  List<Object> get props => [hello];
}

class LoadingDashboardState extends DashboardState {
  LoadingDashboardState();

  @override
  String toString() => 'LoadingDashboardState ';


}

class ErrorDashboardState extends DashboardState {
  ErrorDashboardState(this.errorMessage);
 
  final String errorMessage;
  
  @override
  String toString() => 'ErrorDashboardState';

}

class UserSuccessState extends DashboardState {
  UserSuccessState();

  @override
  String toString() => 'UserSuccessState';


}

class UserInvalidState extends DashboardState {
  UserInvalidState();


  @override
  String toString() => 'UserInvalidState';

  @override
  List<Object> get props => [];
}

class ServiceListingState extends DashboardState {
  List<ServiceListModel> serviceList=[];
  ServiceListingState(this.serviceList);

  @override
  String toString() => 'ServiceListingState';

}
