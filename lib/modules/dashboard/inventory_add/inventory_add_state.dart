import 'package:equatable/equatable.dart';

abstract class InventoryAddState extends Equatable {
  InventoryAddState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnInventoryAddState extends InventoryAddState {

  UnInventoryAddState();

  @override
  String toString() => 'UnInventoryAddState';
}

/// Initialized
class InInventoryAddState extends InventoryAddState {
  InInventoryAddState(this.hello);
  
  final String hello;

  @override
  String toString() => 'InInventoryAddState $hello';

  @override
  List<Object> get props => [hello];
}

class ErrorInventoryAddState extends InventoryAddState {
  ErrorInventoryAddState(this.errorMessage);
 
  final String errorMessage;
  
  @override
  String toString() => 'ErrorInventoryAddState';

  @override
  List<Object> get props => [errorMessage];
}
