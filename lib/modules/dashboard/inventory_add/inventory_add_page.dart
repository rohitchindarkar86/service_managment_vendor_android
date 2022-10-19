import 'package:flutter/material.dart';
import 'package:vendor_app/modules/dashboard/inventory_add/index.dart';

import '../../../models/service_request/service_list_model.dart';
import '../../../style/style.dart';
import '../../../utility/hex_color.dart';

class InventoryAddPage extends StatefulWidget {
  static const String routeName = '/inventoryAdd';

  @override
  _InventoryAddPageState createState() => _InventoryAddPageState();
}

class _InventoryAddPageState extends State<InventoryAddPage> {
  final _inventoryAddBloc = InventoryAddBloc(UnInventoryAddState());
  late ServiceListModel serviceList;
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments  as Map;
    serviceList = arguments['selectedRequest'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('ED8F2D'),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text('Invertory Add',style: TextStyle(color: Colors.white,fontFamily: Style().font_medium(),fontSize: 16),),
      ),
      body: InventoryAddScreen(inventoryAddBloc: _inventoryAddBloc,serviceList:serviceList),
    );
  }
}
