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

class LoadingInventoryAddState extends InventoryAddState {
  int indexLoader ;
  LoadingInventoryAddState(this.indexLoader);


  @override
  String toString() => 'LoadingInventoryAddState ';

}

class SuccessSubApplianceFetch extends InventoryAddState {
  SuccessSubApplianceFetch();

  @override
  String toString() => 'SuccessSubApplianceFetch';

}
class SuccessBrandFetch extends InventoryAddState {
  SuccessBrandFetch();

  @override
  String toString() => 'InventoryAddState';

}

class UnitQuantityFetch extends InventoryAddState {
  UnitQuantityFetch();

  @override
  String toString() => 'InventoryAddState';

}

class RefrigerantFetch extends InventoryAddState {
  RefrigerantFetch();

  @override
  String toString() => 'RefrigerantState';

}

class SuccessAddInventoryFetch extends InventoryAddState {
  SuccessAddInventoryFetch();

  @override
  String toString() => 'InventoryAddState';

}

class ErrorInventoryAddState extends InventoryAddState {
  ErrorInventoryAddState(this.errorMessage);
 
  final String errorMessage;
  
  @override
  String toString() => 'ErrorInventoryAddState';

  @override
  List<Object> get props => [errorMessage];
}
