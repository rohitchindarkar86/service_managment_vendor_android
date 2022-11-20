import 'package:flutter/material.dart';
import 'package:vendor_app/modules/payment/confirm_payment/index.dart';

import '../../../style/style.dart';
import '../../../utility/hex_color.dart';

class ConfirmPaymentPage extends StatefulWidget {
  static const String routeName = '/confirmPayment';

  @override
  _ConfirmPaymentPageState createState() => _ConfirmPaymentPageState();
}

class _ConfirmPaymentPageState extends State<ConfirmPaymentPage> {
  final _confirmPaymentBloc = ConfirmPaymentBloc(UnConfirmPaymentState());
  String fromClick = "";
  String captureCode = "";

  @override
  Widget build(BuildContext context) {
    // final arguments = ModalRoute.of(context)!.settings.arguments  as Map;
    // fromClick = arguments['fromClick'].toString();
    // captureCode = arguments['captureCode'].toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('ED8F2D'),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text('Complete Request',style: TextStyle(color: Colors.white,fontFamily: Style().font_medium(),fontSize: 16),),
      ),
      backgroundColor: HexColor('E5E5E5'),
      body: ConfirmPaymentScreen(confirmPaymentBloc: _confirmPaymentBloc,fromClick:fromClick,captureCode:captureCode),
    );
  }
}
