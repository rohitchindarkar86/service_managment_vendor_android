import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:vendor_app/modules/payment/service_report/index.dart';

class ServiceReportBloc extends Bloc<ServiceReportEvent, ServiceReportState> {

  ServiceReportBloc(ServiceReportState initialState) : super(initialState){
   on<ServiceReportEvent>((event, emit) {
      return emit.forEach<ServiceReportState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          developer.log('$error', name: 'ServiceReportBloc', error: error, stackTrace: stackTrace);
          return ErrorServiceReportState(error.toString());
        },
      );
    });
  }
}
