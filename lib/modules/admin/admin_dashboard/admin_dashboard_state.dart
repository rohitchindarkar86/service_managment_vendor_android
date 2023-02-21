import 'package:equatable/equatable.dart';

import '../../../models/service_request/service_list_model.dart';

abstract class AdminDashboardState extends Equatable {
  AdminDashboardState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnDashboardState extends AdminDashboardState {

  UnDashboardState();

  @override
  String toString() => 'UnDashboardState';
}

/// Initialized
class InDashboardState extends AdminDashboardState {
  InDashboardState(this.hello);
  
  final String hello;

  @override
  String toString() => 'InDashboardState $hello';

  @override
  List<Object> get props => [hello];
}

class LoadingDashboardState extends AdminDashboardState {
  int indexLoader;
  LoadingDashboardState(this.indexLoader);

  @override
  String toString() => 'LoadingDashboardState ';


}

class GeneratedQrState extends AdminDashboardState {
  GeneratedQrState(this.pdfPath);

  String pdfPath;

  @override
  String toString() => 'GeneratedQrState';

}
class ErrorDashboardState extends AdminDashboardState {
  ErrorDashboardState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorDashboardState';

}

