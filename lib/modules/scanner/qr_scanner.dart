

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../style/style.dart';
import '../../utility/hex_color.dart';
import '../payment/confirm_payment/confirm_payment_page.dart';

class QRScanner extends StatefulWidget {
  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isCapturedOnce = false;
  String? fromClick;
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments  as Map;
    fromClick = arguments['fromClick'].toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('ED8F2D'),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text('Qr Scanner',style: TextStyle(color: Colors.white,fontFamily: Style().font_medium(),fontSize: 16),),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            alignment: Alignment.center,
            color:  HexColor('ED8F2D'),
              child: Text('Please Scan Our Company Qr Code On Appliance.',style: TextStyle(fontSize: 16,color: HexColor('FFFFFF'),fontFamily: Style().font_medium()),)
          ),
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;

        if(describeEnum(result!.format).toString() == 'qrcode'){

          if(result!.code.toString().contains('PYSAPP')){
            print('${describeEnum(result!.format)}   Data: ${result!.code}');
            if(!isCapturedOnce) {
              isCapturedOnce = true;
              if(fromClick=="Yes") {
                Navigator.pop(context);
                Navigator.pushNamed(context, ConfirmPaymentPage.routeName,arguments: {"fromClick":"Yes","captureCode":result!.code.toString()});
              }else{
                Navigator.pop(context, result!.code.toString());
              }
            }
          }else{
            print('Wrong QR'+result!.code.toString());
          }
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
