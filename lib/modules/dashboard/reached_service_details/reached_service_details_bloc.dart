import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:vendor_app/modules/dashboard/reached_service_details/index.dart';

class ReachedServiceDetailsBloc extends Bloc<ReachedServiceDetailsEvent, ReachedServiceDetailsState> {

  ReachedServiceDetailsBloc(ReachedServiceDetailsState initialState) : super(initialState){
   on<ReachedServiceDetailsEvent>((event, emit) {
      return emit.forEach<ReachedServiceDetailsState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          developer.log('$error', name: 'ReachedServiceDetailsBloc', error: error, stackTrace: stackTrace);
          return ErrorReachedServiceDetailsState(error.toString());
        },
      );
    });
  }
}
