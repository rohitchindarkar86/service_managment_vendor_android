import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendor_app/modules/dashboard/inventory_add/index.dart';

class InventoryAddScreen extends StatefulWidget {
  const InventoryAddScreen({
    required InventoryAddBloc inventoryAddBloc,
    Key? key,
  })  : _inventoryAddBloc = inventoryAddBloc,
        super(key: key);

  final InventoryAddBloc _inventoryAddBloc;

  @override
  InventoryAddScreenState createState() {
    return InventoryAddScreenState();
  }
}

class InventoryAddScreenState extends State<InventoryAddScreen> {
  InventoryAddScreenState();

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
    return BlocBuilder<InventoryAddBloc, InventoryAddState>(
        bloc: widget._inventoryAddBloc,
        builder: (
          BuildContext context,
          InventoryAddState currentState,
        ) {
          if (currentState is UnInventoryAddState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorInventoryAddState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text('reload'),
                    onPressed: _load,
                  ),
                ),
              ],
            ));
          }
           if (currentState is InInventoryAddState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(currentState.hello),
                ],
              ),
            );
          }
          return Center(
              child: CircularProgressIndicator(),
          );
          
        });
  }

  void _load() {
    widget._inventoryAddBloc.add(LoadInventoryAddEvent());
  }
}
