import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendor_app/modules/payment/payment/index.dart';

import '../../../models/master/action_taken_master_model.dart';
import '../../../models/service_request/action_taken_model.dart';
import '../../../style/style.dart';
import '../../../utility/hex_color.dart';
import '../../../widgets/success_request_page.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    required PaymentBloc paymentBloc,
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
          if (currentState is ErrorPaymentState) {}
          if (currentState is InPaymentState) {}
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

              child: Column(
                children: [
                  SizedBox(height: 16,),
                  Expanded(
                      child:SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [

                              SizedBox(height: 16,),
                              Container(
                                alignment: Alignment.centerLeft,
                                child:  Text(
                                  'Billing Details',
                                  style: TextStyle(fontSize: 16 ,fontFamily: Style().font_medium(),color: HexColor('#000000')  ),
                                ),
                              ),
                              SizedBox(height: 6,),
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
                                        'Summary',
                                        style: TextStyle(fontSize: 16 ,fontFamily: Style().font_medium(),color: HexColor('#494949')  ),
                                      ),
                                    ),
                                    SizedBox(height: 16,),
                                    Row(
                                      children: [
                                        Expanded(child: Container(
                                          child:   Text(
                                            'Service Charge',
                                            style: TextStyle(fontSize: 14 ,fontFamily: Style().font_regular(),color: HexColor('#000000').withOpacity(0.7)  ),
                                          ),
                                        )),
                                        Container(
                                          child:   Text(
                                            'Rs. ${serviceAmt}',
                                            style: TextStyle(fontSize: 14 ,fontFamily: Style().font_regular(),color: HexColor('#000000').withOpacity(0.5)  ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 8,),
                                    Row(
                                      children: [
                                        Expanded(child: Container(
                                          child:   Text(
                                            'Extra Service Charge',
                                            style: TextStyle(fontSize: 14 ,fontFamily: Style().font_regular(),color: HexColor('#000000').withOpacity(0.7)  ),
                                          ),
                                        )),
                                        Container(
                                          child:   Text(
                                            'Rs. ${extraServiceAmt}',
                                            style: TextStyle(fontSize: 14 ,fontFamily: Style().font_regular(),color: HexColor('#000000').withOpacity(0.5)  ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 16,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(child: Container(
                                          child:   Text(
                                            'Total Amount',
                                            style: TextStyle(fontSize: 16 ,fontFamily: Style().font_bold(),color: HexColor('#000000').withOpacity(0.7)  ),
                                          ),
                                        )),

                                        Container(
                                          child:   Text(
                                            'Rs. ${totalAmt}',
                                            style: TextStyle(fontSize: 16 ,fontFamily: Style().font_bold(),color: HexColor('#000000').withOpacity(0.7)  ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 16,),
                                    Container(
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
                              )
                            ],
                          ),
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
                              child: Text('Continue'),
                              onPressed: () {
                                Navigator.pushNamed(context, SuccessRequestPage.routeName);
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

}
