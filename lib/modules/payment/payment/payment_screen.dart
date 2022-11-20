import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor_app/modules/payment/payment/index.dart';

import '../../../models/master/action_taken_master_model.dart';
import '../../../models/service_request/action_taken_model.dart';
import '../../../models/service_request/service_list_model.dart';
import '../../../style/style.dart';
import '../../../utility/hex_color.dart';
import '../../../widgets/AppLoader.dart';
import '../../../widgets/success_request_page.dart';

class PaymentScreen extends StatefulWidget {
  final ServiceListModel serviceList;
  const PaymentScreen({
    required PaymentBloc paymentBloc,
    required this.serviceList,
    Key? key,
  })  : _paymentBloc = paymentBloc,
        super(key: key);

  final PaymentBloc _paymentBloc;

  @override
  PaymentScreenState createState() {
    return PaymentScreenState();
  }
}

class PaymentScreenState extends State<PaymentScreen> {
  PaymentScreenState();

  double? height;

  int _paymentRadioValue1=0;
  double? serviceAmt = 499;
  double? extraServiceAmt = 0;
  double? totalAmt = 0;
  bool isApiCall = false;
  bool isQRCode = false;
  String QrCodeUrl = '';
  String QrId = '';
  @override
  void initState() {
    super.initState();
    totalAmt = (serviceAmt! + extraServiceAmt!);

    _load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentBloc, PaymentState>(
        listener: (Context, currentState) {
          if (currentState is UnPaymentState) {}
          if (currentState is ErrorPaymentState) {
            isApiCall = false;
          }
          if (currentState is InPaymentState) {}
          if (currentState is LoaderPaymentState) {
            isApiCall = true;
          }
          if (currentState is UpdateRazaroPayState) {
            isApiCall = false;
            isQRCode = true;
            QrCodeUrl = currentState.razorQRCode;
            QrId = currentState.razorQRCode_id;
          }

        },
        bloc: widget._paymentBloc,
        builder: (
          BuildContext context,
          PaymentState currentState,
        ) {
          height = MediaQuery.of(context).size.height;
          return WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: Container(
              height: height,

              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 16,),
                      Expanded(
                          child:SingleChildScrollView(
                            child:!isQRCode ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: [

                                  SizedBox(height: 16,),

                                  SizedBox(height: 6,),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    color: Colors.white,
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        SizedBox(height: 16,),
                                        Container(

                                          child:   Text(
                                            'Rs. ${totalAmt}',
                                            style: TextStyle(fontSize: 26 ,fontFamily: Style().font_regular(),color: HexColor('#000000').withOpacity(0.7)  ),
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                        Container(

                                          child:   Text(
                                            'Total Amount Payable',
                                            style: TextStyle(fontSize: 14 ,fontFamily: Style().font_regular(),color: HexColor('#000000').withOpacity(0.7)  ),
                                          ),),


                                        SizedBox(height: 36,),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child:   Text(
                                            'Payment Mode',
                                            style: TextStyle(fontSize: 16 ,fontFamily: Style().font_bold(),color: HexColor('#000000').withOpacity(0.7)  ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,

                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              new Radio(
                                                value: 0,
                                                fillColor: MaterialStateColor.resolveWith((states) =>  HexColor('ED8F2D')),
                                                activeColor: HexColor('ED8F2D'),
                                                groupValue: _paymentRadioValue1,
                                                onChanged: (val){
                                                  _paymentRadioValueChange(val);
                                                },
                                              ),
                                              new Text(
                                                'Cash',
                                                style: new TextStyle(fontSize: 16.0),
                                              ),
                                              new Radio(
                                                value: 1,
                                                fillColor: MaterialStateColor.resolveWith((states) =>  HexColor('ED8F2D')),
                                                activeColor: HexColor('ED8F2D'),
                                                groupValue: _paymentRadioValue1,
                                                onChanged: (val){ _paymentRadioValueChange(val);},
                                              ),
                                              new Text(
                                                'Online',
                                                style: new TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 16,),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ):
                            Container(
                              height: height! * 0.8,
                              child:  Image.network(QrCodeUrl),
                            )

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
                                  child: Text('Continue'),
                                  onPressed: () {
                                    if(!isQRCode) {
                                      paymentConfirmBottomSheet(
                                        context: context,
                                        height: height! * 0.35,);
                                    }else{
                                      widget._paymentBloc.add(
                                          PaymentCheckRequestEvent(QrId));
                                    }

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

                      SizedBox(height: 8,),
                    ],
                  ),
                  isApiCall ? AppLoader() : Container(),
                ],
              )
            ),
          );
          
        });
  }

  _paymentRadioValueChange(value){
    setState(() {
      _paymentRadioValue1 = value;
    });

  }

  void _load() {

  }

  paymentConfirmBottomSheet({
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
                        child: Lottie.asset('assets/lottie_anim/complete_check.json')),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Are you Sure want to proceed to payment?',
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
                                  if(_paymentRadioValue1 == 0){
                                    Navigator.pushNamed(context, SuccessRequestPage.routeName);
                                  }else {
                                    widget._paymentBloc.add(
                                        PaymentGenerateRequestEvent(
                                            widget.serviceList
                                                .serviceRequestCode!,
                                            widget.serviceList
                                                .serviceRequestDetailCode!,
                                            widget.serviceList
                                                .serviceRequestSeriesCode!,
                                            499));
                                  }                                },
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

}
