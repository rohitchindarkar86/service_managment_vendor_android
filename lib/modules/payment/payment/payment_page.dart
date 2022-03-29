import 'package:flutter/material.dart';
import 'package:vendor_app/modules/payment/payment/index.dart';

import '../../../style/style.dart';
import '../../../utility/hex_color.dart';

class PaymentPage extends StatefulWidget {
  static const String routeName = '/payment';

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _paymentBloc = PaymentBloc(UnPaymentState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('ED8F2D'),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text('Payment',style: TextStyle(color: Colors.white,fontFamily: Style().font_medium(),fontSize: 16),),
      ),
      backgroundColor: HexColor('E5E5E5'),
      body: PaymentScreen(paymentBloc: _paymentBloc),
    );
  }
}
