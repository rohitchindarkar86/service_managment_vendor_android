import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor_app/modules/payment/payment/index.dart';
import 'package:vendor_app/utility/app_constant.dart';
import '../../../models/service_request/service_list_model.dart';
import '../../../style/style.dart';
import '../../../utility/app_utility.dart';
import '../../../utility/hex_color.dart';
import '../../../widgets/AppLoader.dart';
import '../../../widgets/success_request_page.dart';
import '../../dashboard/dashboard/dashboard_page.dart';

class PaymentScreen extends StatefulWidget {
  final ServiceListModel serviceList;
  final String fromScreen;
  const PaymentScreen({
    required PaymentBloc paymentBloc,
    required this.serviceList,
    required this.fromScreen,
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
  double totalAmt = 0;
  double gstAmt = 0;
  double subTotalAmt = 0;
  bool isApiCall = false;
  bool isQRCode = false;
  String QrCodeUrl = '';
  String QrId = '';
  String btnText = 'Continue';
  var orderDetails;
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
    return BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, currentState) {
          if (currentState is UnPaymentState) {}
          if (currentState is ErrorPaymentState) {
            isApiCall = false;
          }
          if (currentState is InPaymentState) {}
          if (currentState is LoaderPaymentState) {
            isApiCall = true;
          }
          if (currentState is UpdateRazaroPayState) {
            btnText = "Check Payment Status";
            isApiCall = false;
            isQRCode = true;
            QrCodeUrl = currentState.razorQRCode;
            QrId = currentState.razorQRCode_id;
          }
          if (currentState is PaymentCheckRazaroPayState) {
            isApiCall = false;
            if(currentState.statusCode == -1){
              AppUtility.showToast("Payment Qr Expired.Please try again.");
              Navigator.pop(context);
            }else if(currentState.statusCode == 0){
              AppUtility.showToast("Payment in Process. Please try again after client payment done");
            } else if(currentState.statusCode == 1){
              AppUtility.showToast("Payment Done.");
              widget._paymentBloc.add(UpdateServiceRequestStatusEvent(widget.serviceList.serviceRequestCode!,11));
            }
          }
          if (currentState is UpdateSuccessServiceStatusState) {
            isApiCall = false;
            Navigator.pushReplacementNamed(context, SuccessRequestPage.routeName);
            // Navigator.pushNamedAndRemoveUntil(context, DashboardPage.routeName, (route) => false);
          }
          if (currentState is PaymentDetailsState) {
            isApiCall = false;
            if(currentState.amountDetails != null && currentState.amountDetails.length > 0) {
              orderDetails = currentState.amountDetails;
              for (int i = 0; i < currentState.amountDetails.length; i++) {
                subTotalAmt = subTotalAmt + (double.parse(currentState.amountDetails[i]['part_Price'].toString())+ double.parse(currentState.amountDetails[i]['labour_Price'].toString()));
              }
              gstAmt = (subTotalAmt * (AppConstant.gst_percentage! / 100));
              totalAmt = subTotalAmt + gstAmt;
            }
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
              if(widget.fromScreen == 'ServiceReport'){
               Navigator.popAndPushNamed(context, DashboardPage.routeName);
              }else {
                Navigator.pop(context);
              }
              return true;
            },
            child: SizedBox(
              height: height,

              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 16,),
                      Expanded(
                          child:SingleChildScrollView(
                            child:!isQRCode ? Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: [

                                  const SizedBox(height: 16,),

                                  const SizedBox(height: 6,),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    color: Colors.white,
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        const SizedBox(height: 16,),
                                        Text(
                                          '₹ ${totalAmt.toStringAsFixed(2)}',
                                          style: TextStyle(fontSize: 26 ,fontFamily: Style().font_regular(),color: HexColor('#000000').withOpacity(0.7)  ),
                                        ),
                                        const SizedBox(height: 8,),
                                        Text(
                                          'Total Amount Payable',
                                          style: TextStyle(fontSize: 14 ,fontFamily: Style().font_regular(),color: HexColor('#000000').withOpacity(0.7)  ),
                                        ),


                                        const SizedBox(height: 36,),
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
                                              Radio(
                                                value: 0,
                                                fillColor: MaterialStateColor.resolveWith((states) =>  HexColor('ED8F2D')),
                                                activeColor: HexColor('ED8F2D'),
                                                groupValue: _paymentRadioValue1,
                                                onChanged: (val){
                                                  _paymentRadioValueChange(val);
                                                },
                                              ),
                                               Text(
                                                'Cash',
                                                style: TextStyle(fontSize: 16.0,color: HexColor('000000'),),
                                              ),
                                               Radio(
                                                value: 1,
                                                fillColor: MaterialStateColor.resolveWith((states) =>  HexColor('ED8F2D')),
                                                activeColor: HexColor('ED8F2D'),
                                                groupValue: _paymentRadioValue1,
                                                onChanged: (val){ _paymentRadioValueChange(val);},
                                              ),
                                              Text(
                                                'Online',
                                                style: TextStyle(fontSize: 16.0,color: HexColor('000000'),),
                                              ),

                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 16,),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    color: Colors.white,
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        const SizedBox(height: 16,),

                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child:   Text(
                                            'Payment Details',
                                            style: TextStyle(fontSize: 16 ,fontFamily: Style().font_bold(),color: HexColor('#000000').withOpacity(0.7)  ),
                                          ),
                                        ),
                                        orderDetails  != null ?ListView.builder(   physics: const AlwaysScrollableScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          itemBuilder: complaintList,
                                          itemCount: orderDetails.length ??0,):const SizedBox(),

                                        const SizedBox(height: 8,),
                                        const Divider(height: 1,thickness: 1,color: Colors.black26,),
                                        const SizedBox(height: 16,),
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          margin: const EdgeInsets.only(right: 8),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  const Expanded(child: Text('Sub Total ')),
                                                  Text("₹ ${subTotalAmt.toStringAsFixed(2)}"),
                                                ],
                                              ),
                                              const SizedBox(height: 4,),
                                              Row(
                                                children: [
                                                  Expanded(child: Text('GST ${AppConstant.gst_percentage}%')),
                                                  Text("₹ ${gstAmt.toStringAsFixed(2)}"),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        const SizedBox(height: 8,),
                                        const Divider(height: 1,thickness: 1,color: Colors.black26,),
                                        const SizedBox(height: 16,),
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          margin: const EdgeInsets.only(right: 8),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  const Expanded(child: Text('Total')),
                                                  Text("₹ ${totalAmt.toStringAsFixed(2)}"),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        
                                        const SizedBox(height: 16,),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ):
                            SizedBox(
                              height: height! * 0.8,
                              child:  Image.network(QrCodeUrl),
                            )

                          )
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child:   SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 45,
                                child: ElevatedButton(
                                  child: Text(btnText),
                                  onPressed: () {

                                      if (!isQRCode) {
                                        paymentConfirmBottomSheet(
                                          context: context,
                                          height: height! * 0.35,);
                                      } else {
                                        print('Payment Status');
                                        widget._paymentBloc.add(
                                            PaymentCheckRequestEvent(QrId,widget.serviceList));
                                      }

                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: HexColor('ED8F2D'),
                                      // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                      textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(height: 8,),
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
    widget._paymentBloc.add(PaymentDetailsEvent(widget.serviceList));
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
                : const Color(0xFF737373),
            child: Container(
                height: height,
                padding:
                const EdgeInsets.only(left: 24, right: 20, top: 14, bottom: 0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      color: HexColor('#CED3DB'),
                      height: 4,
                      width: 64,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                        height: 120,
                        child: Lottie.asset('assets/lottie_anim/complete_check.json')),
                    const SizedBox(
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
                    Row(
                      children: [
                        Expanded(
                          child:  SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            child: ElevatedButton(
                              child: const Text('Yes'),
                              onPressed: () {
                                Navigator.pop(context);
                                if(_paymentRadioValue1 == 0){
                                  widget._paymentBloc.add(UpdateServiceRequestStatusEvent(widget.serviceList.serviceRequestCode!,11));
                                }else {
                                  widget._paymentBloc.add(
                                      PaymentGenerateRequestEvent(
                                          widget.serviceList
                                              .serviceRequestCode!,
                                          widget.serviceList
                                              .serviceRequestDetailCode!,
                                          widget.serviceList
                                              .serviceRequestSeriesCode!,
                                          totalAmt!));
                                }                                },
                              style: ElevatedButton.styleFrom(
                                  primary: HexColor('ED8F2D'),
                                  // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8,),
                        Expanded(
                          child:  SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            child: ElevatedButton(
                              child: const Text('No'),
                              onPressed: () {
                                Navigator.pop(context);

                              },
                              style: ElevatedButton.styleFrom(
                                  primary: HexColor('ED8F2D'),
                                  // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                  ],
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                )),
          );
        });
  }

  Widget complaintList(BuildContext context, int index) {
    return Container(
      margin: const EdgeInsets.only(top: 16, right: 8, left: 0),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text((index+1).toString() +'. '+ orderDetails[index]['part_Description'].toString(),),
            ),
            Text('₹ ${(double.parse(orderDetails[index]['part_Price'].toString())+ double.parse(orderDetails[index]['labour_Price'].toString())).toStringAsFixed(2)}')
          ]),
    );
  }


}
