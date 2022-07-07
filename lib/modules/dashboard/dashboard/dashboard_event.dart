import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor_app/modules/dashboard/dashboard/index.dart';
import 'package:meta/meta.dart';

import '../../../models/apiResponseHandlerModel.dart';
import '../../../models/login/user_details_model.dart';
import '../../login/repository/login_repository.dart';

@immutable
abstract class DashboardEvent {
  Stream<DashboardState> applyAsync(
      {DashboardState currentState, DashboardBloc bloc});
}

class UnDashboardEvent extends DashboardEvent {
  @override
  Stream<DashboardState> applyAsync({DashboardState? currentState, DashboardBloc? bloc}) async* {
    yield UnDashboardState();
  }
}

class LoadDashboardEvent extends DashboardEvent {
   
  @override
  Stream<DashboardState> applyAsync(
      {DashboardState? currentState, DashboardBloc? bloc}) async* {
    try {
      yield UnDashboardState();
      await Future.delayed(const Duration(seconds: 1));
      yield InDashboardState('Hello world');
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadDashboardEvent', error: _, stackTrace: stackTrace);
      yield ErrorDashboardState( _.toString());
    }
  }
}

class UserDetailsApiLoginEvent extends DashboardEvent {

  UserDetailsApiLoginEvent();
  @override
  Stream<DashboardState> applyAsync({DashboardState? currentState, DashboardBloc? bloc}) async* {
    try {
      SharedPreferences sharedPreferences;
      yield LoadingDashboardState();
      var body = {
      };
      ApiResponseHandlerModel response = await LoginRepository.userDetailsEvent(body);

      if(response.status == 'S') {
        // var jsonResponse = json.decode(response.data.toString());
        var jsonResponse = response.data;

        if(jsonResponse['userTypeCode'] ==3){
          UserDetailsModel userDetailsModel = UserDetailsModel.fromJson(jsonResponse);

          var body = {
            "hasFilters": true,
            "usePaging": true,
            "pageSize": 1,
            "currentIndex": 1,
            "userCodeList": [userDetailsModel.userCode],
            "vendorCodeList": [0]
          };
          ApiResponseHandlerModel response = await LoginRepository.technicianDetailsEvent(body);

          if(response.status == 'S') {

            var jsonResponse = response.data;
            print(jsonResponse[0]);
            sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.setString("userDetails",  json.encode(jsonResponse[0]));
            UserDetailsModel userDetailsModel1 = UserDetailsModel.fromJson(jsonResponse[0]);
            userDetailsModel1.addressLine_1 = userDetailsModel.addressLine_1;
            userDetailsModel1.addressLine_2 = userDetailsModel.addressLine_2;
            userDetailsModel1.addressZipCode = userDetailsModel.addressZipCode;
            setUserDetailsModel(userDetailsModel1);
            yield UserSuccessState();

          }else if(response.status == 'F'){

          }


        }else{
          yield UserInvalidState();
        }
      }else if(response.status == 'F'){

      }

    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadTechnicianLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorDashboardState( _.toString());
    }
  }
}

