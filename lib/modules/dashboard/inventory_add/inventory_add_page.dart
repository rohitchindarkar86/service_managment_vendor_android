import 'package:flutter/material.dart';
import 'package:vendor_app/modules/dashboard/inventory_add/index.dart';

class InventoryAddPage extends StatefulWidget {
  static const String routeName = '/inventoryAdd';

  @override
  _InventoryAddPageState createState() => _InventoryAddPageState();
}

class _InventoryAddPageState extends State<InventoryAddPage> {
  final _inventoryAddBloc = InventoryAddBloc(UnInventoryAddState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('InventoryAdd'),
      ),
      body: InventoryAddScreen(inventoryAddBloc: _inventoryAddBloc),
    );
  }
}
