import 'dart:async';
import 'dart:developer' as developer;

import 'package:vendor_app/modules/dashboard/inventory_add/index.dart';
import 'package:meta/meta.dart';

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
