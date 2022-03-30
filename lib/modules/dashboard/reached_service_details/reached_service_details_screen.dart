import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor_app/modules/dashboard/reached_service_details/index.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../style/style.dart';
import '../../../utility/hex_color.dart';
import '../../../widgets/cancel_request_page.dart';
import '../../payment/confirm_payment/confirm_payment_page.dart';
import '../../payment/payment/payment_page.dart';

class ReachedServiceDetailsScreen extends StatefulWidget {
  const ReachedServiceDetailsScreen({
    required ReachedServiceDetailsBloc reachedServiceDetailsBloc,
    Key? key,
  })  : _reachedServiceDetailsBloc = reachedServiceDetailsBloc,
        super(key: key);

  final ReachedServiceDetailsBloc _reachedServiceDetailsBloc;

  @override
  ReachedServiceDetailsScreenState createState() {
    return ReachedServiceDetailsScreenState();
  }
}

class ReachedServiceDetailsScreenState extends State<ReachedServiceDetailsScreen> {
  ReachedServiceDetailsScreenState();
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
    return BlocConsumer<ReachedServiceDetailsBloc, ReachedServiceDetailsState>(
        bloc: widget._reachedServiceDetailsBloc,
        listener: (Context, currentState) {
          if (currentState is UnReachedServiceDetailsState) {}
          if (currentState is ErrorReachedServiceDetailsState) {}
          if (currentState is InReachedServiceDetailsState) {}
        },
        builder: (
          BuildContext context,
          ReachedServiceDetailsState currentState,
        ) {
          height = MediaQuery.of(context).size.height;
          return WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: Container(
              height: height,

              child: Column(
                children: [
                  SizedBox(height: 16,),
                  Expanded(
                      child:Container(

                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 16,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Amit Rane',
                                        style: TextStyle(fontSize: 14 ,fontFamily: Style().font_regular(),color: HexColor('#494949')  ),
                                      ),
                                      Text(
                                        '11:00 AM',
                                        style: TextStyle(fontSize: 14 ,fontFamily: Style().font_medium(),color:  HexColor('#000000')  ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8,),
                                  Container(
                                    width: MediaQuery.of(context).size.width *0.8,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '12/ 1301 Mira Apartment  lokhandwalAndheri Mumbai- 40043',
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 14 ,fontFamily: Style().font_regular(),color: HexColor('#494949')  ),
                                    ),
                                  ),
                                  SizedBox(height: 16,),
                                ],
                              ),
                            ),
                            SizedBox(height: 24,),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 16,),
                                  Container(
                                   child:   Text(
                                     'Job Details',
                                     style: TextStyle(fontSize: 16 ,fontFamily: Style().font_medium(),color: HexColor('#494949')  ),
                                   ),
                                  ),
                                  SizedBox(height: 16,),
                                  Row(
                                    children: [
                                      Expanded(child: Container(
                                        child:   Text(
                                          'Complaint ID',
                                          style: TextStyle(fontSize: 14 ,fontFamily: Style().font_medium(),color: HexColor('#000000').withOpacity(0.7)  ),
                                        ),
                                      )),
                                      Expanded(child: Container(
                                        child:   Text(
                                          '1234567801',
                                          style: TextStyle(fontSize: 14 ,fontFamily: Style().font_regular(),color: HexColor('#000000').withOpacity(0.5)  ),
                                        ),
                                      ))
                                    ],
                                  ),
                                  SizedBox(height: 8,),
                                  Row(
                                    children: [
                                      Expanded(child: Container(
                                        child:   Text(
                                          'Job Status',
                                          style: TextStyle(fontSize: 14 ,fontFamily: Style().font_medium(),color: HexColor('#000000').withOpacity(0.7)  ),
                                        ),
                                      )),
                                      Expanded(child: Container(
                                        child:   Text(
                                          'On Going',
                                          style: TextStyle(fontSize: 14 ,fontFamily: Style().font_regular(),color: HexColor('#000000').withOpacity(0.5)  ),
                                        ),
                                      ))
                                    ],
                                  ),
                                  SizedBox(height: 8,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(child: Container(
                                        child:   Text(
                                          'Service Request',
                                          style: TextStyle(fontSize: 14 ,fontFamily: Style().font_medium(),color: HexColor('#000000').withOpacity(0.7)  ),
                                        ),
                                      )),
                                      Expanded(child: Container(
                                        child:   Text(
                                          'AC NOT WORKING\nFan and Cooling not happening',
                                          style: TextStyle(fontSize: 14 ,fontFamily: Style().font_regular(),color: HexColor('#000000').withOpacity(0.5)  ),
                                        ),
                                      ))
                                    ],
                                  ),
                                  SizedBox(height: 16,),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                  ),
                  SizedBox(height: 8,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child:   Container(
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            child: ElevatedButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                cancelRequestBottomSheet(context:context,height: 450);

                              },
                              style: ElevatedButton.styleFrom(
                                  primary: HexColor('ea4747'),
                                  // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        SizedBox(width: 8,),
                        Expanded(
                          child:   Container(
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            child: ElevatedButton(
                              child: Text('Complete'),
                              onPressed: () {
                                completeRequestBottomSheet(context: context,height: 300);
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: HexColor('008d00'),
                                  // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 8,),
                ],
              ),
            ),
          );
          
        });
  }
  cancelRequestBottomSheet({
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
            child: Padding(
                padding: MediaQuery.of(context).viewInsets,
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
                          child: Lottie.asset('assets/lottie_anim/complete_check.json')),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Are you sure wanted to cancel request?',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: Style().font_bold(),
                              color: Theme.of(context).colorScheme.onSecondary),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        alignment: Alignment.centerLeft,
                        child:Text('Cancel Reason',style: TextStyle(fontFamily: Style().font_medium(),fontSize: 14,color: HexColor('252222').withOpacity(0.50)),),
                      ),
                      Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: HexColor('464646').withOpacity(0.3)),

                    ),
                    child:TextFormField(
                      cursorColor: Colors.black,
                      minLines: 3,
                      maxLines: 3,
                      decoration:  InputDecoration(
                        contentPadding: EdgeInsets.only(left: 12,),
                        fillColor: HexColor('ED8F2D'),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: HexColor('ED8F2D')),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: HexColor('ED8F2D')),
                        ),

                      ),
                      style: TextStyle(
                        fontFamily: Style().font_regular(),
                        fontSize: 16,
                        color:  Colors.black,),
                      keyboardType: TextInputType.text,
                      // controller: EmailController,
                    )
                ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        child: ElevatedButton(
                          child: Text('Yes'),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, CancelRequestPage.routeName);
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
                        height: 4,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        alignment: Alignment.center,
                        child:
                        GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Text('Close',style: TextStyle(fontFamily: Style().font_medium(),fontSize: 14,color: HexColor('252222').withOpacity(0.75)),)),
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
            ),
          );
        });
  }

  completeRequestBottomSheet({
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
                        height: 120,
                        child: Lottie.asset('assets/lottie_anim/qr_code_confirm.json')),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Any Qr Code of your company there on appliance?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: Style().font_bold(),
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                    ),

                    Expanded(child: Container(),),
                    Container(

                      child: Row(
                        children: [
                          Expanded(
                            child:  Container(
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              child: ElevatedButton(
                                child: Text('Yes'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, '/qrScanner',arguments: {"fromClick":"Yes"});
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: HexColor('ED8F2D'),
                                    // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          SizedBox(width: 8,),
                          Expanded(
                            child:  Container(
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              child: ElevatedButton(
                                child: Text('No'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, ConfirmPaymentPage.routeName,arguments: {"fromClick":"No"});
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: HexColor('ED8F2D'),
                                    // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          )
                        ],
                      ),
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
    widget._reachedServiceDetailsBloc.add(LoadReachedServiceDetailsEvent());
  }
}
