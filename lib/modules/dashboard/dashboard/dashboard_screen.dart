import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor_app/generated/locale_keys.g.dart';
import 'package:vendor_app/modules/dashboard/dashboard/index.dart';
import 'package:vendor_app/style/style.dart';
import 'package:vendor_app/utility/hex_color.dart';

import '../../../widgets/LogoutOverlay.dart';
import '../../profile/view_profile/view_profile_page.dart';
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

  @override
  void initState() {
    super.initState();
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
          if (currentState is ErrorDashboardState) {

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
                builder: (_) => LogoutOverlay(),
              );
              return true;
            },
            child: Container(
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
                            child: Icon(Icons.notifications_none_sharp,size: 25,color: Colors.white,),
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
                                          text: 'Kashinath Pawar',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                Container(
                                  alignment: Alignment.centerRight,
                                  child:  GestureDetector(
                                    onTap: (){
                                      Navigator.pushNamed(context, ViewProfilePage.routeName);
                                    },
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '${LocaleKeys.DashboardViewProfileBtnText.tr()}',
                                            style: TextStyle(fontFamily: Style().font_regular(),fontSize: 14,color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
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
                          child: Text('Friday 18 Mar,2022',style: TextStyle(fontSize: 14,fontFamily: Style().font_regular(),color: HexColor('000000').withOpacity(0.5)),),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: complaintList,
                        itemCount: 2,
                      ),
                    ),
                  ),

                ],
              )

              ,
            ),
          );
          
        });
  }

  Widget complaintList(BuildContext context, int index) {
    return Container(
      height: 185,
      margin: EdgeInsets.only(top: 0, right: 8, left: 8),
      child: GestureDetector(
        onTap: (){
          if(index ==  0 ){
            Navigator.pushNamed(context, ReachedServiceDetailsPage.routeName);
          }
        },
        child: Card(
          color: Colors.white,
          child: Container(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      color: index ==  0?Colors.red:Colors.green,
                      height: 185,
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
                                Text(
                                  'Amit Rane',
                                  style: TextStyle(fontSize: 14 ,fontFamily: Style().font_regular(),color: HexColor('#494949')  ),
                                ),
                                Text(
                                  index ==  0?'On Going': 'OPEN',
                                  style: TextStyle(fontSize: 14 ,fontFamily: Style().font_medium(),color:  index ==  0?Colors.red: HexColor('#18D184')  ),
                                ),
                              ],
                            ),
                          ),
                        Container(
                          alignment:Alignment.centerLeft,
                          child: Text(
                            '+91 9987956807',
                            style: TextStyle(fontSize: 14 ,fontFamily: Style().font_light(),color: HexColor('#494949')  ),
                          ) ,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          alignment:Alignment.centerLeft,
                          child: Text(
                            'AC NOT WORKING',
                            style: TextStyle(fontSize: 14 ,fontFamily: Style().font_regular(),color: HexColor('#494949')  ),
                          ) ,
                        ),
                        Container(
                          alignment:Alignment.centerLeft,
                          child: Text(
                            'Fan and Cooling not happening',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14 ,fontFamily: Style().font_light(),color: HexColor('#494949')  ),
                          ) ,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  '12/ 1301 Mira Apartment  lokhandwalAndheri Mumbai- 40043',
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 14 ,fontFamily: Style().font_regular(),color: HexColor('#494949')  ),
                                ),
                              ),
                              SizedBox(width: 20,),
                            index != 0?  Container(
                                // width: MediaQuery.of(context).size.width,
                                height: 45,
                                margin: EdgeInsets.only(top: 0, left: 0, right: 0),
                                child: ElevatedButton(
                                  child: Text('${LocaleKeys.DashboardReachLocationBtn.tr()}'),
                                  onPressed: () {

                                    reachLocationBottomSheet(context: context,height: height! *0.35);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: HexColor('ED8F2D'),
                                      // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                      textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ):Container(),
                            ],
                          ),
                        ),
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
  void _load() {
    widget._dashboardBloc.add(LoadDashboardEvent());
  }
}
