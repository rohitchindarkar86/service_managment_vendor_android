import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:vendor_app/modules/dashboard/inventory_add/index.dart';

class InventoryAddBloc extends Bloc<InventoryAddEvent, InventoryAddState> {

  InventoryAddBloc(InventoryAddState initialState) : super(initialState){
   on<InventoryAddEvent>((event, emit) {
      return emit.forEach<InventoryAddState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          developer.log('$error', name: 'InventoryAddBloc', error: error, stackTrace: stackTrace);
          return ErrorInventoryAddState(error.toString());
        },
      );
    });
  }
}
