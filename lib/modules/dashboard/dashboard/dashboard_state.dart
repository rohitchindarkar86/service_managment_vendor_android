import 'package:equatable/equatable.dart';

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

class ErrorDashboardState extends DashboardState {
  ErrorDashboardState(this.errorMessage);
 
  final String errorMessage;
  
  @override
  String toString() => 'ErrorDashboardState';

  @override
  List<Object> get props => [errorMessage];
}
