import 'package:equatable/equatable.dart';

abstract class ReachedServiceDetailsState extends Equatable {
  ReachedServiceDetailsState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnReachedServiceDetailsState extends ReachedServiceDetailsState {

  UnReachedServiceDetailsState();

  @override
  String toString() => 'UnReachedServiceDetailsState';
}

/// Initialized
class InReachedServiceDetailsState extends ReachedServiceDetailsState {
  InReachedServiceDetailsState(this.hello);
  
  final String hello;

  @override
  String toString() => 'InReachedServiceDetailsState $hello';

  @override
  List<Object> get props => [hello];
}

class ErrorReachedServiceDetailsState extends ReachedServiceDetailsState {
  ErrorReachedServiceDetailsState(this.errorMessage);
 
  final String errorMessage;
  
  @override
  String toString() => 'ErrorReachedServiceDetailsState';

  @override
  List<Object> get props => [errorMessage];
}

class UpdateSuccessServiceDetailsState extends ReachedServiceDetailsState {
  String successMsg;
  UpdateSuccessServiceDetailsState(this.successMsg);

  @override
  String toString() => 'UpdateSuccessServiceDetailsState';

}

class UpdateErrorServiceDetailsState extends ReachedServiceDetailsState {
  String errorMsg;
  UpdateErrorServiceDetailsState(this.errorMsg);

  @override
  String toString() => 'UpdateErrorServiceDetailsState';

}
class LoadingListDetailsState extends ReachedServiceDetailsState {

  LoadingListDetailsState();

  @override
  String toString() => 'LoadingListDetailsState';

}
