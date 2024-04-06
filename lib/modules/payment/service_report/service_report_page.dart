import 'package:flutter/material.dart';
import 'package:vendor_app/modules/payment/service_report/index.dart';

import '../../../models/service_request/service_list_model.dart';
import '../../../style/style.dart';
import '../../../utility/hex_color.dart';

class ServiceReportPage extends StatefulWidget {
  static const String routeName = '/serviceReport';

  const ServiceReportPage({Key? key}) : super(key: key);

  @override
  _ServiceReportPageState createState() => _ServiceReportPageState();
}

class _ServiceReportPageState extends State<ServiceReportPage> {
  final _serviceReportBloc = ServiceReportBloc(UnServiceReportState());
  late ServiceListModel serviceList;
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments  as Map;
    serviceList = arguments['selectedRequest'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('ED8F2D'),
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text('Service Report',style: TextStyle(color: Colors.white,fontFamily: Style().font_medium(),fontSize: 16),),
      ),
      backgroundColor: HexColor('E5E5E5'),
      body: ServiceReportScreen(serviceReportBloc: _serviceReportBloc,serviceList:serviceList),
    );
  }
}
