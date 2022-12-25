import 'package:flutter/material.dart';
import 'package:vendor_app/modules/payment/payment/index.dart';

import '../../../models/service_request/service_list_model.dart';
import '../../../style/style.dart';
import '../../../utility/hex_color.dart';
import '../../dashboard/dashboard/dashboard_page.dart';

class PaymentPage extends StatefulWidget {
  static const String routeName = '/payment';

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _paymentBloc = PaymentBloc(UnPaymentState());
  late ServiceListModel serviceList;
  late String fromScreen;
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments  as Map;
    serviceList = arguments['selectedRequest'];
    fromScreen = arguments['fromScreen'];
    return Scaffold(
      appBar: AppBar(
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: (){
                if(fromScreen == 'ServiceReport'){
                Navigator.popAndPushNamed(context, DashboardPage.routeName);
              }else {
                Navigator.pop(context);
              }}
          ),
        backgroundColor: HexColor('ED8F2D'),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text('Payment',style: TextStyle(color: Colors.white,fontFamily: Style().font_medium(),fontSize: 16),),
      ),
      backgroundColor: HexColor('E5E5E5'),
      body: PaymentScreen(paymentBloc: _paymentBloc,serviceList:serviceList,fromScreen:fromScreen),
    );
  }
}
