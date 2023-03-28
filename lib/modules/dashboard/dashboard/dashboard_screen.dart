import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor_app/generated/locale_keys.g.dart';
import 'package:vendor_app/modules/dashboard/dashboard/index.dart';
import 'package:vendor_app/modules/profile/notification/notification/index.dart';
import 'package:vendor_app/style/style.dart';
import 'package:vendor_app/utility/app_utility.dart';
import 'package:vendor_app/utility/hex_color.dart';

import '../../../models/login/user_details_model.dart';
import '../../../models/service_request/service_list_model.dart';
import '../../../widgets/AppLoader.dart';
import '../../../widgets/LogoutOverlay.dart';
import '../../../widgets/dashboard/shimmer_service_listing_widget.dart';
import '../../profile/view_profile/view_profile_screen.dart';
import '../reached_service_details/reached_service_details_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    required DashboardBloc dashboardBloc,
    Key? key,
  })  : _dashboardBloc = dashboardBloc,
        super(key: key);

  final DashboardBloc _dashboardBloc;

  @override
  DashboardScreenState createState() {
    return DashboardScreenState();
  }
}

class DashboardScreenState extends State<DashboardScreen> {
  DashboardScreenState();

  double? height;

  bool isApiCall = true;
  bool isServiceLoader = true;
  SharedPreferences? sharedPreferences;

  String? techName="";
  List<ServiceListModel>? serviceList;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () => 100,).then((value) {
      AppUtility.appUpdateDialog(context: context);
    });
    _load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
        bloc: widget._dashboardBloc,
        listener: (Context, currentState) {
          if (currentState is UnDashboardState) {

          }
          if (currentState is LoadingDashboardState) {
            if(currentState.indexLoader == 0) {
              isApiCall = true;
            }else if(currentState.indexLoader == 1){
              isServiceLoader = true;
            }
          }
          if (currentState is UserInvalidState) {
              isApiCall = false;
              AppUtility.ShowToast(context, HexColor('ED8F2D').withOpacity(0.8),
                  'Invalid User.Please try with Technician Login', HexColor('FFFFFF'), 4);
              AppUtility.logoutUser(context);
          }

          if (currentState is UserSuccessState) {
            techName = (userDetailsModel?.technicianName)!;
            getUserData();
            isApiCall = false;
            widget._dashboardBloc.add(ServiceListEvent());
            widget._dashboardBloc.add(UpdateUserFCMEvent());
          }
          if (currentState is ServiceListingState) {
            isApiCall = false;
            isServiceLoader = false;
            serviceList = currentState.serviceList;
            serviceList = serviceList?.reversed.toList();
          }

          if (currentState is UpdateSuccessServiceState) {
            isApiCall = false;
            serviceList = null;
            widget._dashboardBloc.add(ServiceListEvent());
          }
          if (currentState is ErrorDashboardState) {
            isApiCall = false;

          }
          if (currentState is NoServiceRequestState) {
            serviceList =[];
            isServiceLoader = false;
          }
          if (currentState is InDashboardState) {

          }

        },
        builder: (
          BuildContext context,
          DashboardState currentState,
        ) {
          height = MediaQuery.of(context).size.height;
          return WillPopScope(
            onWillPop: () async {
              showDialog(
                context: context,
                builder: (_) => LogoutOverlay('Exit'),
              );
              return true;
            },
            child: Stack(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height:  height! *0.28,
                        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),

                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black54,
                                blurRadius: 15.0,
                                offset: Offset(0.0, 0.75)
                            )
                          ],
                          color: HexColor('ED8F2D'),
                        ),
                        child: SafeArea(
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 30,
                                alignment: Alignment.centerRight,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: GestureDetector(
                                          onTap: (){
                                            // AppUtility.logoutUser;
                                            showDialog(
                                              context: context,
                                              builder: (_) => LogoutOverlay('Logout'),
                                            );
                                          },
                                          child: Icon(Icons.logout,size: 25,color: Colors.white,)),
                                    ),
                                    IconButton(icon :new Icon(Icons.notifications_none_sharp),color: Colors.white, onPressed: () {
                                      Navigator.pushNamed(context, NotificationPage.routeName);
                                    },),
                                  ],
                                )

                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 85,
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(top: 8),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child:  Image.asset('assets/images/sample_img.png'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child:  RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '${techName}',
                                              style: TextStyle(fontFamily: Style().font_regular(),fontSize: 16,color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    RatingBar.builder(
                                      ignoreGestures:true,
                                      itemSize: 20,
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {

                                      },
                                    ),


                                  ],
                                ),
                              ),
                              Positioned(
                                  bottom: 4,
                                  right: 0,
                                  left: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child:  GestureDetector(
                                          onTap: (){
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                    transitionDuration: Duration(seconds: 1),
                                                    pageBuilder: (_, __, ___) => IdCardScreen()));
                                          },
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: '${LocaleKeys.DashboardIdBtnText.tr()}',
                                                  style: TextStyle(fontFamily: Style().font_regular(),fontSize: 14,color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Container(
                                      //   alignment: Alignment.centerRight,
                                      //   child:  GestureDetector(
                                      //     onTap: (){
                                      //       Navigator.pushNamed(context, ViewProfilePage.routeName);
                                      //     },
                                      //     child: RichText(
                                      //       textAlign: TextAlign.center,
                                      //       text: TextSpan(
                                      //         children: [
                                      //           TextSpan(
                                      //             text: '${LocaleKeys.DashboardViewProfileBtnText.tr()}',
                                      //             style: TextStyle(fontFamily: Style().font_regular(),fontSize: 14,color: Colors.white),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  )
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 0),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              alignment: Alignment.center,
                              child: Image.asset('assets/images/dashboard_comp__icon.png'),
                            ),
                            SizedBox(width: 6,),
                            Container(
                              alignment: Alignment.center,
                              child: Text('${LocaleKeys.DashboardTodaysComplaintText.tr()}',style: TextStyle(fontSize: 16,fontFamily: Style().font_regular(),color: HexColor('000000')),),
                            ),
                            Expanded(child: Container()),
                            Container(
                              alignment: Alignment.center,
                              child: Text(DateFormat('dd MMM yyy').format(DateTime.now()),style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('000000').withOpacity(0.5)),),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Expanded(
                        child: isServiceLoader ?ShimmerServiceWidget():serviceList != null && serviceList?.length !=0?Container(
                            child: RefreshIndicator(
                              child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemBuilder: complaintList,
                                itemCount: serviceList?.length ??0,
                              ),
                              onRefresh: () {
                                return Future.delayed(
                                  Duration(seconds: 1),
                                      () {
                                        widget._dashboardBloc.add(ServiceListEvent());


                                  },
                                );
                              },
                            ),
                          ):Center(child:Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('No Service Appoinments',style: TextStyle(
                                  fontFamily: Style().font_bold(),fontSize: 16,color: Colors.black
                              )),
                              SizedBox(height: 16,),
                              GestureDetector(
                                onTap: (){

                                  widget._dashboardBloc.add(ServiceListEvent());
                                },
                                child: Text('Click to Refresh',style: TextStyle(
                                  fontFamily: Style().font_regular(),fontSize: 14,color: Colors.blueAccent
                                ),),
                              )
                            ],
                          )
                         ),


                      ),

                    ],
                  )

                  ,
                ),
                isApiCall ? AppLoader() : Container(),
              ],
            )

          );
          
        });
  }

  Widget complaintList(BuildContext context, int index) {
    return Container(
      height: 255,
      margin: EdgeInsets.only(top: 0, right: 8, left: 8),
      child: GestureDetector(
        onTap: (){
            Navigator.pushNamed(context, ReachedServiceDetailsPage.routeName,arguments: {'selectedRequest':serviceList?[index]}).then((value) {
              if(value.toString() == 'updateList'){
                widget._dashboardBloc.add(ServiceListEvent());
              }
            });
        },
        child: Card(
          color: Colors.white,
          child: Container(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      color:  AppUtility.serviceColorPicker(serviceList?[index].serviceStatusSysCode) ,
                      height: 255,
                      width: 12,
                    ),
                  Expanded(child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8,vertical: 12),
                    child: Column(
                      children: [
                        Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${serviceList?[index].customerFirstName}  ${serviceList?[index].customerLastName}',
                                    style: TextStyle(fontSize: 14 ,fontFamily: Style().font_regular(),color: HexColor('#494949')  ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    // color: index ==  0?Colors.red.withOpacity(0.2): index ==  1? Colors.blue.withOpacity(0.2):HexColor('#18D184').withOpacity(0.2),
                                    color: AppUtility.serviceColorPicker(serviceList?[index].serviceStatusSysCode).withOpacity(0.2),
                                    borderRadius: BorderRadius.all( Radius.circular(5)),
                                  ),
                                  child: Text(
                                    '${serviceList?[index].serviceStatus}',
                                    style: TextStyle(fontSize: 14 ,fontFamily: Style().font_medium(),color:  AppUtility.serviceColorPicker(serviceList?[index].serviceStatusSysCode)  ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Container(
                          alignment:Alignment.centerLeft,
                          child: Text(
                            '${serviceList?[index].customerMobile} ',
                            style: TextStyle(fontSize: 14 ,fontFamily: Style().font_light(),color: HexColor('#494949')  ),
                          ) ,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          alignment:Alignment.centerLeft,
                          child: Text(
                            'Service No:- ${serviceList?[index].serviceRequestSeriesCode}',
                            style: TextStyle(fontSize: 14 ,fontFamily: Style().font_regular(),color: HexColor('#494949')  ),
                          ) ,
                        ),
                        Container(
                          alignment:Alignment.centerLeft,
                          child: Text(
                            'Service Date:-  ${serviceList?[index].scheduledTimeFrom} - ${serviceList?[index].scheduledTimeTill?.split(' ')[1].toString()}',
                            style: TextStyle(fontSize: 14 ,fontFamily: Style().font_regular(),color: HexColor('#494949')  ),
                          ) ,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          alignment:Alignment.centerLeft,
                          child: Text(
                            '${ serviceList?[index].userApplianceType}  ${serviceList?[index].serviceCategory}',
                            style: TextStyle(fontSize: 14 ,fontFamily: Style().font_regular(),color: HexColor('#494949')  ),
                          ) ,
                        ),
                        Container(
                          alignment:Alignment.centerLeft,
                          child: Text(
                            '${serviceList?[index].serviceComplaintCode?[0].description}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14 ,fontFamily: Style().font_light(),color: HexColor('000000')  ),
                          ) ,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  '${serviceList?[index].addressDetails } - ${serviceList?[index].pinCode }',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 14 ,fontFamily: Style().font_regular(),color: HexColor('#494949')  ),
                                ),
                              ),
                              SizedBox(width: 20,),

                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          width: MediaQuery.of(context).size.width,
                          child: serviceList?[index].serviceStatusSysCode == 2?  Container(
                            // width: MediaQuery.of(context).size.width,
                            height: 45,
                            margin: EdgeInsets.only(top: 6, left: 0, right: 0),
                            child: ElevatedButton(
                              child: Text('Attend This Service'),
                              onPressed: () {
                                int selectedService = serviceList?[index].serviceRequestCode ?? 0;
                                attendServiceBottomSheet(context: context,height: height! *0.35, serviceRequestCode: selectedService);
                              },
                              style: ElevatedButton.styleFrom(
                                  primary:  AppUtility.serviceColorPicker(serviceList?[index].serviceStatusSysCode),
                                  // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ):
                          serviceList?[index].serviceStatusSysCode == 3?  Container(
                            // width: MediaQuery.of(context).size.width,
                            height: 45,
                            margin: EdgeInsets.only(top: 0, left: 0, right: 0),
                            child: ElevatedButton(
                              child: Text('${LocaleKeys.DashboardReachLocationBtn.tr()}'),
                              onPressed: () {
                                int selectedService = serviceList?[index].serviceRequestCode ?? 0;
                                reachLocationBottomSheet(context: context,height: height! *0.35, serviceRequestCode: selectedService);
                              },
                              style: ElevatedButton.styleFrom(
                                  primary:  AppUtility.serviceColorPicker(serviceList?[index].serviceStatusSysCode),
                                  // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ):
                          serviceList?[index].serviceStatusSysCode == 4?  Container(
                            width: MediaQuery.of(context).size.width,
                            // height: 45,
                              margin: EdgeInsets.only(top: 0, left: 0, right: 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    child: Text(' Start Work '),
                                    onPressed: () {
                                      // int selectedService = serviceList?[index].serviceRequestCode ?? 0;
                                      // InProcessServiceBottomSheet(context: context,height: height! *0.4, serviceRequestCode: selectedService);
                                      Navigator.pushNamed(context, ReachedServiceDetailsPage.routeName,arguments: {'selectedRequest':serviceList?[index]}).then((value) {
                                        if(value.toString() == 'updateList'){
                                          widget._dashboardBloc.add(ServiceListEvent());
                                        }
                                      });

                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: HexColor('008d00'),
                                        // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                        textStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  ElevatedButton(
                                    child: Text('Cancel Work'),
                                    onPressed: () {
                                      int selectedService = serviceList?[index].serviceRequestCode ?? 0;
                                      cancelServiceBottomSheet(context: context,height: height! *0.4, serviceRequestCode: selectedService);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: HexColor('ea4747'),
                                        // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                        textStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              )
                          ):
                          Container(),
                        )
                      ],
                    ),
                  ))
                ]),
          ),
        ),
      ),
    );
  }

  reachLocationBottomSheet({
    required BuildContext context,
    required double height,
    required int serviceRequestCode,
  }) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Color(0xFF737373),
            child: Container(
                height: height,
                padding:
                EdgeInsets.only(left: 24, right: 20, top: 14, bottom: 0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      color: HexColor('#CED3DB'),
                      height: 4,
                      width: 64,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Container(
                        height: 100,
                        child: Lottie.asset('assets/lottie_anim/reach_location.json')),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        '${LocaleKeys.ReachLocationHeadingText.tr()}',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: Style().font_bold(),
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                    ),

                    SizedBox(
                      height: 36,
                    ),
                    Expanded(child: Container()),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: ElevatedButton(
                        child: Text('${LocaleKeys.ReachLocationReachedBtn.tr()}'),
                        onPressed: () {
                          Navigator.pop(context);
                          widget._dashboardBloc.add(UpdateServiceRequestEvent(serviceRequestCode,4));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: HexColor('ED8F2D'),
                            // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                            textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      alignment: Alignment.center,
                      child:
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Text('${LocaleKeys.ReachLocationCancelBtn.tr()}',style: TextStyle(fontFamily: Style().font_medium(),fontSize: 14,color: HexColor('252222').withOpacity(0.75)),)),
                    ),
                    SizedBox(
                      height: 8,
                    ),

                  ],
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                  ),
                )),
          );
        });
  }

  attendServiceBottomSheet({
    required BuildContext context,
    required double height,
    required int serviceRequestCode,
  }) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Color(0xFF737373),
            child: Container(
                height: height,
                padding:
                EdgeInsets.only(left: 24, right: 20, top: 14, bottom: 0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      color: HexColor('#CED3DB'),
                      height: 4,
                      width: 64,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Container(
                        height: 100,
                        child: Lottie.asset('assets/lottie_anim/reach_location.json')),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Attend This Service',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: Style().font_bold(),
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                    ),

                    SizedBox(
                      height: 36,
                    ),
                    Expanded(child: Container()),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: ElevatedButton(
                        child: Text('Attend This Service'),
                        onPressed: () {
                          Navigator.pop(context);
                          widget._dashboardBloc.add(UpdateServiceRequestEvent(serviceRequestCode,3));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: HexColor('ED8F2D'),
                            // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                            textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      alignment: Alignment.center,
                      child:
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Text('${LocaleKeys.ReachLocationCancelBtn.tr()}',style: TextStyle(fontFamily: Style().font_medium(),fontSize: 14,color: HexColor('252222').withOpacity(0.75)),)),
                    ),
                    SizedBox(
                      height: 8,
                    ),

                  ],
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                  ),
                )),
          );
        });
  }

  InProcessServiceBottomSheet({
    required BuildContext context,
    required double height,
    required int serviceRequestCode,
  }) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Color(0xFF737373),
            child: Container(
                height: height,
                padding:
                EdgeInsets.only(left: 24, right: 20, top: 14, bottom: 0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      color: HexColor('#CED3DB'),
                      height: 4,
                      width: 64,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Container(
                        height: 150,
                        child: Lottie.asset('assets/lottie_anim/start_work.json')),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Are you sure you want to Start the Work.',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: Style().font_bold(),
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                    ),

                    SizedBox(
                      height: 36,
                    ),
                    Expanded(child: Container()),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: ElevatedButton(
                        child: Text('Continue'),
                        onPressed: () {
                          Navigator.pop(context);
                          widget._dashboardBloc.add(UpdateServiceRequestEvent(serviceRequestCode,6));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: HexColor('ED8F2D'),
                            // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                            textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      alignment: Alignment.center,
                      child:
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Text('${LocaleKeys.ReachLocationCancelBtn.tr()}',style: TextStyle(fontFamily: Style().font_medium(),fontSize: 14,color: HexColor('252222').withOpacity(0.75)),)),
                    ),
                    SizedBox(
                      height: 8,
                    ),

                  ],
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                  ),
                )),
          );
        });
  }

  cancelServiceBottomSheet({
    required BuildContext context,
    required double height,
    required int serviceRequestCode,
  }) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Color(0xFF737373),
            child: Container(
                height: height,
                padding:
                EdgeInsets.only(left: 24, right: 20, top: 14, bottom: 0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      color: HexColor('#CED3DB'),
                      height: 4,
                      width: 64,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Container(
                        height: 150,
                        child: Lottie.asset('assets/lottie_anim/cancel_request.json')),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Are you sure you want to Cancel Service.',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: Style().font_bold(),
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                    ),

                    SizedBox(
                      height: 36,
                    ),
                    Expanded(child: Container()),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: ElevatedButton(
                        child: Text('Cancel Service'),
                        onPressed: () {
                          Navigator.pop(context);
                          widget._dashboardBloc.add(UpdateServiceRequestEvent(serviceRequestCode,5));
                        },
                        style: ElevatedButton.styleFrom(
                            primary:  HexColor('ea4747'),
                            // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                            textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      alignment: Alignment.center,
                      child:
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Text('${LocaleKeys.ReachLocationCancelBtn.tr()}',style: TextStyle(fontFamily: Style().font_medium(),fontSize: 14,color: HexColor('252222').withOpacity(0.75)),)),
                    ),
                    SizedBox(
                      height: 8,
                    ),

                  ],
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                  ),
                )),
          );
        });
  }

  Future<void> _load() async {
    sharedPreferences = await SharedPreferences.getInstance();
    try {
      if (sharedPreferences?.getString('userDetails') == null) {
        widget._dashboardBloc.add(UserDetailsApiLoginEvent());
      } else {
        String? jsonResponse = sharedPreferences?.getString("userDetails");
        var valueMap = json.decode(jsonResponse!);
        UserDetailsModel userDetailsModel = UserDetailsModel.fromJson(valueMap);
        setUserDetailsModel(userDetailsModel);
        techName = (userDetailsModel.technicianName)!;
        isApiCall = false;
        setState(() {

        });
        widget._dashboardBloc.add(ServiceListEvent());
        widget._dashboardBloc.add(UpdateUserFCMEvent());
      }
    }catch(e){
      print(e.toString());
    }

  }
  getUserData(){

  }
}
