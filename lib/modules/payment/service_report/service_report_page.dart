import 'package:flutter/material.dart';
import 'package:vendor_app/modules/payment/service_report/index.dart';

import '../../../style/style.dart';
import '../../../utility/hex_color.dart';

class ServiceReportPage extends StatefulWidget {
  static const String routeName = '/serviceReport';

  @override
  _ServiceReportPageState createState() => _ServiceReportPageState();
}

class _ServiceReportPageState extends State<ServiceReportPage> {
  final _serviceReportBloc = ServiceReportBloc(UnServiceReportState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('ED8F2D'),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text('Service Report',style: TextStyle(color: Colors.white,fontFamily: Style().font_medium(),fontSize: 16),),
      ),
      backgroundColor: HexColor('E5E5E5'),
      body: ServiceReportScreen(serviceReportBloc: _serviceReportBloc),
    );
  }
}
